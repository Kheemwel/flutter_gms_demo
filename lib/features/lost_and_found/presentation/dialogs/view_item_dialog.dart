import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_providers.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/widgets/item_image_placeholder.dart';

class ViewItemDialog extends ConsumerWidget {
  const ViewItemDialog({super.key, required this.item});

  final LostAndFoundItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, ItemType> types = ref.watch(itemTypeByIdProvider);
    final Map<String, ItemTag> tags = ref.watch(itemTagByIdProvider);
    final ItemTag? tag = tags[item.itemTagId];
    final bool expired = item.isExpired(tag);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Item details',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ItemImagePlaceholder(seedId: item.id, size: 72),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemName,
                                style: context.textTheme.titleMedium,
                              ),
                              Text(
                                types[item.itemTypeId]?.itemType ??
                                    'Unknown type',
                                style: context.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (item.isClaimed)
                          const Chip(
                            avatar: Icon(Icons.check_circle_rounded, size: 16),
                            label: Text('Claimed'),
                          )
                        else if (expired)
                          const Chip(
                            avatar: Icon(Icons.timer_off_rounded, size: 16),
                            label: Text('Expired'),
                          )
                        else
                          const Chip(
                            avatar: Icon(Icons.inventory_2_outlined, size: 16),
                            label: Text('Available'),
                          ),
                        if (tag != null)
                          Chip(
                            avatar: const Icon(
                              Icons.priority_high_rounded,
                              size: 16,
                            ),
                            label: Text(tag.priorityTag),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (item.description.isNotEmpty) ...[
                      Text('Description', style: context.textTheme.titleSmall),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                    ],
                    _Row('Found on', _fmt(item.datetimeFound)),
                    _Row('Found by', item.finderName),
                    _Row('Location', item.locationFound),
                    if (tag != null)
                      _Row('Expires on', _fmt(item.expirationDate(tag)!)),
                    if (item.isClaimed) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Claim information',
                        style: context.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      _Row('Claimed on', _fmt(item.claimedDatetime!)),
                      _Row('Claimer', item.claimerName ?? '—'),
                      _Row('Contact', item.claimerContact ?? '—'),
                      _Row('Email', item.claimerEmail ?? '—'),
                      _Row('Address', item.claimerAddress ?? '—'),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: context.textTheme.bodySmall),
          ),
          Expanded(child: Text(value, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
