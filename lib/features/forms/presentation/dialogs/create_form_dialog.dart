import 'package:flutter_gms_demo/core/models/user_account.dart';
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
    final List<UserAccount> students = users
        .where((u) => u.profile is StudentProfile && !u.isArchived)
        .toList(growable: false);

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
      final List<String> studentNames = chosenStudents
          .map((s) => s.fullName)
          .toList();

      final id = '${DateTime.now().millisecondsSinceEpoch}';
      final now = DateTime.now();

      final Form form = type == FormType.violation
          ? Form(
              id: id,
              formType: FormType.violation,
              status: FormStatus.incomplete,
              createdByUserId: me!.id,
              createdAt: now,
              data: FormData.violation(
                teacherId: teacher.id,
                teacherName: teacher.fullName,
                studentIds: chosenStudents
                    .map((s) => s.id)
                    .toList(growable: false),
                studentNames: studentNames,
                guidanceId: me.id,
                guidanceName: me.fullName,
              ),
            )
          : _buildHomeVisitationForm(
              id: id,
              now: now,
              me: me!,
              teacher: teacher,
              student: chosenStudents.single,
            );

      await ref.read(formsProvider.notifier).add(form);

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
                          for (final s in students)
                            CheckboxListTile(
                              dense: true,
                              title: Text(s.fullName),
                              subtitle: Text(s.email),
                              value: studentIds.value.contains(s.id),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) {
                                final next = Set<String>.from(studentIds.value);
                                if (type == FormType.homeVisitation) {
                                  // Single-select
                                  if (v ?? false) {
                                    next
                                      ..clear()
                                      ..add(s.id);
                                  } else {
                                    next.remove(s.id);
                                  }
                                } else {
                                  if (v ?? false) {
                                    next.add(s.id);
                                  } else {
                                    next.remove(s.id);
                                  }
                                }
                                studentIds.value = next;
                              },
                            ),
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

  /// Prefills the home visitation form from the student profile.
  /// Centralized here so ApprovalForms (Batch 8) can reuse the same
  /// prefill logic instead of the duplicated block in the original.
  Form _buildHomeVisitationForm({
    required String id,
    required DateTime now,
    required dynamic me,
    required dynamic teacher,
    required dynamic student,
  }) {
    final profile = student.profile as StudentProfile;
    return Form(
      id: id,
      formType: FormType.homeVisitation,
      status: FormStatus.incomplete,
      createdByUserId: me.id,
      createdAt: now,
      data: FormData.homeVisitation(
        studentId: student.id,
        studentName: student.fullName,
        teacherId: teacher.id,
        teacherName: teacher.fullName,
        guidanceId: me.id,
        guidanceName: me.fullName,
        parentId: _findParentOf(student.id),
        parentName: _findParentNameOf(student.id),
        juniorPrincipalId: 'user-6',
        juniorPrincipalName: 'Junior Principal',
        seniorPrincipalId: 'user-7',
        seniorPrincipalName: 'Senior Principal',
        fields: {
          'student_surname': student.lastName,
          'student_firstname': student.firstName,
          'lrn': profile.lrn,
          'level_section': '${profile.gradeLevel.label} Mars',
        },
      ),
    );
  }

  String _findParentOf(String studentId) {
    // Returns the first parent user id that has this student as a child.
    // Uses a static lookup for the demo. Real implementation would
    // query the parents index.
    return 'user-4';
  }

  String _findParentNameOf(String studentId) => 'Pat Parent';
}
