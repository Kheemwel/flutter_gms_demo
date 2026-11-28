import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_providers.dart';
import 'package:flutter_gms_demo/features/forms/presentation/dialogs/approval_details_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class MyRequestsTab extends ConsumerWidget {
  const MyRequestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<FormRequest> requests = ref.watch(myRequestsProvider);

    if (requests.isEmpty) {
      return const AppEmptyState(
        icon: Icons.outbox_rounded,
        title: 'No requests yet',
        message: 'Submit a request from the New Request tab.',
      );
    }

    return AppDataTable<FormRequest>(
      columns: [
        AppDataTableColumn(label: 'Request', sortBy: (r) => r.displayId),
        AppDataTableColumn(label: 'Type', sortBy: (r) => r.formType.label),
        AppDataTableColumn(label: 'Status', sortBy: (r) => r.status.index),
        AppDataTableColumn(label: 'Submitted', sortBy: (r) => r.createdAt),
      ],
      onRowTap: (FormRequest r) => showApprovalDetails(context, request: r),
      mobileTileBuilder: (context, r) => ListTile(
        title: Text('${r.displayId} • ${r.formType.label}'),
        subtitle: Text(_fmt(r.createdAt)),
        trailing: _StatusPill(status: r.status),
      ),
      rows: [
        for (final r in requests)
          AppDataRow<FormRequest>(
            payload: r,
            cells: [
              Text(r.displayId),
              Text(r.formType.label),
              _StatusPill(status: r.status),
              Text(_fmt(r.createdAt)),
            ],
          ),
      ],
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final FormRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final (Color bg, Color fg) = switch (status) {
      FormRequestStatus.pending => (
        scheme.tertiaryContainer,
        scheme.onTertiaryContainer,
      ),
      FormRequestStatus.approved => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      FormRequestStatus.disapproved => (
        scheme.errorContainer,
        scheme.onErrorContainer,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: context.textTheme.labelSmall?.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
