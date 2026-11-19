import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/features/forms/presentation/dialogs/new_request_dialog.dart';
import 'package:flutter_gms_demo/features/forms/presentation/widgets/my_requests_tab.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';

class RequestFormsPage extends ConsumerWidget {
  const RequestFormsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool canRequest = ref.can(Privilege.requestForm);
    final List<FormRequest> mine = ref.watch(myRequestsProvider);

    return AppPageScaffold(
      title: 'Request Forms',
      subtitle:
          'Ask the guidance office to open a home visitation or violation '
          'form. Guidance reviews the request and either approves it '
          '(which creates the form) or explains why it was disapproved.',
      actions: canRequest
          ? [
              FilledButton.icon(
                onPressed: () => _request(context, ref, FormType.violation),
                icon: const Icon(Icons.gavel_rounded),
                label: const Text('Request violation form'),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  foregroundColor: Theme.of(context).colorScheme.onTertiary,
                ),
                onPressed: () =>
                    _request(context, ref, FormType.homeVisitation),
                icon: const Icon(Icons.home_work_rounded),
                label: const Text('Request home visitation'),
              ),
            ]
          : const [],
      child: AppTabs(
        tabs: [
          AppTabSpec(label: 'My requests', count: mine.length),
          const AppTabSpec(label: 'How it works'),
        ],
        children: const [MyRequestsTab(), _HelpTab()],
      ),
    );
  }

  Future<void> _request(
    BuildContext context,
    WidgetRef ref,
    FormType type,
  ) async {
    final FormRequest? created = await showNewRequestDialog(context, type: type);
    if (created != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${created.displayId} submitted. Guidance will review it.',
          ),
        ),
      );
    }
  }
}

class _HelpTab extends StatelessWidget {
  const _HelpTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'How the request workflow works',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const _Step(
                  number: 1,
                  title: 'You submit a request',
                  body:
                      'Choose students and give a reason. '
                      'Guidance gets a notification.',
                ),
                const _Step(
                  number: 2,
                  title: 'Guidance reviews',
                  body:
                      'They can approve (the form is created and '
                      'assigned to you) or disapprove with a reason.',
                ),
                const _Step(
                  number: 3,
                  title: 'You fill and sign',
                  body:
                      'Once approved, the resulting form appears in '
                      'Fill Out Forms, where you and the other parties '
                      'can fill and sign.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.number, required this.title, required this.body});

  final int number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: scheme.primaryContainer,
            child: Text(
              '$number',
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(body, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
