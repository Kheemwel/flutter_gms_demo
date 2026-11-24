import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_notifier.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';

Future<FormRequest?> showNewRequestDialog(
  BuildContext context, {
  required FormType type,
}) {
  return showDialog<FormRequest>(
    context: context,
    builder: (_) => _NewRequestDialog(type: type),
  );
}

class _NewRequestDialog extends HookConsumerWidget {
  const _NewRequestDialog({required this.type});

  final FormType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UserAccount> users = ref.watch(userAccountsProvider);
    final UserAccount? me = ref.watch(authProvider);

    final List<UserAccount> allStudents = users
        .where((u) => u.profile is StudentProfile && !u.isArchived)
        .toList(growable: false);

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

    final List<UserAccount> students = type == FormType.homeVisitation
        ? studentsWithParent
        : allStudents;

    final ValueNotifier<Set<String>> studentIds = useState<Set<String>>(
      <String>{},
    );
    final TextEditingController reasonCtrl = useTextEditingController();
    final ValueNotifier<Map<String, String>> errors =
        useState<Map<String, String>>(const {});

    Future<void> submit() async {
      final e = <String, String>{};
      if (studentIds.value.isEmpty) {
        e['students'] = 'Pick at least one student.';
      }
      if (type == FormType.homeVisitation && studentIds.value.length != 1) {
        e['students'] = 'Pick exactly one student.';
      }
      if (reasonCtrl.text.trim().isEmpty) {
        e['reason'] = 'Explain the reason for this request.';
      }
      if (me == null) e['_auth'] = 'Not logged in.';
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }
      errors.value = const {};

      final List<UserAccount> chosen = students
          .where((s) => studentIds.value.contains(s.id))
          .toList();

      if (type == FormType.homeVisitation) {
        final UserAccount chosenStudent = chosen.single;
        final bool hasParent = users.any(
          (u) =>
              !u.isArchived &&
              u.profile is ParentProfile &&
              (u.profile as ParentProfile).childIds.contains(chosenStudent.id),
        );
        if (!hasParent) {
          errors.value = {
            'students':
                'This student has no linked parent. A home visitation request '
                'cannot be submitted until a parent is linked.',
          };
          return;
        }
      }

      final request = FormRequest(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        status: FormRequestStatus.pending,
        requestedByUserId: me!.id,
        createdAt: DateTime.now(),
        payload: type == FormType.violation
            ? FormRequestPayload.violation(
                teacherId: me.id,
                teacherName: me.fullName,
                studentIds: chosen.map((s) => s.id).toList(growable: false),
                studentNames: chosen
                    .map((s) => s.fullName)
                    .toList(growable: false),
                reason: reasonCtrl.text.trim(),
              )
            : FormRequestPayload.homeVisitation(
                teacherId: me.id,
                teacherName: me.fullName,
                studentId: chosen.single.id,
                studentName: chosen.single.fullName,
                reason: reasonCtrl.text.trim(),
              ),
      );

      await ref.read(formRequestsProvider.notifier).add(request);

      ref
          .read(auditLogsProvider.notifier)
          .log(
            userAccountId: me.id,
            userFullName: me.fullName,
            action: 'Request Form',
            description:
                '${me.fullName} submitted ${request.displayId} '
                '(${type.label}).',
          );

      // Notify guidance users.
      final List<String> guidanceIds = users
          .where((u) => u.profile is GuidanceProfile && !u.isArchived)
          .map((u) => u.id)
          .toList();
      if (guidanceIds.isNotEmpty) {
        ref
            .read(appNotificationsProvider.notifier)
            .notifyMany(
              toUserIds: guidanceIds,
              fromUserId: me.id,
              message:
                  'New ${type.label} request (${request.displayId}) from '
                  '${me.fullName}.',
            );
      }

      if (context.mounted) Navigator.of(context).pop(request);
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
                      'Request ${type.label}',
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
                    Text('Your name', style: context.textTheme.labelLarge),
                    const SizedBox(height: 4),
                    Text(
                      me?.fullName ?? '—',
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: reasonCtrl,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Reason',
                        hintText:
                            'What is the context guidance should know '
                            'before approving?',
                        alignLabelWithHint: true,
                        errorText: errors.value['reason'],
                      ),
                    ),
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
                  FilledButton(
                    onPressed: submit,
                    child: const Text('Submit request'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
