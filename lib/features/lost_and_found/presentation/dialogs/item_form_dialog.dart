import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_notifier.dart';

Future<LostAndFoundItem?> showItemForm(
  BuildContext context, {
  LostAndFoundItem? existing,
}) {
  return showDialog<LostAndFoundItem>(
    context: context,
    builder: (_) => _ItemFormDialog(existing: existing),
  );
}

class _ItemFormDialog extends HookConsumerWidget {
  const _ItemFormDialog({this.existing});

  final LostAndFoundItem? existing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemType> types = ref.watch(itemTypesProvider);
    final List<ItemTag> tags = ref.watch(itemTagsProvider);

    final TextEditingController nameCtrl = useTextEditingController(text: existing?.itemName ?? '');
    final TextEditingController descCtrl = useTextEditingController(
      text: existing?.description ?? '',
    );
    final TextEditingController finderCtrl = useTextEditingController(
      text: existing?.finderName ?? '',
    );
    final TextEditingController locationCtrl = useTextEditingController(
      text: existing?.locationFound ?? '',
    );

    final ValueNotifier<String?> typeId = useState<String?>(
      existing?.itemTypeId ?? (types.isNotEmpty ? types.first.id : null),
    );
    final ValueNotifier<String?> tagId = useState<String?>(
      existing?.itemTagId ?? (tags.isNotEmpty ? tags.first.id : null),
    );
    final ValueNotifier<DateTime> foundAt = useState<DateTime>(
      existing?.datetimeFound ?? DateTime.now(),
    );

    final ValueNotifier<Map<String, String>> errors = useState<Map<String, String>>(const {});
    final ValueNotifier<bool> submitting = useState(false);

    Future<void> submit() async {
      final e = <String, String>{};
      if (nameCtrl.text.trim().isEmpty) {
        e['name'] = 'Item name is required.';
      }
      if (finderCtrl.text.trim().isEmpty) {
        e['finder'] = 'Finder name is required.';
      }
      if (locationCtrl.text.trim().isEmpty) {
        e['location'] = 'Location is required.';
      }
      if (typeId.value == null) e['type'] = 'Pick a type.';
      if (tagId.value == null) e['tag'] = 'Pick a priority tag.';
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }
      errors.value = const {};
      submitting.value = true;

      final item = LostAndFoundItem(
        id: existing?.id ?? 'item-${DateTime.now().microsecondsSinceEpoch}',
        itemName: nameCtrl.text.trim(),
        itemTypeId: typeId.value!,
        itemTagId: tagId.value!,
        description: descCtrl.text.trim(),
        datetimeFound: foundAt.value,
        finderName: finderCtrl.text.trim(),
        locationFound: locationCtrl.text.trim(),
        isClaimed: existing?.isClaimed ?? false,
        claimedDatetime: existing?.claimedDatetime,
        claimerName: existing?.claimerName,
        claimerContact: existing?.claimerContact,
        claimerEmail: existing?.claimerEmail,
        claimerAddress: existing?.claimerAddress,
      );

      final LostAndFoundItems notifier = ref.read(lostAndFoundItemsProvider.notifier);
      if (existing == null) {
        await notifier.add(item);
      } else {
        await notifier.update(item);
      }
      if (context.mounted) Navigator.of(context).pop(item);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 720),
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
                      existing == null ? 'Add found item' : 'Edit item',
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
                    _Field(
                      label: 'Item name',
                      controller: nameCtrl,
                      error: errors.value['name'],
                      icon: Icons.inventory_2_outlined,
                    ),
                    _Field(
                      label: 'Description (optional)',
                      controller: descCtrl,
                      icon: Icons.notes_rounded,
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: typeId.value,
                            decoration: const InputDecoration(
                              labelText: 'Type',
                              prefixIcon: Icon(Icons.category_outlined),
                            ),
                            items: [
                              for (final t in types)
                                DropdownMenuItem(
                                  value: t.id,
                                  child: Text(t.itemType),
                                ),
                            ],
                            onChanged: (v) => typeId.value = v,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: tagId.value,
                            decoration: const InputDecoration(
                              labelText: 'Priority tag',
                              prefixIcon: Icon(Icons.priority_high_rounded),
                            ),
                            items: [
                              for (final t in tags)
                                DropdownMenuItem(
                                  value: t.id,
                                  child: Text(
                                    '${t.priorityTag} · ${t.daysExpired}d',
                                  ),
                                ),
                            ],
                            onChanged: (v) => tagId.value = v,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _DateField(
                      label: 'Date found',
                      value: foundAt.value,
                      onChanged: (d) => foundAt.value = d,
                    ),
                    _Field(
                      label: 'Finder name',
                      controller: finderCtrl,
                      error: errors.value['finder'],
                      icon: Icons.person_outline_rounded,
                    ),
                    _Field(
                      label: 'Location found',
                      controller: locationCtrl,
                      error: errors.value['location'],
                      icon: Icons.place_outlined,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 18,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Image upload lands in a later batch — '
                              'a gradient placeholder will be shown.',
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: submitting.value
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: submitting.value ? null : submit,
                    child: submitting.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(existing == null ? 'Add' : 'Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.error,
    this.icon,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String? error;
  final IconData? icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon == null ? null : Icon(icon),
          errorText: error,
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: value,
            firstDate: DateTime(2000),
            lastDate: DateTime.now().add(const Duration(days: 30)),
          );
          if (picked != null) onChanged(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.event_outlined),
          ),
          child: Text(_fmt(value)),
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
