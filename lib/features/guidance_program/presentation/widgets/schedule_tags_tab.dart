import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_notifier.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_providers.dart';
import 'package:flutter_gms_demo/features/guidance_program/presentation/dialogs/schedule_tag_form_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class ScheduleTagsTab extends ConsumerWidget {
  const ScheduleTagsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<GuidanceScheduleTag> tags = ref.watch(
      guidanceScheduleTagsProvider,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final GuidanceScheduleTag? created = await showScheduleTagForm(
                  context,
                );
                if (created != null) {
                  await ref
                      .read(guidanceScheduleTagsProvider.notifier)
                      .add(created);
                }
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add tag'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: AppDataTable<GuidanceScheduleTag>(
            columns: const [
              AppDataTableColumn(label: 'Tag'),
              AppDataTableColumn(label: 'Color'),
              AppDataTableColumn(label: 'Events', numeric: true),
              AppDataTableColumn(label: ''),
            ],
            emptyState: const AppEmptyState(
              icon: Icons.label_outline_rounded,
              title: 'No tags yet',
              message: 'Add the first one to get started.',
            ),
            rows: [
              for (final t in tags)
                AppDataRow<GuidanceScheduleTag>(
                  payload: t,
                  cells: [
                    Text(t.tagName),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color(t.colorValue),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(t.color),
                      ],
                    ),
                    Text('${ref.watch(programCountForTagProvider(t.id))}'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () async {
                            final GuidanceScheduleTag? updated =
                                await showScheduleTagForm(context, existing: t);
                            if (updated != null) {
                              await ref
                                  .read(guidanceScheduleTagsProvider.notifier)
                                  .update(updated);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => _delete(context, ref, t),
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
    GuidanceScheduleTag tag,
  ) async {
    final int count = ref.read(programCountForTagProvider(tag.id));
    if (count > 0) {
      await appConfirm(
        context,
        title: 'Cannot delete',
        message:
            '$count event(s) use "${tag.tagName}". '
            'Reassign them first.',
        confirmLabel: 'OK',
        cancelLabel: 'Close',
        destructive: true,
      );
      return;
    }
    final bool ok = await appConfirm(
      context,
      title: 'Delete tag?',
      message: 'Delete "${tag.tagName}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) {
      await ref.read(guidanceScheduleTagsProvider.notifier).delete(tag.id);
    }
  }
}
