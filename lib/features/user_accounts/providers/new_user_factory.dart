import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_form_state.dart';

/// Builds a [UserAccount] from a validated form + role.
/// Guarantees `profile` matches `role.kind` — this is the runtime
/// counterpart to the sealed-class compile-time guarantee.
UserAccount userFromForm({
  required UserFormState form,
  required Role role,
  UserAccount? existing,
}) {
  final UserProfile profile = switch (role.kind) {
    RoleKind.admin => const UserProfile.admin(),
    RoleKind.guidance => const UserProfile.guidance(),
    RoleKind.teacher => const UserProfile.teacher(),
    RoleKind.student => UserProfile.student(
      lrn: form.lrn.trim(),
      gradeLevel: form.gradeLevel,
    ),
    RoleKind.parent => UserProfile.parent(
      childIds: List<String>.unmodifiable(form.childIds),
    ),
    RoleKind.principal => UserProfile.principal(position: form.position),
  };

  if (existing != null) {
    return existing.copyWith(
      firstName: form.firstName.trim(),
      lastName: form.lastName.trim(),
      email: form.email.trim().toLowerCase(),
      roleId: role.id,
      profile: profile,
    );
  }

  return UserAccount(
    id: 'user-${DateTime.now().microsecondsSinceEpoch}',
    firstName: form.firstName.trim(),
    lastName: form.lastName.trim(),
    email: form.email.trim().toLowerCase(),
    roleId: role.id,
    profile: profile,
    isArchived: false,
    totalLogin: 0,
    mustChangePassword: true, // new users must rotate the demo password
    // The password itself isn't stored on the model — the login check
    // compares against `demoPassword` from seed_users.dart. In a real
    // app the server would hold the hash.
  );
}
