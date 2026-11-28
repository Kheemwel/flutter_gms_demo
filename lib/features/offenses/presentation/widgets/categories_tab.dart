import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offense_providers.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offenses_notifier.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/dialogs/offense_category_form_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class CategoriesTab extends ConsumerWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<OffenseCategory> cats = ref.watch(offenseCategoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final OffenseCategory? created = await showOffenseCategoryForm(
                  context,
                );
                if (created != null) {
                  await ref
                      .read(offenseCategoriesProvider.notifier)
                      .add(created);
                }
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add category'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: AppDataTable<OffenseCategory>(
            columns: [
              AppDataTableColumn(
                label: 'Category',
                sortBy: (c) => c.name.toLowerCase(),
              ),
              AppDataTableColumn(
                label: 'Offenses',
                numeric: true,
                sortBy: (c) => ref.read(offenseCountForCategoryProvider(c.id)),
              ),
              const AppDataTableColumn(label: ''),
            ],
            mobileTileBuilder: (context, c) {
              final int count = ref.watch(
                offenseCountForCategoryProvider(c.id),
              );
              return ListTile(
                title: Text(c.name),
                subtitle: Text('$count offenses'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => _delete(context, ref, c),
                ),
              );
            },
            emptyState: const AppEmptyState(
              icon: Icons.category_outlined,
              title: 'No categories yet',
              message: 'Add the first one to get started.',
            ),
            rows: [
              for (final c in cats)
                AppDataRow<OffenseCategory>(
                  payload: c,
                  cells: [
                    Text(c.name),
                    Text('${ref.watch(offenseCountForCategoryProvider(c.id))}'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () async {
                            final OffenseCategory? updated =
                                await showOffenseCategoryForm(
                                  context,
                                  existing: c,
                                );
                            if (updated != null) {
                              await ref
                                  .read(offenseCategoriesProvider.notifier)
                                  .update(updated);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => _delete(context, ref, c),
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
    OffenseCategory cat,
  ) async {
    final int count = ref.read(offenseCountForCategoryProvider(cat.id));
    if (count > 0) {
      await appConfirm(
        context,
        title: 'Cannot delete',
        message:
            '$count offense(s) are in "${cat.name}". '
            'Reassign them first.',
        confirmLabel: 'OK',
        cancelLabel: 'Close',
        destructive: true,
      );
      return;
    }
    final bool ok = await appConfirm(
      context,
      title: 'Delete category?',
      message: 'Delete "${cat.name}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) await ref.read(offenseCategoriesProvider.notifier).delete(cat.id);
  }
}
