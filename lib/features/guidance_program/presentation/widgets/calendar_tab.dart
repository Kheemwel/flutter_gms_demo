import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_notifier.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_providers.dart';
import 'package:flutter_gms_demo/features/guidance_program/presentation/dialogs/event_form_dialog.dart';
import 'package:flutter_gms_demo/features/guidance_program/presentation/dialogs/view_event_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/calendar_month_grid.dart';

class CalendarTab extends ConsumerWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime anchor = ref.watch(calendarMonthAnchorProvider);
    final DateTime selectedDay = ref.watch(selectedCalendarDayProvider);
    final Map<int, int> counts = ref.watch(monthEventCountsProvider);
    final List<GuidanceProgram> dayEvents = ref.watch(
      selectedDayEventsProvider,
    );
    final Map<String, GuidanceScheduleTag> tags = ref.watch(
      guidanceTagByIdProvider,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar column
        Expanded(
          flex: 5,
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CalendarMonthGrid(
                    anchor: anchor,
                    selectedDay: selectedDay,
                    eventCounts: counts,
                    onDaySelected: (d) {
                      // d might be a different month than the anchor.
                      ref.read(calendarMonthAnchorProvider.notifier).state =
                          DateTime(d.year, d.month, 1);
                      ref.read(selectedCalendarDayProvider.notifier).state = d;
                    },
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () async {
                      final GuidanceProgram? created = await showEventForm(
                        context,
                        initialDate: selectedDay,
                      );
                      if (created != null) {
                        ref.read(selectedCalendarDayProvider.notifier).state =
                            selectedDay;
                      }
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add event'),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Day detail column
        Expanded(
          flex: 4,
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _dayLabel(selectedDay),
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: dayEvents.isEmpty
                        ? const AppEmptyState(
                            icon: Icons.event_available_rounded,
                            title: 'No events',
                            message: 'Nothing scheduled for this day.',
                          )
                        : ListView.separated(
                            itemCount: dayEvents.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, i) {
                              final GuidanceProgram e = dayEvents[i];
                              final GuidanceScheduleTag? tag =
                                  tags[e.scheduleTagId];
                              return _EventCard(
                                program: e,
                                tag: tag,
                                onTap: () => showDialog<void>(
                                  context: context,
                                  builder: (_) => ViewEventDialog(program: e),
                                ),
                                onEdit: () =>
                                    showEventForm(context, existing: e),
                                onDelete: () => _delete(context, ref, e),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _dayLabel(DateTime d) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    GuidanceProgram p,
  ) async {
    final bool ok = await appConfirm(
      context,
      title: 'Delete event?',
      message: 'Delete "${p.title}"? This cannot be undone.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) {
      await ref.read(guidanceProgramsProvider.notifier).delete(p.id);
    }
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.program,
    required this.tag,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final GuidanceProgram program;
  final GuidanceScheduleTag? tag;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color accent = tag == null ? scheme.primary : Color(tag!.colorValue);

    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: accent, width: 4)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(program.title, style: context.textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      '${_time(program.programStart)} – '
                      '${_time(program.programEnd)}'
                      '${program.isPublic ? '' : ' · Private'}',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (v) {
                  if (v == 'edit') onEdit();
                  if (v == 'delete') onDelete();
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _time(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';
}
