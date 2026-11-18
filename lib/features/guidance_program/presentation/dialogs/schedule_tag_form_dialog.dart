import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/guidance_program.dart';

Future<GuidanceScheduleTag?> showScheduleTagForm(
  BuildContext context, {
  GuidanceScheduleTag? existing,
}) {
  return showDialog<GuidanceScheduleTag>(
    context: context,
    builder: (_) => _ScheduleTagFormDialog(existing: existing),
  );
}

class _ScheduleTagFormDialog extends HookWidget {
  const _ScheduleTagFormDialog({this.existing});

  final GuidanceScheduleTag? existing;

  static const List<String> _palette = [
    '#4CAF50',
    '#2196F3',
    '#F44336',
    '#9C27B0',
    '#FF9800',
    '#795548',
    '#607D8B',
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = useTextEditingController(text: existing?.tagName ?? '');
    final ValueNotifier<String> color = useState<String>(existing?.color ?? _palette.first);
    final ValueNotifier<String?> error = useState<String?>(null);

    void submit() {
      final String name = nameCtrl.text.trim();
      if (name.isEmpty) {
        error.value = 'Tag name is required.';
        return;
      }
      Navigator.of(context).pop(
        GuidanceScheduleTag(
          id: existing?.id ?? 'gtag-${DateTime.now().microsecondsSinceEpoch}',
          tagName: name,
          color: color.value,
        ),
      );
    }

    return AlertDialog(
      title: Text(existing == null ? 'Add tag' : 'Edit tag'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: nameCtrl,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Tag name',
              errorText: error.value,
            ),
          ),
          const SizedBox(height: 16),
          Text('Color', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final hex in _palette)
                GestureDetector(
                  onTap: () => color.value = hex,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _parse(hex),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: color.value == hex
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
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

  static Color _parse(String hex) {
    final String h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
