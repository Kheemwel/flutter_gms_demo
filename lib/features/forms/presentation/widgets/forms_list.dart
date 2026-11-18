import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide Form;

import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class FormsList extends ConsumerWidget {
  const FormsList({super.key, required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({List<Form> completed, List<Form> toFill}) mine = ref.watch(
      myFormsProvider,
    );
    final List<Form> forms = completed ? mine.completed : mine.toFill;

    if (forms.isEmpty) {
      return AppEmptyState(
        icon: completed ? Icons.task_alt_rounded : Icons.assignment_outlined,
        title: completed ? 'No completed forms' : 'No forms to fill',
        message: completed
            ? 'Completed forms will appear here.'
            : 'Forms assigned to you will appear here.',
      );
    }

    return AppDataTable<Form>(
      columns: [
        const AppDataTableColumn(label: 'Form'),
        const AppDataTableColumn(label: 'Type'),
        AppDataTableColumn(label: completed ? 'Completed on' : 'Created'),
        const AppDataTableColumn(label: 'Participants'),
        const AppDataTableColumn(label: ''),
      ],
      rows: [
        for (final form in forms)
          AppDataRow<Form>(
            payload: form,
            cells: [
              Text(form.displayId),
              Text(form.formType.label),
              Text(_fmt(completed ? form.createdAt : form.createdAt)),
              Text('${form.participants.length}'),
              Row(
                children: [
                  IconButton(
                    tooltip: 'Open',
                    onPressed: () => _open(context, ref, form),
                    icon: const Icon(Icons.open_in_new_rounded),
                  ),
                  // TODO(Batch 7 part 2): replace with open dialog.
                  if (form.status == FormStatus.incomplete)
                    IconButton(
                      tooltip: 'Delete',
                      onPressed: () => _delete(context, ref, form),
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  Future<void> _open(BuildContext context, WidgetRef ref, Form form) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fill-out dialog lands in Batch 7 part 2.')),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Form form) async {
    final bool ok = await appConfirm(
      context,
      title: 'Delete form?',
      message: 'Delete ${form.displayId}? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) await ref.read(formsProvider.notifier).delete(form.id);
  }
}
