import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_providers.dart';

class ViewEventDialog extends ConsumerWidget {
  const ViewEventDialog({super.key, required this.program});

  final GuidanceProgram program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, GuidanceScheduleTag> tags = ref.watch(guidanceTagByIdProvider);
    final GuidanceScheduleTag? tag = tags[program.scheduleTagId];

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
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
                      program.title,
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
                        if (tag != null)
                          Chip(
                            avatar: Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                color: Color(tag.colorValue),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            label: Text(tag.tagName),
                          ),
                        Chip(
                          avatar: Icon(
                            program.isPublic
                                ? Icons.public_rounded
                                : Icons.lock_outline_rounded,
                            size: 16,
                          ),
                          label: Text(program.isPublic ? 'Public' : 'Private'),
                        ),
                      ],
                    ),
                    if (program.description.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        program.description,
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: 16),
                    _Row('Starts', _fmt(program.programStart)),
                    _Row('Ends', _fmt(program.programEnd)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: context.textTheme.bodySmall),
          ),
          Expanded(child: Text(value, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
