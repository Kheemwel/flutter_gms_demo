import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offense_providers.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offenses_notifier.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/dialogs/offense_form_dialog.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/dialogs/view_offense_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class OffensesTab extends ConsumerWidget {
  const OffensesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Offense> offenses = ref.watch(filteredOffensesProvider);
    final Map<String, OffenseCategory> cats = ref.watch(
      offenseCategoryByIdProvider,
    );
    final Map<String, OffenseLevel> levels = ref.watch(
      offenseLevelByIdProvider,
    );
    final Map<String, DisciplinaryAction> actions = ref.watch(
      offenseActionByIdProvider,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search by name, category, description…',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
                onChanged: (v) =>
                    ref.read(offenseSearchProvider.notifier).state = v,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 200,
              child: DropdownButtonFormField<String?>(
                isExpanded: true,
                initialValue: ref.watch(offenseCategoryFilterProvider),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.filter_alt_outlined),
                ),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text(
                      'All categories',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  for (final c in cats.values)
                    DropdownMenuItem<String?>(value: c.id, child: Text(c.name)),
                ],
                onChanged: (v) =>
                    ref.read(offenseCategoryFilterProvider.notifier).state = v,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 180,
              child: DropdownButtonFormField<String?>(
                isExpanded: true,
                initialValue: ref.watch(offenseLevelFilterProvider),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.trending_up_rounded),
                ),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('All levels', overflow: TextOverflow.ellipsis),
                  ),
                  for (final l in levels.values)
                    DropdownMenuItem<String?>(value: l.id, child: Text(l.name)),
                ],
                onChanged: (v) =>
                    ref.read(offenseLevelFilterProvider.notifier).state = v,
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: () async {
                await showOffenseForm(context);
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add offense'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: AppDataTable<Offense>(
            columns: [
              AppDataTableColumn(
                label: 'Offense',
                sortBy: (o) => o.name.toLowerCase(),
              ),
              AppDataTableColumn(
                label: 'Category',
                sortBy: (o) => (cats[o.categoryId]?.name ?? '').toLowerCase(),
              ),
              AppDataTableColumn(
                label: 'Level',
                sortBy: (o) => levels[o.levelId]?.severity ?? 0,
              ),
              AppDataTableColumn(
                label: 'Actions',
                numeric: true,
                sortBy: (o) => o.actionIds.length,
              ),
              const AppDataTableColumn(label: ''),
            ],
            onRowTap: (Offense o) {
              showDialog<void>(
                context: context,
                builder: (_) => ViewOffenseDialog(offense: o),
              );
            },
            mobileTileBuilder: (context, o) => ListTile(
              title: Text(o.name),
              subtitle: Text(
                '${cats[o.categoryId]?.name ?? '—'} • ${levels[o.levelId]?.name ?? '—'} • ${o.actionIds.length} actions',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: () => _delete(context, ref, o, actions),
              ),
            ),
            emptyState: const AppEmptyState(
              icon: Icons.gavel_outlined,
              title: 'No offenses match',
              message: 'Try a different search or filter.',
            ),
            rows: [
              for (final o in offenses)
                AppDataRow<Offense>(
                  payload: o,
                  cells: [
                    Text(o.name),
                    Text(cats[o.categoryId]?.name ?? '—'),
                    _LevelChip(level: levels[o.levelId]),
                    Text('${o.actionIds.length}'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility_outlined),
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (_) => ViewOffenseDialog(offense: o),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () =>
                              showOffenseForm(context, existing: o),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => _delete(context, ref, o, actions),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Offense o,
    Map<String, DisciplinaryAction> actions,
  ) async {
    // TODO(Batch 8): block if a ViolationForm references this offense.
    // For now, nothing references it because the Forms feature isn't
    // built yet — but the count check is wired so this can be extended
    // without touching this method.
    final bool ok = await appConfirm(
      context,
      title: 'Delete offense?',
      message:
          'Delete "${o.name}"? This cannot be undone. '
          'Existing violation forms will lose the offense reference.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) {
      await ref.read(offensesProvider.notifier).delete(o.id);
    }
  }
}

class _LevelChip extends StatelessWidget {
  const _LevelChip({required this.level});
  final OffenseLevel? level;

  @override
  Widget build(BuildContext context) {
    if (level == null) return const Text('—');
    final (Color, Color) colors = _colorsFor(context, level!.severity);
    return Chip(
      visualDensity: VisualDensity.compact,
      backgroundColor: colors.$1,
      labelStyle: TextStyle(color: colors.$2),
      label: Text('${level!.name} · ${level!.severity}'),
    );
  }

  (Color, Color) _colorsFor(BuildContext context, int severity) {
    final ColorScheme scheme = context.colorScheme;
    if (severity >= 4) {
      return (
        scheme.errorContainer.withValues(alpha: 0.4),
        scheme.onErrorContainer,
      );
    }
    if (severity >= 3) {
      return (
        scheme.tertiaryContainer.withValues(alpha: 0.5),
        scheme.onTertiaryContainer,
      );
    }
    return (scheme.surfaceContainerHighest, scheme.onSurfaceVariant);
  }
}
