import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/presentation/widgets/signature_stub.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';

Future<StudentAnecdotal?> showWriteAnecdotalDialog(
  BuildContext context, {
  required UserAccount student,
}) {
  return showDialog<StudentAnecdotal>(
    context: context,
    builder: (_) => _WriteAnecdotalDialog(student: student),
  );
}

class _WriteAnecdotalDialog extends HookConsumerWidget {
  const _WriteAnecdotalDialog({required this.student});

  final UserAccount student;

  static const categories = [
    'Behavior',
    'Academic',
    'Achievement',
    'Attendance',
    'Other',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? me = ref.watch(authProvider);
    final List<UserAccount> allUsers = ref.watch(userAccountsProvider);

    final ValueNotifier<String> category = useState<String>(categories.first);
    final ValueNotifier<DateTime> observedAt = useState<DateTime>(
      DateTime.now(),
    );
    final TextEditingController narrativeCtrl = useTextEditingController();
    final ValueNotifier<Map<String, String>> errors =
        useState<Map<String, String>>(const {});
    final ValueNotifier<bool> submitting = useState(false);

    Future<void> submit() async {
      final e = <String, String>{};
      if (narrativeCtrl.text.trim().isEmpty) {
        e['narrative'] = 'Narrative is required.';
      }
      if (me == null) e['_auth'] = 'Not logged in.';
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }
      errors.value = const {};
      submitting.value = true;

      final entry = StudentAnecdotal(
        id: 'anec-${DateTime.now().microsecondsSinceEpoch}',
        studentId: student.id,
        authorUserId: me!.id,
        authorFullName: me.fullName,
        observedAt: observedAt.value,
        category: category.value,
        narrative: narrativeCtrl.text.trim(),
        authorSignatureDataUrl: stubSignatureDataUrl,
      );

      await ref.read(studentAnecdotalsProvider.notifier).add(entry);

      // Notify: the student and their parents.
      final recipients = <String>{student.id};

      // Parents of this student.
      for (final u in allUsers) {
        final UserProfile p = u.profile;
        if (p is ParentProfile && p.childIds.contains(student.id)) {
          recipients.add(u.id);
        }
      }

      // Never notify the author.
      recipients.remove(me.id);

      if (recipients.isNotEmpty) {
        ref
            .read(appNotificationsProvider.notifier)
            .notifyMany(
              toUserIds: recipients,
              fromUserId: me.id,
              message:
                  'New ${entry.category.toLowerCase()} anecdotal entry '
                  'for ${student.fullName}.',
            );
      }

      submitting.value = false;
      if (context.mounted) Navigator.of(context).pop(entry);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Write anecdotal entry',
                          style: context.textTheme.titleLarge,
                        ),
                        Text(
                          student.fullName,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
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
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: category.value,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              prefixIcon: Icon(Icons.label_outline_rounded),
                            ),
                            items: [
                              for (final c in categories)
                                DropdownMenuItem(value: c, child: Text(c)),
                            ],
                            onChanged: (v) {
                              if (v != null) category.value = v;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: observedAt.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) observedAt.value = picked;
                            },
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Observed on',
                                prefixIcon: Icon(Icons.event_rounded),
                              ),
                              child: Text(_fmtDate(observedAt.value)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: narrativeCtrl,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: 'Narrative',
                        hintText:
                            'What did you observe? What was the context, '
                            'and what action did you take?',
                        alignLabelWithHint: true,
                        errorText: errors.value['narrative'],
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
                    onPressed: submitting.value
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: submitting.value ? null : submit,
                    child: submitting.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save entry'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
