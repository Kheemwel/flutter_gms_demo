import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_profile.dart';
import 'user_role.dart';

part 'user_account.freezed.dart';

@freezed
abstract class UserAccount with _$UserAccount {
  const factory UserAccount({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String roleId,
    required UserProfile profile,
    required bool isArchived,
    required int totalLogin,
    @Default(false) bool mustChangePassword,
    DateTime? lastLogin,
    String? rememberToken,
  }) = _UserAccount;

  const UserAccount._();

  String get fullName => '$firstName $lastName';

  /// Derived role kind — requires the [Role] looked up by [roleId].
  /// Widgets should use `ref.watch(roleProvider(roleId)).value?.kind`,
  /// but this convenience is handy for short checks.
  RoleKind kindOf(Map<String, Role> roles) =>
      roles[roleId]?.kind ?? RoleKind.student;
}
