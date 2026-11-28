import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/audit_log.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_trail_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class AuditTrailPage extends ConsumerWidget {
  const AuditTrailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<AuditLog> entries = ref.watch(filteredAuditLogsProvider);
    final String search = ref.watch(auditSearchProvider);

    return AppPageScaffold(
      title: 'Audit Trail',
      subtitle:
          'A chronological record of significant actions. '
          'Entries are append-only except for explicit deletion.',
      actions: [
        OutlinedButton.icon(
          // TODO(assets batch): export to XLSX
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Export will land in a later batch.')),
          ),
          icon: const Icon(Icons.download_rounded),
          label: const Text('Export'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search by action, description, or user…',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onChanged: (v) => ref.read(auditSearchProvider.notifier).state = v,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: entries.isEmpty
                ? AppEmptyState(
                    icon: Icons.history_rounded,
                    title: search.isEmpty
                        ? 'No audit entries yet'
                        : 'No entries match "$search"',
                    message: search.isEmpty
                        ? 'Actions across the app will be recorded here.'
                        : 'Try a different search term.',
                  )
                : AppDataTable<AuditLog>(
                    columns: [
                      AppDataTableColumn(
                        label: 'When',
                        sortBy: (a) => a.createdAt,
                      ),
                      AppDataTableColumn(
                        label: 'User',
                        sortBy: (a) => (a.userFullName ?? '').toLowerCase(),
                      ),
                      AppDataTableColumn(
                        label: 'Action',
                        sortBy: (a) => a.action.toLowerCase(),
                      ),
                      const AppDataTableColumn(label: 'Description'),
                      const AppDataTableColumn(label: ''),
                    ],
                    mobileTileBuilder: (context, a) => ListTile(
                      title: Text(
                        a.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '${a.action} • ${a.userFullName ?? '—'} • ${_fmt(a.createdAt)}',
                      ),
                      trailing: IconButton(
                        tooltip: 'Delete entry',
                        icon: const Icon(Icons.delete_outline_rounded),
                        onPressed: () => _delete(context, ref, a),
                      ),
                    ),
                    rows: [
                      for (final a in entries)
                        AppDataRow<AuditLog>(
                          payload: a,
                          cells: [
                            Text(_fmt(a.createdAt)),
                            Text(a.userFullName ?? '—'),
                            Chip(
                              visualDensity: VisualDensity.compact,
                              label: Text(a.action),
                            ),
                            Text(
                              a.description,
                              overflow: TextOverflow.ellipsis,
                            ),
                            IconButton(
                              tooltip: 'Delete entry',
                              icon: const Icon(Icons.delete_outline_rounded),
                              onPressed: () => _delete(context, ref, a),
                            ),
                          ],
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    AuditLog entry,
  ) async {
    final bool ok = await appConfirm(
      context,
      title: 'Delete audit entry?',
      message:
          'Permanently remove this log entry? '
          'The audit trail is meant to be append-only, so this '
          'should be used only to remove accidental or test entries.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) {
      ref.read(auditLogsProvider.notifier).delete(entry.id);
    }
  }
}
