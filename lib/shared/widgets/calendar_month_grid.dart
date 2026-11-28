import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';

class CalendarMonthGrid extends StatelessWidget {
  const CalendarMonthGrid({
    super.key,
    required this.anchor,
    required this.selectedDay,
    required this.eventCounts,
    required this.onDaySelected,
    this.onMonthChanged,
    this.compact = false,
  });

  final DateTime anchor; // first day of the visible month
  final DateTime selectedDay;
  final Map<int, int> eventCounts;
  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<DateTime>? onMonthChanged;
  final bool compact;

  static const List<String> _weekdayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    final firstOfMonth = DateTime(anchor.year, anchor.month, 1);
    final int daysInMonth = DateTime(anchor.year, anchor.month + 1, 0).day;

    // Dart's weekday: Mon=1 … Sun=7. Our grid is Mon-first.
    final int leadingEmpty = firstOfMonth.weekday - 1;

    final cells = <Widget>[];
    for (int i = 0; i < leadingEmpty; i++) {
      cells.add(const SizedBox.shrink());
    }
    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(anchor.year, anchor.month, d);
      final bool isSelected =
          date.year == selectedDay.year &&
          date.month == selectedDay.month &&
          date.day == selectedDay.day;
      final bool isToday = _isToday(date);
      final int count = eventCounts[d] ?? 0;
      cells.add(
        _DayCell(
          date: date,
          isSelected: isSelected,
          isToday: isToday,
          eventCount: count,
          compact: compact,
          onTap: () => onDaySelected(date),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Row(
          children: [
            IconButton(
              tooltip: 'Previous month',
              onPressed: () {
                final prev = DateTime(anchor.year, anchor.month - 1, 1);
                (onMonthChanged ?? onDaySelected)(prev);
              },
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            Expanded(
              child: Text(
                _monthLabel(anchor),
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
            ),
            IconButton(
              tooltip: 'Next month',
              onPressed: () {
                final next = DateTime(anchor.year, anchor.month + 1, 1);
                (onMonthChanged ?? onDaySelected)(next);
              },
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Weekday header
        Row(
          children: [
            for (final w in _weekdayLabels)
              Expanded(
                child: Center(
                  child: Text(w, style: context.textTheme.labelSmall),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        // Grid
        for (int row = 0; row * 7 < cells.length; row++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int col = 0; col < 7; col++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: row * 7 + col < cells.length
                        ? cells[row * 7 + col]
                        : const SizedBox.shrink(),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  bool _isToday(DateTime d) {
    final now = DateTime.now();
    return now.year == d.year && now.month == d.month && now.day == d.day;
  }

  String _monthLabel(DateTime d) {
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
    return '${months[d.month - 1]} ${d.year}';
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.eventCount,
    required this.compact,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final int eventCount;
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color bg = isSelected
        ? scheme.primary
        : isToday
        ? scheme.primaryContainer.withValues(alpha: 0.4)
        : Colors.transparent;
    final Color fg = isSelected ? scheme.onPrimary : scheme.onSurface;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: compact ? 4 : 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${date.day}',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: fg,
                  fontWeight: isSelected || isToday
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 3),
              if (eventCount > 0)
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isSelected ? scheme.onPrimary : scheme.primary,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
