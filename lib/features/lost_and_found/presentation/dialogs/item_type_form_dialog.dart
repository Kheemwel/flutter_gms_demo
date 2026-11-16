import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/lost_and_found.dart';

Future<ItemType?> showItemTypeForm(BuildContext context, {ItemType? existing}) {
  return showDialog<ItemType>(
    context: context,
    builder: (_) => _ItemTypeFormDialog(existing: existing),
  );
}

class _ItemTypeFormDialog extends HookWidget {
  const _ItemTypeFormDialog({this.existing});

  final ItemType? existing;

  @override
  Widget build(BuildContext context) {
    final TextEditingController ctrl = useTextEditingController(text: existing?.itemType ?? '');
    final ValueNotifier<String?> error = useState<String?>(null);

    void submit() {
      final String trimmed = ctrl.text.trim();
      if (trimmed.isEmpty) {
        error.value = 'Type name is required.';
        return;
      }
      Navigator.of(context).pop(
        ItemType(
          id: existing?.id ?? 'type-${DateTime.now().microsecondsSinceEpoch}',
          itemType: trimmed,
        ),
      );
    }

    return AlertDialog(
      title: Text(existing == null ? 'Add type' : 'Edit type'),
      content: TextField(
        controller: ctrl,
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Type name',
          errorText: error.value,
        ),
        onSubmitted: (_) => submit(),
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
