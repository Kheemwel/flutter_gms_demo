import 'package:freezed_annotation/freezed_annotation.dart';

import 'grade_level.dart';
import 'user_role.dart';

part 'user_profile.freezed.dart';

/// Sealed profile attached to a [UserAccount].
/// Compile-time guarantees: a Student always has an LRN + grade;
/// a Parent always has child ids; etc.
@freezed
sealed class UserProfile with _$UserProfile {
  const factory UserProfile.admin() = AdminProfile;
  const factory UserProfile.guidance() = GuidanceProfile;
  const factory UserProfile.teacher() = TeacherProfile;
  const factory UserProfile.student({
    required String lrn,
    required GradeLevel gradeLevel,
  }) = StudentProfile;
  const factory UserProfile.parent({required List<String> childIds}) =
      ParentProfile;
  const factory UserProfile.principal({required PrincipalPosition position}) =
      PrincipalProfile;
}
