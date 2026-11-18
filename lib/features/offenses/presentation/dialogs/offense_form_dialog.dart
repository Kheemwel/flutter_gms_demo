import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offenses_notifier.dart';

Future<Offense?> showOffenseForm(BuildContext context, {Offense? existing}) {
  return showDialog<Offense>(
    context: context,
    builder: (_) => _OffenseFormDialog(existing: existing),
  );
}

class _OffenseFormDialog extends HookConsumerWidget {
  const _OffenseFormDialog({this.existing});

  final Offense? existing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<OffenseCategory> categories = ref.watch(
      offenseCategoriesProvider,
    );
    final List<OffenseLevel> levels = ref.watch(offenseLevelsProvider);
    final List<DisciplinaryAction> actions = ref.watch(
      disciplinaryActionsProvider,
    );

    final TextEditingController nameCtrl = useTextEditingController(
      text: existing?.name ?? '',
    );
    final TextEditingController descCtrl = useTextEditingController(
      text: existing?.description ?? '',
    );
    final ValueNotifier<String?> categoryId = useState<String?>(
      existing?.categoryId ??
          (categories.isNotEmpty ? categories.first.id : null),
    );
    final ValueNotifier<String?> levelId = useState<String?>(
      existing?.levelId ?? (levels.isNotEmpty ? levels.first.id : null),
    );
    final ValueNotifier<Set<String>> selectedActionIds = useState<Set<String>>(
      (existing?.actionIds ?? const <String>[]).toSet(),
    );
    final ValueNotifier<Map<String, String>> errors =
        useState<Map<String, String>>(const {});

    Future<void> submit() async {
      final e = <String, String>{};
      if (nameCtrl.text.trim().isEmpty) {
        e['name'] = 'Offense name is required.';
      }
      if (categoryId.value == null) e['category'] = 'Pick a category.';
      if (levelId.value == null) e['level'] = 'Pick a level.';
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }
      errors.value = const {};

      final offense = Offense(
        id: existing?.id ?? 'offense-${DateTime.now().microsecondsSinceEpoch}',
        name: nameCtrl.text.trim(),
        categoryId: categoryId.value!,
        levelId: levelId.value!,
        actionIds: selectedActionIds.value.toList(growable: false),
        description: descCtrl.text.trim(),
      );

      final Offenses notifier = ref.read(offensesProvider.notifier);
      if (existing == null) {
        await notifier.add(offense);
      } else {
        await notifier.update(offense);
      }
      if (context.mounted) Navigator.of(context).pop(offense);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 740),
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
                      existing == null ? 'Add offense' : 'Edit offense',
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
                    TextField(
                      controller: nameCtrl,
                      decoration: InputDecoration(
                        labelText: 'Offense name',
                        prefixIcon: const Icon(Icons.gavel_rounded),
                        errorText: errors.value['name'],
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Description (optional)',
                        prefixIcon: Icon(Icons.notes_rounded),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: categoryId.value,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              prefixIcon: Icon(Icons.category_outlined),
                            ),
                            items: [
                              for (final c in categories)
                                DropdownMenuItem(
                                  value: c.id,
                                  child: Text(c.name),
                                ),
                            ],
                            onChanged: (v) => categoryId.value = v,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: levelId.value,
                            decoration: const InputDecoration(
                              labelText: 'Level',
                              prefixIcon: Icon(Icons.trending_up_rounded),
                            ),
                            items: [
                              for (final l in levels)
                                DropdownMenuItem(
                                  value: l.id,
                                  child: Text('${l.name} · sev ${l.severity}'),
                                ),
                            ],
                            onChanged: (v) => levelId.value = v,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Applicable disciplinary actions',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          for (final a in actions)
                            CheckboxListTile(
                              dense: true,
                              title: Text(a.name),
                              subtitle: Text(
                                a.description,
                                style: context.textTheme.bodySmall,
                              ),
                              value: selectedActionIds.value.contains(a.id),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (v) {
                                final next = Set<String>.from(
                                  selectedActionIds.value,
                                );
                                if (v ?? false) {
                                  next.add(a.id);
                                } else {
                                  next.remove(a.id);
                                }
                                selectedActionIds.value = next;
                              },
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
      ),
    );
  }
}
