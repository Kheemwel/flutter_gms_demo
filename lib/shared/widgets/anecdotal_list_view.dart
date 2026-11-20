import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/presentation/widgets/signature_stub.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

enum AnecdotalViewerRole {
  guidance,
  student,
  parent,
  teacher,
  principal,
  admin,
}

class AnecdotalListView extends ConsumerWidget {
  const AnecdotalListView({
    super.key,
    required this.studentId,
    required this.viewerRole,
  });

  final String studentId;
  final AnecdotalViewerRole viewerRole;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? me = ref.watch(authProvider);
    final List<StudentAnecdotal> entries = ref
        .watch(studentAnecdotalsProvider.notifier)
        .forStudent(studentId);
    final bool canDelete = ref.can(Privilege.writeStudentsAnecdotal);

    if (entries.isEmpty) {
      return const AppEmptyState(
        icon: Icons.notes_rounded,
        title: 'No anecdotal entries',
        message: 'Observations and notes about this student will appear here.',
      );
    }

    return ListView.separated(
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final StudentAnecdotal entry = entries[i];
        return _AnecdotalCard(
          entry: entry,
          viewerRole: viewerRole,
          isAuthor: me?.id == entry.authorUserId,
          canDelete: canDelete,
          onDelete: () => _delete(context, ref, entry),
          onSignAsStudent: viewerRole == AnecdotalViewerRole.student
              ? () => ref
                    .read(studentAnecdotalsProvider.notifier)
                    .setStudentSignature(
                      anecdotalId: entry.id,
                      dataUrl: stubSignatureDataUrl,
                    )
              : null,
          onSignAsParent: viewerRole == AnecdotalViewerRole.parent
              ? () => ref
                    .read(studentAnecdotalsProvider.notifier)
                    .setParentSignature(
                      anecdotalId: entry.id,
                      dataUrl: stubSignatureDataUrl,
                    )
              : null,
        );
      },
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    StudentAnecdotal entry,
  ) async {
    final bool ok = await appConfirm(
      context,
      title: 'Delete anecdotal entry?',
      message: 'Remove this entry permanently? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) {
      await ref.read(studentAnecdotalsProvider.notifier).delete(entry.id);
    }
  }
}

class _AnecdotalCard extends StatelessWidget {
  const _AnecdotalCard({
    required this.entry,
    required this.viewerRole,
    required this.isAuthor,
    required this.canDelete,
    required this.onDelete,
    this.onSignAsStudent,
    this.onSignAsParent,
  });

  final StudentAnecdotal entry;
  final AnecdotalViewerRole viewerRole;
  final bool isAuthor;
  final bool canDelete;
  final VoidCallback onDelete;
  final VoidCallback? onSignAsStudent;
  final VoidCallback? onSignAsParent;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text(entry.category),
                ),
                const SizedBox(width: 8),
                Text(
                  _fmt(entry.observedAt),
                  style: context.textTheme.bodySmall,
                ),
                const Spacer(),
                if (canDelete)
                  IconButton(
                    tooltip: 'Delete entry',
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(entry.narrative, style: context.textTheme.bodyMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'By ${entry.authorFullName}',
                    style: context.textTheme.bodySmall,
                  ),
                ),
                _SignChip(label: 'Author', signed: entry.authorSigned),
                const SizedBox(width: 6),
                _SignChip(label: 'Student', signed: entry.studentSigned),
                const SizedBox(width: 6),
                _SignChip(label: 'Parent', signed: entry.parentSigned),
              ],
            ),
            if (onSignAsStudent != null && !entry.studentSigned) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonalIcon(
                  onPressed: onSignAsStudent,
                  icon: const Icon(Icons.draw_rounded, size: 18),
                  label: const Text('Sign as student'),
                ),
              ),
            ],
            if (onSignAsParent != null && !entry.parentSigned) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonalIcon(
                  onPressed: onSignAsParent,
                  icon: const Icon(Icons.draw_rounded, size: 18),
                  label: const Text('Sign as parent'),
                ),
              ),
            ],
            if (scheme.brightness == Brightness.light) const SizedBox(),
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';
}

class _SignChip extends StatelessWidget {
  const _SignChip({required this.label, required this.signed});
  final String label;
  final bool signed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color bg = signed
        ? scheme.primaryContainer
        : scheme.surfaceContainerHighest;
    final Color fg = signed
        ? scheme.onPrimaryContainer
        : scheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            signed ? Icons.check_rounded : Icons.schedule_rounded,
            size: 12,
            color: fg,
          ),
          const SizedBox(width: 4),
          Text(label, style: context.textTheme.labelSmall?.copyWith(color: fg)),
        ],
      ),
    );
  }
}
