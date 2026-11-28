import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_notifier.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_providers.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/dialogs/item_type_form_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';

class TypesTab extends ConsumerWidget {
  const TypesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemType> types = ref.watch(itemTypesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final ItemType? created = await showItemTypeForm(context);
                if (created != null) {
                  await ref.read(itemTypesProvider.notifier).add(created);
                }
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add type'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: types.isEmpty
              ? const AppEmptyState(
                  icon: Icons.category_outlined,
                  title: 'No types yet',
                  message: 'Add the first one to get started.',
                )
              : AppDataTable<ItemType>(
                  columns: [
                    AppDataTableColumn(
                      label: 'Type',
                      sortBy: (t) => t.itemType.toLowerCase(),
                    ),
                    AppDataTableColumn(
                      label: 'Items using it',
                      numeric: true,
                      sortBy: (t) => ref.read(itemCountForTypeProvider(t.id)),
                    ),
                    const AppDataTableColumn(label: ''),
                  ],
                  onRowTap: (t) async {
                    final ItemType? updated = await showItemTypeForm(
                      context,
                      existing: t,
                    );
                    if (updated != null) {
                      await ref
                          .read(itemTypesProvider.notifier)
                          .update(updated);
                    }
                  },
                  mobileTileBuilder: (context, t) {
                    final int count = ref.watch(itemCountForTypeProvider(t.id));
                    return ListTile(
                      title: Text(t.itemType),
                      subtitle: Text('$count items using it'),
                      trailing: IconButton(
                        tooltip: 'Delete',
                        icon: const Icon(Icons.delete_outline_rounded),
                        onPressed: () => _delete(context, ref, t),
                      ),
                    );
                  },
                  rows: [
                    for (final t in types)
                      AppDataRow<ItemType>(
                        payload: t,
                        cells: [
                          Text(t.itemType),
                          Text('${ref.watch(itemCountForTypeProvider(t.id))}'),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  final ItemType? updated =
                                      await showItemTypeForm(
                                        context,
                                        existing: t,
                                      );
                                  if (updated != null) {
                                    await ref
                                        .read(itemTypesProvider.notifier)
                                        .update(updated);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded),
                                onPressed: () => _delete(context, ref, t),
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
    ItemType type,
  ) async {
    final int count = ref.read(itemCountForTypeProvider(type.id));
    if (count > 0) {
      await appConfirm(
        context,
        title: 'Cannot delete',
        message:
            '$count item(s) use "${type.itemType}". '
            'Reassign or delete those items first.',
        confirmLabel: 'OK',
        cancelLabel: 'Close',
        destructive: true,
      );
      return;
    }
    final bool ok = await appConfirm(
      context,
      title: 'Delete type?',
      message: 'Delete "${type.itemType}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) await ref.read(itemTypesProvider.notifier).delete(type.id);
  }
}
