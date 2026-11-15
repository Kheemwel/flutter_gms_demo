/// The 6 fixed role *kinds* the system understands.
/// `Roles` (the CRUD entity) carries a [RoleKind] so admins can create
/// variants like "Guidance Assistant" that still behave like guidance.
enum RoleKind {
  admin,
  guidance,
  student,
  parent,
  teacher,
  principal;

  String get label => switch (this) {
    RoleKind.admin => 'Administrator',
    RoleKind.guidance => 'Guidance',
    RoleKind.student => 'Student',
    RoleKind.parent => 'Parent',
    RoleKind.teacher => 'Teacher',
    RoleKind.principal => 'Principal',
  };
}

enum PrincipalPosition {
  juniorHigh('Junior High School Principal'),
  seniorHigh('Senior High School Principal');

  const PrincipalPosition(this.label);
  final String label;
}
