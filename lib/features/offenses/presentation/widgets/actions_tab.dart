import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offense_providers.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offenses_notifier.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/dialogs/disciplinary_action_form_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class DisciplinaryActionsTab extends ConsumerWidget {
  const DisciplinaryActionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DisciplinaryAction> actions = ref.watch(
      disciplinaryActionsProvider,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final DisciplinaryAction? created =
                    await showDisciplinaryActionForm(context);
                if (created != null) {
                  await ref
                      .read(disciplinaryActionsProvider.notifier)
                      .add(created);
                }
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add action'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: AppDataTable<DisciplinaryAction>(
            columns: const [
              AppDataTableColumn(label: 'Action'),
              AppDataTableColumn(label: 'Description'),
              AppDataTableColumn(label: 'Offenses', numeric: true),
              AppDataTableColumn(label: ''),
            ],
            emptyState: const AppEmptyState(
              icon: Icons.rule_rounded,
              title: 'No disciplinary actions yet',
              message: 'Add the first one to get started.',
            ),
            rows: [
              for (final a in actions)
                AppDataRow<DisciplinaryAction>(
                  payload: a,
                  cells: [
                    Text(a.name),
                    Text(
                      a.description.isEmpty ? '—' : a.description,
                      style: context.textTheme.bodySmall,
                    ),
                    Text('${ref.watch(offenseCountForActionProvider(a.id))}'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () async {
                            final DisciplinaryAction? updated =
                                await showDisciplinaryActionForm(
                                  context,
                                  existing: a,
                                );
                            if (updated != null) {
                              await ref
                                  .read(disciplinaryActionsProvider.notifier)
                                  .update(updated);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => _delete(context, ref, a),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    DisciplinaryAction action,
  ) async {
    final int count = ref.read(offenseCountForActionProvider(action.id));
    if (count > 0) {
      await appConfirm(
        context,
        title: 'Cannot delete',
        message:
            '$count offense(s) use "${action.name}". '
            'Remove this action from them first.',
        confirmLabel: 'OK',
        cancelLabel: 'Close',
        destructive: true,
      );
      return;
    }
    final bool ok = await appConfirm(
      context,
      title: 'Delete action?',
      message: 'Delete "${action.name}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) {
      await ref.read(disciplinaryActionsProvider.notifier).delete(action.id);
    }
  }
}
