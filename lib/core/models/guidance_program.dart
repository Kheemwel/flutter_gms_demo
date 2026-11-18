import 'package:freezed_annotation/freezed_annotation.dart';

part 'guidance_program.freezed.dart';

@freezed
abstract class GuidanceScheduleTag with _$GuidanceScheduleTag {
  const factory GuidanceScheduleTag({
    required String id,
    required String tagName,

    /// Hex color string, e.g. `#4CAF50`.
    required String color,
  }) = _GuidanceScheduleTag;

  const GuidanceScheduleTag._();

  /// Returns `#4CAF50` → `0xFF4CAF50` (int color) for Flutter.
  int get colorValue {
    final String hex = color.replaceFirst('#', '');
    return int.parse('FF$hex', radix: 16);
  }
}

@freezed
abstract class GuidanceProgram with _$GuidanceProgram {
  const factory GuidanceProgram({
    required String id,
    required String title,
    @Default('') String description,
    required DateTime programStart,
    required DateTime programEnd,
    required String scheduleTagId,
    required bool isPublic,

    /// Only used when [isPublic] is false. Creator is always in this
    /// list — matches original's `$this->selected_users[] = $this->user_id`.
    @Default(<String>[]) List<String> privateRecipients,
    required String createdByUserId,
  }) = _GuidanceProgram;

  const GuidanceProgram._();

  /// True if this event should be visible to [userId].
  bool isVisibleTo(String userId) {
    if (isPublic) return true;
    return privateRecipients.contains(userId);
  }

  /// True if this event occurs on [day] (date-only comparison).
  bool occursOn(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final s = DateTime(programStart.year, programStart.month, programStart.day);
    final e = DateTime(programEnd.year, programEnd.month, programEnd.day);
    return !d.isBefore(s) && !d.isAfter(e);
  }
}
