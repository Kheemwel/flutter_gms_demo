import 'package:flutter_gms_demo/core/models/guidance_program.dart';

final List<GuidanceScheduleTag> seedGuidanceScheduleTags = const [
  GuidanceScheduleTag(
    id: 'gtag-activity',
    tagName: 'Activity',
    color: '#4CAF50',
  ),
  GuidanceScheduleTag(id: 'gtag-meeting', tagName: 'Meeting', color: '#2196F3'),
  GuidanceScheduleTag(
    id: 'gtag-deadline',
    tagName: 'Deadline',
    color: '#F44336',
  ),
  GuidanceScheduleTag(id: 'gtag-holiday', tagName: 'Holiday', color: '#9C27B0'),
];

/// Events anchored around "now" so the calendar is populated
/// on first run. Includes one public event, one private to the
/// guidance user, and one private to a specific student.
List<GuidanceProgram> seedGuidancePrograms() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  return [
    GuidanceProgram(
      id: 'prog-1',
      title: 'Nutrition Month Kickoff',
      description: 'School-wide kickoff assembly.',
      programStart: today.add(const Duration(days: 2, hours: 8)),
      programEnd: today.add(const Duration(days: 2, hours: 10)),
      scheduleTagId: 'gtag-activity',
      isPublic: true,
      createdByUserId: 'user-2',
    ),
    GuidanceProgram(
      id: 'prog-2',
      title: 'Guidance Team Sync',
      description: 'Weekly internal meeting for guidance staff.',
      programStart: today.add(const Duration(days: 4, hours: 14)),
      programEnd: today.add(const Duration(days: 4, hours: 15)),
      scheduleTagId: 'gtag-meeting',
      isPublic: false,
      privateRecipients: const ['user-2', 'user-1'],
      createdByUserId: 'user-2',
    ),
    GuidanceProgram(
      id: 'prog-3',
      title: 'Parent-Teacher Conference',
      description: 'Open slots throughout the afternoon.',
      programStart: today.add(const Duration(days: 7, hours: 13)),
      programEnd: today.add(const Duration(days: 7, hours: 17)),
      scheduleTagId: 'gtag-activity',
      isPublic: true,
      createdByUserId: 'user-2',
    ),
    GuidanceProgram(
      id: 'prog-4',
      title: 'Student Catch-up Session',
      description: 'Focused session for Sam.',
      programStart: today.add(const Duration(days: 1, hours: 15)),
      programEnd: today.add(const Duration(days: 1, hours: 16)),
      scheduleTagId: 'gtag-meeting',
      isPublic: false,
      privateRecipients: const ['user-2', 'user-3'],
      createdByUserId: 'user-2',
    ),
  ];
}
