import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_notifier.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_providers.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/dialogs/item_tag_form_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';

class TagsTab extends ConsumerWidget {
  const TagsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemTag> tags = ref.watch(itemTagsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final ItemTag? created = await showItemTagForm(context);
                if (created != null) {
                  await ref.read(itemTagsProvider.notifier).add(created);
                }
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add tag'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: tags.isEmpty
              ? const AppEmptyState(
                  icon: Icons.priority_high_rounded,
                  title: 'No priority tags yet',
                  message: 'Add the first one to get started.',
                )
              : AppDataTable<ItemTag>(
                  columns: const [
                    AppDataTableColumn(label: 'Tag'),
                    AppDataTableColumn(label: 'Expires after', numeric: true),
                    AppDataTableColumn(label: 'Items using it', numeric: true),
                    AppDataTableColumn(label: ''),
                  ],
                  rows: [
                    for (final t in tags)
                      AppDataRow<ItemTag>(
                        payload: t,
                        cells: [
                          Text(t.priorityTag),
                          Text('${t.daysExpired} day(s)'),
                          Text('${ref.watch(itemCountForTagProvider(t.id))}'),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  final ItemTag? updated =
                                      await showItemTagForm(
                                        context,
                                        existing: t,
                                      );
                                  if (updated != null) {
                                    await ref
                                        .read(itemTagsProvider.notifier)
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

  Future<void> _delete(BuildContext context, WidgetRef ref, ItemTag tag) async {
    final int count = ref.read(itemCountForTagProvider(tag.id));
    if (count > 0) {
      await appConfirm(
        context,
        title: 'Cannot delete',
        message:
            '$count item(s) use "${tag.priorityTag}". '
            'Reassign or delete those items first.',
        confirmLabel: 'OK',
        cancelLabel: 'Close',
        destructive: true,
      );
      return;
    }
    final bool ok = await appConfirm(
      context,
      title: 'Delete tag?',
      message: 'Delete "${tag.priorityTag}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) await ref.read(itemTagsProvider.notifier).delete(tag.id);
  }
}
