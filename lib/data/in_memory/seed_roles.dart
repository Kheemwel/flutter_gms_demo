import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';

/// The 7 seeded roles. Two principal variants so the workflows can differ.
final List<Role> seedRoles = [
  Role(
    id: 'role-admin',
    name: 'Administrator',
    kind: RoleKind.admin,
    privileges: Privilege.values.toSet(),
  ),
  const Role(
    id: 'role-guidance',
    name: 'Guidance',
    kind: RoleKind.guidance,
    privileges: {
      Privilege.fillOutForms,
      Privilege.approveForm,
      Privilege.viewAccounts,
      Privilege.manageRoles,
      Privilege.manageWebsiteContent,
      Privilege.viewStudentSummary,
      Privilege.viewStudentsAnecdotal,
      Privilege.writeStudentsAnecdotal,
      Privilege.manageStudentInventory,
      Privilege.studentPrivileges,
      Privilege.manageExpiredItems,
      Privilege.manageClaimedItems,
      Privilege.viewOnlyFoundItems,
      Privilege.addLostAndFound,
      Privilege.deleteLostAndFound,
      Privilege.editLostAndFound,
    },
  ),
  const Role(
    id: 'role-student',
    name: 'Student',
    kind: RoleKind.student,
    privileges: {Privilege.fillOutForms, Privilege.studentPrivileges},
  ),
  const Role(
    id: 'role-parent',
    name: 'Parent',
    kind: RoleKind.parent,
    privileges: {Privilege.fillOutForms, Privilege.parentPrivileges},
  ),
  const Role(
    id: 'role-teacher',
    name: 'Teacher',
    kind: RoleKind.teacher,
    privileges: {
      Privilege.fillOutForms,
      Privilege.requestForm,
      Privilege.viewOnlyFoundItems,
      Privilege.viewStudentSummary,
      Privilege.viewStudentsAnecdotal,
    },
  ),
  const Role(
    id: 'role-principal-jr',
    name: 'Junior High School Principal',
    kind: RoleKind.principal,
    privileges: {
      Privilege.fillOutForms,
      Privilege.approveForm,
      Privilege.viewOnlyFoundItems,
    },
  ),
  const Role(
    id: 'role-principal-sr',
    name: 'Senior High School Principal',
    kind: RoleKind.principal,
    privileges: {
      Privilege.fillOutForms,
      Privilege.approveForm,
      Privilege.viewOnlyFoundItems,
    },
  ),
];
