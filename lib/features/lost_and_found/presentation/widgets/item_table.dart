import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_notifier.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_providers.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/dialogs/claim_item_dialog.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/dialogs/item_form_dialog.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/dialogs/view_item_dialog.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/widgets/item_image_placeholder.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';

class ItemTable extends ConsumerWidget {
  const ItemTable({super.key, required this.tab});

  final LostFoundTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<LostAndFoundItem> items = ref.watch(itemsForTabProvider(tab));
    final Map<String, ItemType> typeById = ref.watch(itemTypeByIdProvider);
    final Map<String, ItemTag> tagById = ref.watch(itemTagByIdProvider);

    final bool canAdd = ref.can(Privilege.addLostAndFound);
    final bool canEdit = ref.can(Privilege.editLostAndFound);
    final bool canDelete = ref.can(Privilege.deleteLostAndFound);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (canAdd && tab == LostFoundTab.found)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: () async {
                  await showItemForm(context);
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add item'),
              ),
            ],
          ),
        if (canAdd && tab == LostFoundTab.found) const SizedBox(height: 12),
        Expanded(
          child: AppDataTable<LostAndFoundItem>(
            columns: [
              const AppDataTableColumn(label: 'Item'),
              const AppDataTableColumn(label: 'Type'),
              const AppDataTableColumn(label: 'Found'),
              AppDataTableColumn(label: _thirdColumnLabel),
              const AppDataTableColumn(label: ''),
            ],
            onRowTap: (LostAndFoundItem i) {
              showDialog<void>(
                context: context,
                builder: (_) => ViewItemDialog(item: i),
              );
            },
            rows: [
              for (final item in items)
                AppDataRow<LostAndFoundItem>(
                  payload: item,
                  cells: [
                    Row(
                      children: [
                        ItemImagePlaceholder(seedId: item.id),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.itemName),
                              Text(
                                item.locationFound,
                                style: context.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Chip(
                      label: Text(typeById[item.itemTypeId]?.itemType ?? '—'),
                      visualDensity: VisualDensity.compact,
                    ),
                    Text(_fmt(item.datetimeFound)),
                    Text(_thirdCellValue(item, tagById[item.itemTagId])),
                    PopupMenuButton<_RowAction>(
                      onSelected: (a) => _handle(context, ref, item, a),
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: _RowAction.view,
                          child: ListTile(
                            leading: Icon(Icons.visibility_outlined),
                            title: Text('View'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        if (canEdit &&
                            !item.isClaimed &&
                            tab != LostFoundTab.expired)
                          const PopupMenuItem(
                            value: _RowAction.edit,
                            child: ListTile(
                              leading: Icon(Icons.edit_outlined),
                              title: Text('Edit'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        if (item.isClaimed)
                          const PopupMenuItem(
                            value: _RowAction.unclaim,
                            child: ListTile(
                              leading: Icon(Icons.undo_rounded),
                              title: Text('Mark unclaimed'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          )
                        else if (tab != LostFoundTab.expired)
                          const PopupMenuItem(
                            value: _RowAction.claim,
                            child: ListTile(
                              leading: Icon(Icons.check_circle_outline),
                              title: Text('Mark claimed'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        if (canDelete)
                          const PopupMenuItem(
                            value: _RowAction.delete,
                            child: ListTile(
                              leading: Icon(Icons.delete_outline_rounded),
                              title: Text('Delete'),
                              contentPadding: EdgeInsets.zero,
                            ),
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

  String get _thirdColumnLabel => switch (tab) {
    LostFoundTab.found => 'Expires',
    LostFoundTab.claimed => 'Claimed on',
    LostFoundTab.expired => 'Expired on',
  };

  String _thirdCellValue(LostAndFoundItem i, ItemTag? tag) {
    return switch (tab) {
      LostFoundTab.found => tag == null ? '—' : _fmt(i.expirationDate(tag)!),
      LostFoundTab.claimed =>
        i.claimedDatetime == null ? '—' : _fmt(i.claimedDatetime!),
      LostFoundTab.expired => tag == null ? '—' : _fmt(i.expirationDate(tag)!),
    };
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  Future<void> _handle(
    BuildContext context,
    WidgetRef ref,
    LostAndFoundItem item,
    _RowAction action,
  ) async {
    switch (action) {
      case _RowAction.view:
        await showDialog<void>(
          context: context,
          builder: (_) => ViewItemDialog(item: item),
        );
      case _RowAction.edit:
        await showItemForm(context, existing: item);
      case _RowAction.claim:
        final bool ok = await showClaimDialog(context, item: item);
        if (ok && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('"${item.itemName}" marked claimed.')),
          );
        }
      case _RowAction.unclaim:
        final bool ok = await appConfirm(
          context,
          title: 'Mark unclaimed?',
          message:
              'Reset the claim on "${item.itemName}"? '
              'Claimer details will be erased.',
        );
        if (ok) {
          await ref.read(lostAndFoundItemsProvider.notifier).unclaim(item.id);
        }
      case _RowAction.delete:
        final bool ok = await appConfirm(
          context,
          title: 'Delete item?',
          message: 'Permanently delete "${item.itemName}"?',
          confirmLabel: 'Delete',
          destructive: true,
        );
        if (ok) {
          await ref.read(lostAndFoundItemsProvider.notifier).delete(item.id);
        }
    }
  }
}

enum _RowAction { view, edit, claim, unclaim, delete }
