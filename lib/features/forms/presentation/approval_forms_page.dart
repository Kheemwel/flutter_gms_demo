import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/features/forms/presentation/widgets/requests_by_status_tab.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';

class ApprovalFormsPage extends ConsumerWidget {
  const ApprovalFormsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<FormRequest> pending = ref.watch(
      requestsByStatusProvider(FormRequestStatus.pending),
    );
    final List<FormRequest> approved = ref.watch(
      requestsByStatusProvider(FormRequestStatus.approved),
    );
    final List<FormRequest> disapproved = ref.watch(
      requestsByStatusProvider(FormRequestStatus.disapproved),
    );

    return AppPageScaffold(
      title: 'Approval Forms',
      subtitle:
          'Review teacher requests. Approving a request immediately '
          'creates the corresponding form and notifies the teacher.',
      child: AppTabs(
        tabs: [
          AppTabSpec(label: 'Pending', count: pending.length),
          AppTabSpec(label: 'Approved', count: approved.length),
          AppTabSpec(label: 'Disapproved', count: disapproved.length),
        ],
        children: const [
          RequestsByStatusTab(status: FormRequestStatus.pending),
          RequestsByStatusTab(status: FormRequestStatus.approved),
          RequestsByStatusTab(status: FormRequestStatus.disapproved),
        ],
      ),
    );
  }
}
