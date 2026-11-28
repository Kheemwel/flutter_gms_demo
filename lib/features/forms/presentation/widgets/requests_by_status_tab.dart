import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_providers.dart';
import 'package:flutter_gms_demo/features/forms/presentation/dialogs/approval_details_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class RequestsByStatusTab extends ConsumerWidget {
  const RequestsByStatusTab({super.key, required this.status});

  final FormRequestStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<FormRequest> requests = ref.watch(
      requestsByStatusProvider(status),
    );

    if (requests.isEmpty) {
      return AppEmptyState(
        icon: switch (status) {
          FormRequestStatus.pending => Icons.rule_rounded,
          FormRequestStatus.approved => Icons.check_circle_outline_rounded,
          FormRequestStatus.disapproved => Icons.cancel_outlined,
        },
        title: switch (status) {
          FormRequestStatus.pending => 'No pending requests',
          FormRequestStatus.approved => 'No approved requests yet',
          FormRequestStatus.disapproved => 'No disapproved requests',
        },
        message: switch (status) {
          FormRequestStatus.pending => 'New teacher requests will appear here.',
          FormRequestStatus.approved => 'Approved requests will appear here.',
          FormRequestStatus.disapproved =>
            'Disapproved requests will appear here.',
        },
      );
    }

    return AppDataTable<FormRequest>(
      columns: [
        AppDataTableColumn(label: 'Request', sortBy: (r) => r.displayId),
        AppDataTableColumn(label: 'Type', sortBy: (r) => r.formType.label),
        AppDataTableColumn(
          label: 'Teacher',
          sortBy: (r) => r.payload.teacherName.toLowerCase(),
        ),
        if (status == FormRequestStatus.approved)
          AppDataTableColumn(
            label: 'Form',
            sortBy: (r) => r.resultingFormId ?? '',
          ),
        if (status == FormRequestStatus.disapproved)
          AppDataTableColumn(
            label: 'Reason',
            sortBy: (r) => (r.disapprovalReason ?? '').toLowerCase(),
          ),
        AppDataTableColumn(label: 'Submitted', sortBy: (r) => r.createdAt),
      ],
      onRowTap: (FormRequest r) => showApprovalDetails(context, request: r),
      mobileTileBuilder: (context, r) => ListTile(
        title: Text('${r.displayId} • ${r.formType.label}'),
        subtitle: Text('${r.payload.teacherName} • ${_fmt(r.createdAt)}'),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
      rows: [
        for (final r in requests)
          AppDataRow<FormRequest>(
            payload: r,
            cells: [
              Text(r.displayId),
              Text(r.formType.label),
              Text(r.payload.teacherName),
              if (status == FormRequestStatus.approved)
                Text(
                  r.resultingFormId == null
                      ? '—'
                      : '${r.formType.shortCode}#${r.resultingFormId!}',
                ),
              if (status == FormRequestStatus.disapproved)
                Text(
                  r.disapprovalReason ?? '—',
                  overflow: TextOverflow.ellipsis,
                ),
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
