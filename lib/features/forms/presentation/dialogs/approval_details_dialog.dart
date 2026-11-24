import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide Form;

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/form_helpers.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_notifier.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';

Future<void> showApprovalDetails(
  BuildContext context, {
  required FormRequest request,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _ApprovalDetailsDialog(requestId: request.id),
  );
}

class _ApprovalDetailsDialog extends HookConsumerWidget {
  const _ApprovalDetailsDialog({required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FormRequest? req = ref.watch(
      formRequestsProvider.select(
        (list) => list.where((r) => r.id == requestId).firstOrNull,
      ),
    );
    if (req == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Navigator.of(context).maybePop();
      });
      return const SizedBox.shrink();
    }

    final bool canApprove = ref.can(Privilege.approveForm);
    final bool isMyOwnRequest =
        req.requestedByUserId == ref.read(authProvider)?.id;
    final bool canAct =
        canApprove &&
        !isMyOwnRequest &&
        req.status == FormRequestStatus.pending;

    final TextEditingController reasonCtrl = useTextEditingController();
    final ValueNotifier<String?> reasonError = useState<String?>(null);
    final ValueNotifier<bool> busy = useState(false);
    final ValueNotifier<bool> showRejectField = useState(false);

    Future<void> approve() async {
      busy.value = true;

      final List<UserAccount> users = ref.read(userAccountsProvider);
      final UserAccount me = ref.read(authProvider)!;

      final UserAccount teacher = users.firstWhere(
        (u) => u.id == req.payload.teacherId,
      );
      final formId = '${DateTime.now().millisecondsSinceEpoch}';

      Form? created;
      switch (req.payload) {
        case HomeVisitationRequestPayload p:
          final UserAccount student = users.firstWhere(
            (u) => u.id == p.studentId,
          );
          final UserAccount parent = users.firstWhere(
            (u) => u.profile is ParentProfile,
          );
          final UserAccount jrPrincipal = users.firstWhere(
            (u) =>
                u.profile is PrincipalProfile &&
                (u.profile as PrincipalProfile).position ==
                    PrincipalPosition.juniorHigh,
          );
          final UserAccount srPrincipal = users.firstWhere(
            (u) =>
                u.profile is PrincipalProfile &&
                (u.profile as PrincipalProfile).position ==
                    PrincipalPosition.seniorHigh,
          );

          final StudentIndividualInventory? inventory = ref
              .read(studentInventoriesProvider)
              .where((inv) => inv.studentId == student.id)
              .firstOrNull;

          created = buildHomeVisitationForm(
            formId: formId,
            now: DateTime.now(),
            createdBy: me,
            teacher: teacher,
            student: student,
            parent: parent,
            juniorPrincipal: jrPrincipal,
            seniorPrincipal: srPrincipal,
            inventory: inventory,
          );
        case ViolationRequestPayload p:
          final List<UserAccount> students = users
              .where((u) => p.studentIds.contains(u.id))
              .toList(growable: false);
          created = buildViolationForm(
            formId: formId,
            now: DateTime.now(),
            createdBy: me,
            teacher: teacher,
            students: students,
          );
      }

      await ref.read(formsProvider.notifier).add(created);

      await ref
          .read(formRequestsProvider.notifier)
          .markApproved(
            requestId: req.id,
            resultingFormId: created.id,
            approvedByUserId: me.id,
          );

      ref
          .read(auditLogsProvider.notifier)
          .log(
            userAccountId: me.id,
            userFullName: me.fullName,
            action: 'Approve Request',
            description:
                '${me.fullName} approved ${req.displayId} '
                '(${req.formType.label}) and created ${created.displayId}.',
          );

      // Notify the teacher and every student.
      final List<String> recipients = req.participantIds
          .where((id) => id != me.id)
          .toList();
      if (recipients.isNotEmpty) {
        ref
            .read(appNotificationsProvider.notifier)
            .notifyMany(
              toUserIds: recipients,
              fromUserId: me.id,
              message:
                  'Your ${req.formType.label} request '
                  '(${req.displayId}) was approved. '
                  'The form is now ready to fill out.',
            );
      }

      busy.value = false;
      if (context.mounted) Navigator.of(context).pop();
    }

    Future<void> disapprove() async {
      final String reason = reasonCtrl.text.trim();
      if (reason.isEmpty) {
        reasonError.value = 'A reason is required.';
        return;
      }
      reasonError.value = null;
      busy.value = true;

      final UserAccount me = ref.read(authProvider)!;
      await ref
          .read(formRequestsProvider.notifier)
          .markDisapproved(
            requestId: req.id,
            reason: reason,
            approvedByUserId: me.id,
          );

      ref
          .read(auditLogsProvider.notifier)
          .log(
            userAccountId: me.id,
            userFullName: me.fullName,
            action: 'Disapprove Request',
            description:
                '${me.fullName} disapproved ${req.displayId} '
                '(${req.formType.label}): $reason',
          );

      ref
          .read(appNotificationsProvider.notifier)
          .notifyOne(
            toUserId: req.payload.teacherId,
            fromUserId: me.id,
            message:
                'Your ${req.formType.label} request '
                '(${req.displayId}) was disapproved: $reason',
          );

      busy.value = false;
      if (context.mounted) Navigator.of(context).pop();
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 760),
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
                      '${req.displayId} · ${req.formType.label}',
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
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _StatusChip(status: req.status),
                        Chip(
                          avatar: const Icon(
                            Icons.person_outline_rounded,
                            size: 16,
                          ),
                          label: Text('By ${req.payload.teacherName}'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Students', style: context.textTheme.titleSmall),
                    const SizedBox(height: 6),
                    _StudentsList(payload: req.payload),

                    const SizedBox(height: 16),
                    Text('Reason', style: context.textTheme.titleSmall),
                    const SizedBox(height: 6),
                    _Reason(payload: req.payload),
                    if (req.status == FormRequestStatus.disapproved &&
                        req.disapprovalReason != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Disapproval reason',
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.colorScheme.errorContainer.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          req.disapprovalReason!,
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                    if (req.status == FormRequestStatus.pending &&
                        showRejectField.value) ...[
                      const SizedBox(height: 16),
                      TextField(
                        controller: reasonCtrl,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Why is this being disapproved?',
                          errorText: reasonError.value,
                          alignLabelWithHint: true,
                        ),
                      ),
                    ],
                    if (isMyOwnRequest &&
                        req.status == FormRequestStatus.pending) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline_rounded, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'You submitted this request. Guidance will review it — '
                                'you cannot approve your own request.',
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (canAct) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: busy.value
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 8),
                    if (!showRejectField.value) ...[
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.colorScheme.error,
                        ),
                        onPressed: busy.value
                            ? null
                            : () => showRejectField.value = true,
                        icon: const Icon(Icons.close_rounded, size: 18),
                        label: const Text('Disapprove'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: busy.value ? null : approve,
                        icon: busy.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.check_rounded, size: 18),
                        label: const Text('Approve'),
                      ),
                    ] else ...[
                      OutlinedButton(
                        onPressed: busy.value
                            ? null
                            : () => showRejectField.value = false,
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: context.colorScheme.error,
                          foregroundColor: context.colorScheme.onError,
                        ),
                        onPressed: busy.value ? null : disapprove,
                        child: const Text('Confirm disapprove'),
                      ),
                    ],
                  ],
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final FormRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final (Color bg, Color fg, IconData icon) = switch (status) {
      FormRequestStatus.pending => (
        scheme.tertiaryContainer,
        scheme.onTertiaryContainer,
        Icons.pending_outlined,
      ),
      FormRequestStatus.approved => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
        Icons.check_circle_rounded,
      ),
      FormRequestStatus.disapproved => (
        scheme.errorContainer,
        scheme.onErrorContainer,
        Icons.cancel_rounded,
      ),
    };
    return Chip(
      avatar: Icon(icon, size: 16, color: fg),
      backgroundColor: bg,
      labelStyle: TextStyle(color: fg),
      label: Text(status.label),
    );
  }
}

class _StudentsList extends StatelessWidget {
  const _StudentsList({required this.payload});
  final FormRequestPayload payload;

  @override
  Widget build(BuildContext context) {
    final List<String> names = switch (payload) {
      HomeVisitationRequestPayload p => [p.studentName],
      ViolationRequestPayload p => p.studentNames,
    };
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final n in names)
          Chip(
            avatar: const Icon(Icons.person_outline_rounded, size: 16),
            label: Text(n),
          ),
      ],
    );
  }
}

class _Reason extends StatelessWidget {
  const _Reason({required this.payload});
  final FormRequestPayload payload;

  @override
  Widget build(BuildContext context) {
    final String reason = switch (payload) {
      HomeVisitationRequestPayload p => p.reason,
      ViolationRequestPayload p => p.reason,
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(reason, style: context.textTheme.bodyMedium),
    );
  }
}
