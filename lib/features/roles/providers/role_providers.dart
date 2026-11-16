import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_notifier.dart';
import 'package:hooks_riverpod/misc.dart';

/// Lookup a role by id.
final ProviderFamily<Role?, String> roleByIdProvider =
    Provider.family<Role?, String>((ref, id) {
      return ref.watch(rolesProvider.notifier).byId(id);
    });

/// The role of the currently logged-in user, or null.
final Provider<Role?> currentRoleProvider = Provider<Role?>((ref) {
  final UserAccount? user = ref.watch(authProvider);
  if (user == null) return null;
  return ref.watch(rolesProvider.notifier).byId(user.roleId);
});

/// Privilege set of the currently logged-in user, or empty.
final Provider<Set<Privilege>> currentPrivilegesProvider =
    Provider<Set<Privilege>>((ref) {
      final Role? role = ref.watch(currentRoleProvider);
      return role?.privileges ?? const <Privilege>{};
    });
