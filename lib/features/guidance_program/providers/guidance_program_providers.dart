import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_notifier.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:hooks_riverpod/misc.dart';

final Provider<Map<String, GuidanceScheduleTag>> guidanceTagByIdProvider =
    Provider<Map<String, GuidanceScheduleTag>>((ref) {
      final List<GuidanceScheduleTag> all = ref.watch(
        guidanceScheduleTagsProvider,
      );
      return {for (final t in all) t.id: t};
    });

/// Events the currently-logged-in user is allowed to see.
final Provider<List<GuidanceProgram>> visibleProgramsProvider =
    Provider<List<GuidanceProgram>>((ref) {
      final UserAccount? me = ref.watch(authProvider);
      final List<GuidanceProgram> all = ref.watch(guidanceProgramsProvider);
      if (me == null) return const [];
      return all.where((p) => p.isVisibleTo(me.id)).toList(growable: false);
    });

/// Anchor month for the calendar. Null → "current month".
final StateProvider<DateTime> calendarMonthAnchorProvider =
    StateProvider<DateTime>((ref) {
      final now = DateTime.now();
      return DateTime(now.year, now.month, 1);
    });

/// Selected day in the month grid. Defaults to today.
final StateProvider<DateTime> selectedCalendarDayProvider =
    StateProvider<DateTime>((ref) {
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day);
    });

/// Events visible to the user that occur on the currently-selected day.
final Provider<List<GuidanceProgram>> selectedDayEventsProvider =
    Provider<List<GuidanceProgram>>((ref) {
      final List<GuidanceProgram> visible = ref.watch(visibleProgramsProvider);
      final DateTime day = ref.watch(selectedCalendarDayProvider);
      return visible.where((p) => p.occursOn(day)).toList(growable: false)
        ..sort((a, b) => a.programStart.compareTo(b.programStart));
    });

/// Map day → event count for the current month, for dot indicators.
final Provider<Map<int, int>> monthEventCountsProvider =
    Provider<Map<int, int>>((ref) {
      final DateTime anchor = ref.watch(calendarMonthAnchorProvider);
      final List<GuidanceProgram> visible = ref.watch(visibleProgramsProvider);
      final int daysInMonth = DateTime(anchor.year, anchor.month + 1, 0).day;

      final counts = <int, int>{};
      for (int d = 1; d <= daysInMonth; d++) {
        final day = DateTime(anchor.year, anchor.month, d);
        final int n = visible.where((p) => p.occursOn(day)).length;
        if (n > 0) counts[d] = n;
      }
      return counts;
    });

/// Count events that use a given tag (for delete-guard).
final ProviderFamily<int, String> programCountForTagProvider =
    Provider.family<int, String>((ref, tagId) {
      return ref
          .watch(guidanceProgramsProvider)
          .where((p) => p.scheduleTagId == tagId)
          .length;
    });
