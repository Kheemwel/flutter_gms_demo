import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_roles.dart';

part 'role_notifier.g.dart';

@Riverpod(keepAlive: true)
class RolesNotifier extends _$RolesNotifier {
  @override
  List<Role> build() => List<Role>.unmodifiable(seedRoles);

  Role? byId(String id) {
    for (final Role r in state) {
      if (r.id == id) return r;
    }
    return null;
  }

  void add(Role role) {
    state = [...state, role];
  }

  void update(Role updated) {
    state = [for (final Role r in state) r.id == updated.id ? updated : r];
  }

  void remove(String id) {
    state = state.where((Role r) => r.id != id).toList(growable: false);
  }

  /// True if any non-archived user is currently assigned [roleId].
  /// This is the guard the delete dialog uses so admins can't orphan
  /// users by deleting a role in use — a fix over the original, which
  /// silently blocked deletion via DB FK error with no UX.
  bool isInUse(String roleId) => _assignedRoleIds.contains(roleId);

  /// Populated by `user_accounts` feature in a later batch.
  /// For now, hard-coded to reflect the seeded users.
  Set<String> get _assignedRoleIds => const {
    'role-admin',
    'role-guidance',
    'role-student',
    'role-parent',
    'role-teacher',
    'role-principal-jr',
    'role-principal-sr',
  };
}
