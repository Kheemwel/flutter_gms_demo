import 'models/privilege.dart';

/// Routes in the authenticated shell that require a privilege.
/// The sidebar *and* the GoRouter redirect both read from here.
class PrivilegeMap {
  /// Route path → required privileges (user needs **any** of them).
  static const Map<String, Set<Privilege>> routePrivileges = {
    '/app/lost-and-found': {
      Privilege.manageExpiredItems,
      Privilege.manageClaimedItems,
      Privilege.viewOnlyFoundItems,
      Privilege.addLostAndFound,
      Privilege.deleteLostAndFound,
      Privilege.editLostAndFound,
    },
    '/app/forms': {Privilege.fillOutForms},
    '/app/request-forms': {Privilege.requestForm},
    '/app/approval': {Privilege.approveForm},
    '/app/user-accounts': {
      Privilege.viewAccounts,
      Privilege.viewGuidanceAccounts,
      Privilege.viewParentAccounts,
      Privilege.viewPrincipalAccounts,
      Privilege.viewStudentAccounts,
      Privilege.viewTeacherAccounts,
    },
    '/app/content': {Privilege.manageWebsiteContent},
    '/app/roles': {Privilege.manageRoles},
    '/app/students': {
      Privilege.viewStudentSummary,
      Privilege.viewStudentsAnecdotal,
      Privilege.writeStudentsAnecdotal,
    },
    '/app/student-records': {Privilege.studentPrivileges},
    '/app/child-records': {Privilege.parentPrivileges},
    '/app/audit-trail': {},
  };

  static bool canAccess(String path, Set<Privilege> userPrivileges) {
    final Set<Privilege>? required = routePrivileges[path];
    if (required == null || required.isEmpty) return true;
    return required.any(userPrivileges.contains);
  }
}
