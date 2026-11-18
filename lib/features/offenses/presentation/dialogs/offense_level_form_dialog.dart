import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/offense.dart';

Future<OffenseLevel?> showOffenseLevelForm(
  BuildContext context, {
  OffenseLevel? existing,
}) {
  return showDialog<OffenseLevel>(
    context: context,
    builder: (_) => _OffenseLevelFormDialog(existing: existing),
  );
}

class _OffenseLevelFormDialog extends HookWidget {
  const _OffenseLevelFormDialog({this.existing});

  final OffenseLevel? existing;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = useTextEditingController(text: existing?.name ?? '');
    final TextEditingController severityCtrl = useTextEditingController(
      text: existing?.severity.toString() ?? '1',
    );
    final ValueNotifier<String?> error = useState<String?>(null);

    void submit() {
      final String name = nameCtrl.text.trim();
      final int? severity = int.tryParse(severityCtrl.text.trim());
      if (name.isEmpty) {
        error.value = 'Name is required.';
        return;
      }
      if (severity == null || severity < 1 || severity > 10) {
        error.value = 'Severity must be between 1 and 10.';
        return;
      }
      Navigator.of(context).pop(
        OffenseLevel(
          id: existing?.id ?? 'lvl-${DateTime.now().microsecondsSinceEpoch}',
          name: name,
          severity: severity,
        ),
      );
    }

    return AlertDialog(
      title: Text(existing == null ? 'Add level' : 'Edit level'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameCtrl,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Level name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: severityCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Severity (1 = minor, 10 = critical)',
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
