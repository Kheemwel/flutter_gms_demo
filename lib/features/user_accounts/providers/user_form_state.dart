import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_gms_demo/core/models/grade_level.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';

part 'user_form_state.freezed.dart';

@freezed
abstract class UserFormState with _$UserFormState {
  const factory UserFormState({
    // Shared
    required RoleKind kind,
    required String firstName,
    required String lastName,
    required String email,

    // Student-only
    @Default('') String lrn,
    @Default(GradeLevel.grade9) GradeLevel gradeLevel,

    // Parent-only
    @Default(<String>[]) List<String> childIds,

    // Principal-only
    @Default(PrincipalPosition.juniorHigh) PrincipalPosition position,
  }) = _UserFormState;

  factory UserFormState.empty(RoleKind kind) =>
      UserFormState(kind: kind, firstName: '', lastName: '', email: '');

  factory UserFormState.fromUser(UserAccount user) {
    final UserProfile profile = user.profile;
    final RoleKind kind = switch (profile) {
      AdminProfile() => RoleKind.admin,
      GuidanceProfile() => RoleKind.guidance,
      TeacherProfile() => RoleKind.teacher,
      StudentProfile() => RoleKind.student,
      ParentProfile() => RoleKind.parent,
      PrincipalProfile() => RoleKind.principal,
    };
    return UserFormState(
      kind: kind,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      lrn: profile is StudentProfile ? profile.lrn : '',
      gradeLevel: profile is StudentProfile
          ? profile.gradeLevel
          : GradeLevel.grade9,
      childIds: profile is ParentProfile ? profile.childIds : const <String>[],
      position: profile is PrincipalProfile
          ? profile.position
          : PrincipalPosition.juniorHigh,
    );
  }
}
