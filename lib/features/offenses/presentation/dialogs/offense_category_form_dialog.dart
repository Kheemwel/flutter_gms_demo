import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/offense.dart';

Future<OffenseCategory?> showOffenseCategoryForm(
  BuildContext context, {
  OffenseCategory? existing,
}) {
  return showDialog<OffenseCategory>(
    context: context,
    builder: (_) => _OffenseCategoryFormDialog(existing: existing),
  );
}

class _OffenseCategoryFormDialog extends HookWidget {
  const _OffenseCategoryFormDialog({this.existing});

  final OffenseCategory? existing;

  @override
  Widget build(BuildContext context) {
    final TextEditingController ctrl = useTextEditingController(text: existing?.name ?? '');
    final ValueNotifier<String?> error = useState<String?>(null);

    void submit() {
      final String trimmed = ctrl.text.trim();
      if (trimmed.isEmpty) {
        error.value = 'Name is required.';
        return;
      }
      Navigator.of(context).pop(
        OffenseCategory(
          id: existing?.id ?? 'cat-${DateTime.now().microsecondsSinceEpoch}',
          name: trimmed,
        ),
      );
    }

    return AlertDialog(
      title: Text(existing == null ? 'Add category' : 'Edit category'),
      content: TextField(
        controller: ctrl,
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Category name',
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
