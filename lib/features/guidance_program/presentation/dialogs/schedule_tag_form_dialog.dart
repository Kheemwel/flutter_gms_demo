import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/guidance_program.dart';

Future<GuidanceScheduleTag?> showScheduleTagForm(
  BuildContext context, {
  GuidanceScheduleTag? existing,
}) {
  final bool isSmall = MediaQuery.sizeOf(context).width < 720;
  if (isSmall) {
    return showModalBottomSheet<GuidanceScheduleTag>(
      context: context,
      useSafeArea: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: _ScheduleTagFormDialog(existing: existing, isSheet: true),
      ),
    );
  }

  return showDialog<GuidanceScheduleTag>(
    context: context,
    builder: (_) => _ScheduleTagFormDialog(existing: existing),
  );
}

class _ScheduleTagFormDialog extends HookWidget {
  const _ScheduleTagFormDialog({this.existing, this.isSheet = false});

  final GuidanceScheduleTag? existing;
  final bool isSheet;

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
    final TextEditingController nameCtrl = useTextEditingController(
      text: existing?.tagName ?? '',
    );
    final ValueNotifier<String> color = useState<String>(
      existing?.color ?? _palette.first,
    );
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

    final Widget formFields = _FormFields(
      nameCtrl: nameCtrl,
      error: error,
      palette: _palette,
      color: color,
    );

    if (isSheet) {
      return _FormSheet(
        existing: existing,
        formFields: formFields,
        submit: submit,
      );
    }

    return AlertDialog(
      title: Text(existing == null ? 'Add tag' : 'Edit tag'),
      content: formFields,
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

class _FormSheet extends StatelessWidget {
  const _FormSheet({
    required this.existing,
    required this.formFields,
    required this.submit,
  });

  final GuidanceScheduleTag? existing;
  final Widget formFields;
  final VoidCallback submit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    existing == null ? 'Add tag' : 'Edit tag',
                    style: Theme.of(context).textTheme.titleLarge,
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: formFields,
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: submit,
                  child: Text(existing == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormFields extends StatelessWidget {
  const _FormFields({
    required this.nameCtrl,
    required this.error,
    required this._palette,
    required this.color,
  });

  final TextEditingController nameCtrl;
  final ValueNotifier<String?> error;
  final List<String> _palette;
  final ValueNotifier<String> color;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  static Color _parse(String hex) {
    final String h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
