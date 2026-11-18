import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/offense.dart';

Future<DisciplinaryAction?> showDisciplinaryActionForm(
  BuildContext context, {
  DisciplinaryAction? existing,
}) {
  return showDialog<DisciplinaryAction>(
    context: context,
    builder: (_) => _DisciplinaryActionFormDialog(existing: existing),
  );
}

class _DisciplinaryActionFormDialog extends HookWidget {
  const _DisciplinaryActionFormDialog({this.existing});

  final DisciplinaryAction? existing;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = useTextEditingController(text: existing?.name ?? '');
    final TextEditingController descCtrl = useTextEditingController(
      text: existing?.description ?? '',
    );
    final ValueNotifier<String?> error = useState<String?>(null);

    void submit() {
      final String name = nameCtrl.text.trim();
      if (name.isEmpty) {
        error.value = 'Name is required.';
        return;
      }
      Navigator.of(context).pop(
        DisciplinaryAction(
          id: existing?.id ?? 'act-${DateTime.now().microsecondsSinceEpoch}',
          name: name,
          description: descCtrl.text.trim(),
        ),
      );
    }

    return AlertDialog(
      title: Text(
        existing == null
            ? 'Add disciplinary action'
            : 'Edit disciplinary action',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameCtrl,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Name',
              errorText: error.value,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descCtrl,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
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
