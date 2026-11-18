import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offense_providers.dart';

class ViewOffenseDialog extends ConsumerWidget {
  const ViewOffenseDialog({super.key, required this.offense});

  final Offense offense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, OffenseCategory> cats = ref.watch(offenseCategoryByIdProvider);
    final Map<String, OffenseLevel> levels = ref.watch(offenseLevelByIdProvider);
    final Map<String, DisciplinaryAction> actions = ref.watch(offenseActionByIdProvider);

    final OffenseCategory? cat = cats[offense.categoryId];
    final OffenseLevel? level = levels[offense.levelId];

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 680),
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
                      offense.name,
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
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (cat != null)
                          Chip(
                            avatar: const Icon(
                              Icons.category_rounded,
                              size: 16,
                            ),
                            label: Text(cat.name),
                          ),
                        if (level != null)
                          Chip(
                            avatar: const Icon(
                              Icons.trending_up_rounded,
                              size: 16,
                            ),
                            label: Text(
                              '${level.name} · sev ${level.severity}',
                            ),
                          ),
                      ],
                    ),
                    if (offense.description.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text('Description', style: context.textTheme.titleSmall),
                      const SizedBox(height: 4),
                      Text(
                        offense.description,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: 20),
                    Text(
                      'Applicable actions',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    if (offense.actionIds.isEmpty)
                      Text('None defined.', style: context.textTheme.bodySmall)
                    else
                      for (final id in offense.actionIds)
                        if (actions[id] != null)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.arrow_right_rounded),
                            title: Text(actions[id]!.name),
                            subtitle: actions[id]!.description.isEmpty
                                ? null
                                : Text(actions[id]!.description),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
