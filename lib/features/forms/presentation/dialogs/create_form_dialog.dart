import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/forms/form_helpers.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide Form;

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_notifier.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';

Future<Form?> showCreateFormDialog(
  BuildContext context, {
  required FormType type,
}) {
  return showDialog<Form>(
    context: context,
    builder: (_) => _CreateFormDialog(type: type),
  );
}

class _CreateFormDialog extends HookConsumerWidget {
  const _CreateFormDialog({required this.type});

  final FormType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UserAccount> users = ref.watch(userAccountsProvider);
    final UserAccount? me = ref.watch(authProvider);

    final List<UserAccount> teachers = users
        .where((u) => u.profile is TeacherProfile && !u.isArchived)
        .toList(growable: false);
    final List<UserAccount> allStudents = users
        .where((u) => u.profile is StudentProfile && !u.isArchived)
        .toList(growable: false);

    // Home visitation requires a linked parent — a form without one can
    // never complete because the parent is a required signer.
    final List<UserAccount> studentsWithParent = allStudents
        .where(
          (s) => users.any(
            (u) =>
                !u.isArchived &&
                u.profile is ParentProfile &&
                (u.profile as ParentProfile).childIds.contains(s.id),
          ),
        )
        .toList(growable: false);

    // For home visitation only students with a parent qualify. For
    // violations any student does (parent isn't a participant).
    final List<UserAccount> students = type == FormType.homeVisitation
        ? studentsWithParent
        : allStudents;

    final ValueNotifier<String?> teacherId = useState<String?>(
      teachers.isNotEmpty ? teachers.first.id : null,
    );
    final ValueNotifier<Set<String>> studentIds = useState<Set<String>>(
      <String>{},
    );
    final ValueNotifier<Map<String, String>> errors =
        useState<Map<String, String>>(const {});

    Future<void> submit() async {
      final e = <String, String>{};
      if (teacherId.value == null) e['teacher'] = 'Pick a teacher.';
      if (type == FormType.violation && studentIds.value.isEmpty) {
        e['students'] = 'Pick at least one student.';
      }
      if (type == FormType.homeVisitation && studentIds.value.length != 1) {
        e['students'] = 'Pick exactly one student.';
      }
      if (me == null) e['_auth'] = 'Not logged in.';
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }

      final UserAccount teacher = teachers.firstWhere(
        (t) => t.id == teacherId.value,
      );
      final List<UserAccount> chosenStudents = students
          .where((s) => studentIds.value.contains(s.id))
          .toList();

      final id = '${DateTime.now().millisecondsSinceEpoch}';
      final now = DateTime.now();

      // Read the inventory of the selected student (home visitation only).
      StudentIndividualInventory? inventory;
      if (type == FormType.homeVisitation) {
        final String studentId = chosenStudents.single.id;
        inventory = ref
            .read(studentInventoriesProvider)
            .where((inv) => inv.studentId == studentId)
            .firstOrNull;
      }

      // Guard against state that would otherwise throw during the build.
      // Prefer to surface the problem as a validation error so the user
      // sees it in the dialog, not as a crash.
      UserAccount? parent;
      UserAccount? juniorPrincipal;
      UserAccount? seniorPrincipal;
      if (type == FormType.homeVisitation) {
        final String studentId = chosenStudents.single.id;
        parent = _findParentUserOrNull(studentId, users);
        juniorPrincipal = _findPrincipalOrNull(
          users,
          PrincipalPosition.juniorHigh,
        );
        seniorPrincipal = _findPrincipalOrNull(
          users,
          PrincipalPosition.seniorHigh,
        );

        if (parent == null) {
          errors.value = {
            'students':
                'This student has no linked parent. Link a parent before '
                'creating a home visitation form.',
          };
          return;
        }
        if (juniorPrincipal == null || seniorPrincipal == null) {
          errors.value = {
            'students':
                'The school has no Junior/Senior High School Principal. '
                'Ask an admin to create them before home visitation forms '
                'can be issued.',
          };
          return;
        }
      }

      errors.value = const {};

      final Form form = type == FormType.violation
          ? buildViolationForm(
              formId: id,
              now: now,
              createdBy: me!,
              teacher: teacher,
              students: chosenStudents,
            )
          : buildHomeVisitationForm(
              formId: id,
              now: now,
              createdBy: me!,
              teacher: teacher,
              student: chosenStudents.single,
              parent: parent!,
              juniorPrincipal: juniorPrincipal!,
              seniorPrincipal: seniorPrincipal!,
              inventory: inventory,
            );

      await ref.read(formsProvider.notifier).add(form);

      ref
          .read(auditLogsProvider.notifier)
          .log(
            userAccountId: me.id,
            userFullName: me.fullName,
            action: 'Create Form',
            description:
                '${me.fullName} created ${form.displayId} (${type.label}).',
          );

      // Notify every participant except the creator.
      final List<String> notifyIds = form.participants
          .where((p) => p != me.id)
          .toList();
      if (notifyIds.isNotEmpty) {
        ref
            .read(appNotificationsProvider.notifier)
            .notifyMany(
              toUserIds: notifyIds,
              fromUserId: me.id,
              message:
                  'A new ${type.label} (${form.displayId}) needs your attention.',
            );
      }

      if (context.mounted) Navigator.of(context).pop(form);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Create ${type.label}',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: teacherId.value,
                      decoration: InputDecoration(
                        labelText: 'Teacher',
                        prefixIcon: const Icon(Icons.co_present_rounded),
                        errorText: errors.value['teacher'],
                      ),
                      items: [
                        for (final t in teachers)
                          DropdownMenuItem(
                            value: t.id,
                            child: Text(t.fullName),
                          ),
                      ],
                      onChanged: (v) => teacherId.value = v,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      type == FormType.violation
                          ? 'Students involved'
                          : 'Student',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    if (students.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          type == FormType.homeVisitation
                              ? 'No students with a linked parent. Link a parent to a '
                                    'student from Students → (student) → Parents, or via '
                                    'User Accounts → add parent.'
                              : 'No students available.',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(maxHeight: 260),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          if (type == FormType.homeVisitation) ...[
                            RadioGroup<String>(
                              groupValue: studentIds.value.isEmpty
                                  ? null
                                  : studentIds.value.first,
                              onChanged: (v) {
                                if (v == null) return;
                                studentIds.value = {v};
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (final s in students)
                                    RadioListTile<String>(
                                      dense: true,
                                      value: s.id,
                                      title: Text(s.fullName),
                                      subtitle: Text(s.email),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                ],
                              ),
                            ),
                          ] else ...[
                            // Multi-select: checkboxes stay the same
                            for (final s in students)
                              CheckboxListTile(
                                dense: true,
                                title: Text(s.fullName),
                                subtitle: Text(s.email),
                                value: studentIds.value.contains(s.id),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (v) {
                                  final next = Set<String>.from(
                                    studentIds.value,
                                  );
                                  if (v ?? false) {
                                    next.add(s.id);
                                  } else {
                                    next.remove(s.id);
                                  }
                                  studentIds.value = next;
                                },
                              ),
                          ],
                        ],
                      ),
                    ),
                    if (errors.value['students'] != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        errors.value['students']!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(onPressed: submit, child: const Text('Create')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  UserAccount? _findParentUserOrNull(
    String studentId,
    List<UserAccount> users,
  ) {
    for (final u in users) {
      if (u.isArchived) continue;
      final UserProfile p = u.profile;
      if (p is ParentProfile && p.childIds.contains(studentId)) return u;
    }
    return null;
  }

  UserAccount? _findPrincipalOrNull(
    List<UserAccount> users,
    PrincipalPosition pos,
  ) {
    for (final u in users) {
      if (u.isArchived) continue;
      final UserProfile p = u.profile;
      if (p is PrincipalProfile && p.position == pos) return u;
    }
    return null;
  }
}
