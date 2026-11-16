import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:material_ui/material_ui.dart';

extension RoleKindX on RoleKind {
  bool get isAdmin => this == RoleKind.admin;
  bool get isGuidance => this == RoleKind.guidance;
  bool get isStudent => this == RoleKind.student;
  bool get isParent => this == RoleKind.parent;
  bool get isTeacher => this == RoleKind.teacher;
  bool get isPrincipal => this == RoleKind.principal;

  /// Roles that have a profile with user-editable fields beyond
  /// first/last name + email.
  bool get hasProfileFields => isStudent || isParent || isPrincipal;

  IconData? get icon => switch (this) {
    RoleKind.admin => Icons.admin_panel_settings_rounded,
    RoleKind.guidance => Icons.support_agent_rounded,
    RoleKind.student => Icons.school_rounded,
    RoleKind.parent => Icons.family_restroom_rounded,
    RoleKind.teacher => Icons.co_present_rounded,
    RoleKind.principal => Icons.badge_rounded,
  };
}
