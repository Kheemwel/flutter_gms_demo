import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:hooks_riverpod/misc.dart';

enum UserAccountTab { active, archived }

final StateProvider<UserAccountTab> userAccountTabProvider =
    StateProvider<UserAccountTab>((ref) => UserAccountTab.active);

final StateProvider<String> userAccountSearchProvider = StateProvider<String>(
  (ref) => '',
);

final StateProvider<RoleKind?> userAccountRoleFilterProvider =
    StateProvider<RoleKind?>((ref) => null);

/// Build a roleId → RoleKind map once per roles change.
final Provider<Map<String, RoleKind>> roleKindLookupProvider =
    Provider<Map<String, RoleKind>>((ref) {
      final List<Role> all = ref.watch(rolesProvider);
      return {for (final r in all) r.id: r.kind};
    });

final Provider<List<UserAccount>> filteredUsersProvider =
    Provider<List<UserAccount>>((ref) {
      final List<UserAccount> all = ref.watch(userAccountsProvider);
      final UserAccountTab tab = ref.watch(userAccountTabProvider);
      final String query = ref.watch(userAccountSearchProvider).trim();
      final RoleKind? roleFilter = ref.watch(userAccountRoleFilterProvider);
      final Map<String, RoleKind> kindsByRoleId = ref.watch(
        roleKindLookupProvider,
      );

      final bool wantArchived = tab == UserAccountTab.archived;
      final String q = query.toLowerCase();

      return all
          .where((UserAccount u) {
            if (u.isArchived != wantArchived) return false;
            if (roleFilter != null && kindsByRoleId[u.roleId] != roleFilter) {
              return false;
            }
            if (q.isEmpty) return true;
            return u.fullName.toLowerCase().contains(q) ||
                u.email.toLowerCase().contains(q);
          })
          .toList(growable: false);
    });

final Provider<({int active, int archived})> userCountsProvider =
    Provider<({int active, int archived})>((ref) {
      final List<UserAccount> all = ref.watch(userAccountsProvider);
      int active = 0;
      int archived = 0;
      for (final u in all) {
        if (u.isArchived) {
          archived++;
        } else {
          active++;
        }
      }
      return (active: active, archived: archived);
    });

final ProviderFamily<UserAccount?, String> userByIdProvider =
    Provider.family<UserAccount?, String>((ref, id) {
      final List<UserAccount> all = ref.watch(userAccountsProvider);
      for (final u in all) {
        if (u.id == id) return u;
      }
      return null;
    });
