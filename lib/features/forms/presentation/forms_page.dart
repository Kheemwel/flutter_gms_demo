import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide Form;

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/features/forms/presentation/dialogs/create_form_dialog.dart';
import 'package:flutter_gms_demo/features/forms/presentation/widgets/forms_list.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';

class FormsPage extends ConsumerWidget {
  const FormsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({List<Form> completed, List<Form> toFill}) mine = ref.watch(
      myFormsProvider,
    );
    final bool canCreate =
        ref.can(Privilege.fillOutForms) &&
        ref.can(Privilege.approveForm); // guidance has both

    return AppPageScaffold(
      title: 'Fill Out Forms',
      subtitle:
          'Forms assigned to you. Complete every required field and '
          'sign to mark them done.',
      actions: [
        if (canCreate) ...[
          FilledButton.icon(
            onPressed: () async {
              final Form? created = await showCreateFormDialog(
                context,
                type: FormType.violation,
              );
              if (created != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${created.displayId} created.')),
                );
              }
            },
            icon: const Icon(Icons.gavel_rounded),
            label: const Text('New violation form'),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              foregroundColor: Theme.of(context).colorScheme.onTertiary,
            ),
            onPressed: () async {
              final Form? created = await showCreateFormDialog(
                context,
                type: FormType.homeVisitation,
              );
              if (created != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${created.displayId} created.')),
                );
              }
            },
            icon: const Icon(Icons.home_work_rounded),
            label: const Text('New home visitation'),
          ),
        ],
      ],
      child: AppTabs(
        tabs: [
          AppTabSpec(label: 'To Fill', count: mine.toFill.length),
          AppTabSpec(label: 'Completed', count: mine.completed.length),
        ],
        children: const [
          FormsList(completed: false),
          FormsList(completed: true),
        ],
      ),
    );
  }
}
