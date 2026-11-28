import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offense_providers.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offenses_notifier.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/dialogs/offense_level_form_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class LevelsTab extends ConsumerWidget {
  const LevelsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<dynamic> levels = [...ref.watch(offenseLevelsProvider)]
      ..sort((a, b) => b.severity.compareTo(a.severity));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final OffenseLevel? created = await showOffenseLevelForm(
                  context,
                );
                if (created != null) {
                  await ref.read(offenseLevelsProvider.notifier).add(created);
                }
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add level'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: AppDataTable<OffenseLevel>(
            columns: [
              AppDataTableColumn(
                label: 'Level',
                sortBy: (l) => l.name.toLowerCase(),
              ),
              AppDataTableColumn(
                label: 'Severity',
                numeric: true,
                sortBy: (l) => l.severity,
              ),
              AppDataTableColumn(
                label: 'Offenses',
                numeric: true,
                sortBy: (l) => ref.read(offenseCountForLevelProvider(l.id)),
              ),
              const AppDataTableColumn(label: ''),
            ],
            mobileTileBuilder: (context, l) {
              final int count = ref.watch(offenseCountForLevelProvider(l.id));
              return ListTile(
                title: Text(l.name),
                subtitle: Text('Severity ${l.severity} • $count offenses'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => _delete(context, ref, l),
                ),
              );
            },
            emptyState: const AppEmptyState(
              icon: Icons.trending_up_rounded,
              title: 'No levels yet',
              message: 'Add the first one to get started.',
            ),
            rows: [
              for (final l in levels)
                AppDataRow<OffenseLevel>(
                  payload: l,
                  cells: [
                    Text(l.name),
                    Text('${l.severity}'),
                    Text('${ref.watch(offenseCountForLevelProvider(l.id))}'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () async {
                            final OffenseLevel? updated =
                                await showOffenseLevelForm(
                                  context,
                                  existing: l,
                                );
                            if (updated != null) {
                              await ref
                                  .read(offenseLevelsProvider.notifier)
                                  .update(updated);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => _delete(context, ref, l),
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
    OffenseLevel level,
  ) async {
    final int count = ref.read(offenseCountForLevelProvider(level.id));
    if (count > 0) {
      await appConfirm(
        context,
        title: 'Cannot delete',
        message:
            '$count offense(s) are at "${level.name}". '
            'Reassign them first.',
        confirmLabel: 'OK',
        cancelLabel: 'Close',
        destructive: true,
      );
      return;
    }
    final bool ok = await appConfirm(
      context,
      title: 'Delete level?',
      message: 'Delete "${level.name}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) await ref.read(offenseLevelsProvider.notifier).delete(level.id);
  }
}
