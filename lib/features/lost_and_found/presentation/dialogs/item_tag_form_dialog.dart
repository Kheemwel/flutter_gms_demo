import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/lost_and_found.dart';

Future<ItemTag?> showItemTagForm(BuildContext context, {ItemTag? existing}) {
  return showDialog<ItemTag>(
    context: context,
    builder: (_) => _ItemTagFormDialog(existing: existing),
  );
}

class _ItemTagFormDialog extends HookWidget {
  const _ItemTagFormDialog({this.existing});

  final ItemTag? existing;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = useTextEditingController(
      text: existing?.priorityTag ?? '',
    );
    final TextEditingController daysCtrl = useTextEditingController(
      text: existing?.daysExpired.toString() ?? '',
    );
    final ValueNotifier<String?> error = useState<String?>(null);

    void submit() {
      final String name = nameCtrl.text.trim();
      final int? days = int.tryParse(daysCtrl.text.trim());
      if (name.isEmpty) {
        error.value = 'Tag name is required.';
        return;
      }
      if (days == null || days < 1) {
        error.value = 'Expiry must be at least 1 day.';
        return;
      }
      Navigator.of(context).pop(
        ItemTag(
          id: existing?.id ?? 'tag-${DateTime.now().microsecondsSinceEpoch}',
          priorityTag: name,
          daysExpired: days,
        ),
      );
    }

    return AlertDialog(
      title: Text(existing == null ? 'Add priority tag' : 'Edit tag'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameCtrl,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Tag name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: daysCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Expires after (days)',
            ),
          ),
          if (error.value != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                error.value!,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: submit,
          child: Text(existing == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
