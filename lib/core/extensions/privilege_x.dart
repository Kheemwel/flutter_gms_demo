import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_providers.dart';

extension PrivilegeX on WidgetRef {
  /// True if the currently-logged-in user has [p] (or the admin catch-all).
  bool can(Privilege p) {
    final Set<Privilege> current = read(currentPrivilegesProvider);
    if (current.contains(Privilege.admin)) return true;
    return current.contains(p);
  }

  /// True if the user has any of the given privileges.
  bool canAny(Iterable<Privilege> ps) {
    final Set<Privilege> current = read(currentPrivilegesProvider);
    if (current.contains(Privilege.admin)) return true;
    return ps.any(current.contains);
  }
}

extension PrivilegeContextX on BuildContext {
  /// Same as [PrivilegeX.can] but on a BuildContext. Only use this
  /// when you can't grab a WidgetRef — prefer the ref version.
  bool can(Set<Privilege> privileges, Privilege p) {
    if (privileges.contains(Privilege.admin)) return true;
    return privileges.contains(p);
  }
}
