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

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < 720;
        final bool isShort = constraints.maxHeight < 520;
        final double cardPadding = isShort ? 12 : 16;
        final double gap = isShort ? 10 : 16;

        final Widget calendarCard = Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                CalendarMonthGrid(
                  anchor: anchor,
                  selectedDay: selectedDay,
                  eventCounts: counts,
                  compact: isShort,
                  onMonthChanged: (m) {
                    ref.read(calendarMonthAnchorProvider.notifier).state = m;
                    ref.read(selectedCalendarDayProvider.notifier).state = m;
                  },
                  onDaySelected: (d) {
                    ref.read(calendarMonthAnchorProvider.notifier).state =
                        DateTime(d.year, d.month, 1);
                    ref.read(selectedCalendarDayProvider.notifier).state = d;
                    if (isSmall) {
                      _showDayEventsSheet(context);
                    }
                  },
                ),
                SizedBox(height: gap),
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
        );

        if (isSmall) {
          return SingleChildScrollView(child: calendarCard);
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(child: calendarCard),
            ),
            const SizedBox(width: 16),
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
                                      builder: (_) =>
                                          ViewEventDialog(program: e),
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
      },
    );
  }

  void _showDayEventsSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.92,
        child: _DayEventsBottomSheet(
          dayLabelBuilder: _dayLabel,
          onDelete: (ref, program) => _delete(context, ref, program),
        ),
      ),
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

class _DayEventsBottomSheet extends ConsumerStatefulWidget {
  const _DayEventsBottomSheet({
    required this.dayLabelBuilder,
    required this.onDelete,
  });

  final String Function(DateTime) dayLabelBuilder;
  final Future<void> Function(WidgetRef ref, GuidanceProgram program) onDelete;

  @override
  ConsumerState<_DayEventsBottomSheet> createState() =>
      _DayEventsBottomSheetState();
}

class _DayEventsBottomSheetState extends ConsumerState<_DayEventsBottomSheet> {
  GuidanceProgram? _selectedEvent;

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDay = ref.watch(selectedCalendarDayProvider);
    final List<GuidanceProgram> dayEvents = ref.watch(
      selectedDayEventsProvider,
    );
    final Map<String, GuidanceScheduleTag> tags = ref.watch(
      guidanceTagByIdProvider,
    );

    final GuidanceProgram? event = _selectedEvent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
          child: Row(
            children: [
              if (event != null)
                IconButton(
                  onPressed: () => setState(() => _selectedEvent = null),
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: 'Back to events',
                )
              else
                const SizedBox(width: 12),
              Expanded(
                child: Text(
                  event != null
                      ? event.title
                      : widget.dayLabelBuilder(selectedDay),
                  style: context.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Close',
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              );
            },
            child: event == null
                ? _buildEventsList(context, dayEvents, tags)
                : _buildEventDetails(context, event, tags[event.scheduleTagId]),
          ),
        ),
      ],
    );
  }

  Widget _buildEventsList(
    BuildContext context,
    List<GuidanceProgram> dayEvents,
    Map<String, GuidanceScheduleTag> tags,
  ) {
    if (dayEvents.isEmpty) {
      return const Padding(
        key: ValueKey('empty'),
        padding: EdgeInsets.all(24),
        child: AppEmptyState(
          icon: Icons.event_available_rounded,
          title: 'No events',
          message: 'Nothing scheduled for this day.',
        ),
      );
    }

    return ListView.separated(
      key: const ValueKey('list'),
      padding: const EdgeInsets.all(16),
      itemCount: dayEvents.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final GuidanceProgram e = dayEvents[i];
        return _EventCard(
          program: e,
          tag: tags[e.scheduleTagId],
          onTap: () => setState(() => _selectedEvent = e),
          onEdit: () => showEventForm(context, existing: e),
          onDelete: () => widget.onDelete(ref, e),
        );
      },
    );
  }

  Widget _buildEventDetails(
    BuildContext context,
    GuidanceProgram program,
    GuidanceScheduleTag? tag,
  ) {
    return SizedBox.expand(
      key: ValueKey('detail_${program.id}'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
              Text(program.description, style: context.textTheme.bodyMedium),
            ],
            const SizedBox(height: 16),
            _DetailRow('Starts', _fmt(program.programStart)),
            _DetailRow('Ends', _fmt(program.programEnd)),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);
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
