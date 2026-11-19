import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';

/// Centralized prefill for a Home Visitation form. Both the
/// teacher-facing "New request" and the guidance-facing approval
/// path call this, so the resulting forms are byte-for-byte
/// identical regardless of entry point.
Form buildHomeVisitationForm({
  required String formId,
  required DateTime now,
  required UserAccount createdBy,
  required UserAccount teacher,
  required UserAccount student,
  required UserAccount parent,
  required UserAccount juniorPrincipal,
  required UserAccount seniorPrincipal,
}) {
  final UserProfile profile = student.profile;
  if (profile is! StudentProfile) {
    throw ArgumentError('student.profile must be StudentProfile');
  }

  return Form(
    id: formId,
    formType: FormType.homeVisitation,
    status: FormStatus.incomplete,
    createdByUserId: createdBy.id,
    createdAt: now,
    data: FormData.homeVisitation(
      studentId: student.id,
      studentName: student.fullName,
      teacherId: teacher.id,
      teacherName: teacher.fullName,
      guidanceId: createdBy.id,
      guidanceName: createdBy.fullName,
      parentId: parent.id,
      parentName: parent.fullName,
      juniorPrincipalId: juniorPrincipal.id,
      juniorPrincipalName: juniorPrincipal.fullName,
      seniorPrincipalId: seniorPrincipal.id,
      seniorPrincipalName: seniorPrincipal.fullName,
      fields: {
        'student_surname': student.lastName,
        'student_firstname': student.firstName,
        'lrn': profile.lrn,
        'level_section': '${profile.gradeLevel.label} Mars',
      },
    ),
  );
}

/// The same helper for a Violation form. Kept here for symmetry;
/// violation prefill is currently empty but the pattern is the same.
Form buildViolationForm({
  required String formId,
  required DateTime now,
  required UserAccount createdBy,
  required UserAccount teacher,
  required List<UserAccount> students,
}) {
  return Form(
    id: formId,
    formType: FormType.violation,
    status: FormStatus.incomplete,
    createdByUserId: createdBy.id,
    createdAt: now,
    data: FormData.violation(
      teacherId: teacher.id,
      teacherName: teacher.fullName,
      studentIds: students.map((s) => s.id).toList(growable: false),
      studentNames: students.map((s) => s.fullName).toList(growable: false),
      guidanceId: createdBy.id,
      guidanceName: createdBy.fullName,
    ),
  );
}
