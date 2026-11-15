import 'package:flutter_gms_demo/core/models/grade_level.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';

/// Seven demo users, one per role. Password is always `password`.
/// Demo student is Grade 9; demo parent has two children (one extra student).
final List<UserAccount> seedUsers = [
  const UserAccount(
    id: 'user-1',
    firstName: 'Ada',
    lastName: 'Admin',
    email: 'admin@gms.demo',
    roleId: 'role-admin',
    profile: UserProfile.admin(),
    isArchived: false,
    totalLogin: 0,
  ),
  const UserAccount(
    id: 'user-2',
    firstName: 'Grace',
    lastName: 'Guidance',
    email: 'guidance@gms.demo',
    roleId: 'role-guidance',
    profile: UserProfile.guidance(),
    isArchived: false,
    totalLogin: 0,
  ),
  const UserAccount(
    id: 'user-3',
    firstName: 'Sam',
    lastName: 'Student',
    email: 'student@gms.demo',
    roleId: 'role-student',
    profile: UserProfile.student(
      lrn: '123456789012',
      gradeLevel: GradeLevel.grade9,
    ),
    isArchived: false,
    totalLogin: 0,
  ),
  const UserAccount(
    id: 'user-4',
    firstName: 'Pat',
    lastName: 'Parent',
    email: 'parent@gms.demo',
    roleId: 'role-parent',
    profile: UserProfile.parent(childIds: ['user-3', 'user-3b']),
    isArchived: false,
    totalLogin: 0,
  ),
  const UserAccount(
    id: 'user-5',
    firstName: 'Tina',
    lastName: 'Teacher',
    email: 'teacher@gms.demo',
    roleId: 'role-teacher',
    profile: UserProfile.teacher(),
    isArchived: false,
    totalLogin: 0,
  ),
  const UserAccount(
    id: 'user-6',
    firstName: 'Junior',
    lastName: 'Principal',
    email: 'principal.jr@gms.demo',
    roleId: 'role-principal-jr',
    profile: UserProfile.principal(position: PrincipalPosition.juniorHigh),
    isArchived: false,
    totalLogin: 0,
  ),
  const UserAccount(
    id: 'user-7',
    firstName: 'Senior',
    lastName: 'Principal',
    email: 'principal.sr@gms.demo',
    roleId: 'role-principal-sr',
    profile: UserProfile.principal(position: PrincipalPosition.seniorHigh),
    isArchived: false,
    totalLogin: 0,
  ),
  // The "second child" of the demo parent — not a login user we surface,
  // but needs to exist for the parent's child list to make sense.
  const UserAccount(
    id: 'user-3b',
    firstName: 'Alex',
    lastName: 'Student',
    email: 'student2@gms.demo',
    roleId: 'role-student',
    profile: UserProfile.student(
      lrn: '223456789012',
      gradeLevel: GradeLevel.grade10,
    ),
    isArchived: false,
    totalLogin: 0,
  ),
];

const demoPassword = 'password';
