/// Every privilege the original `Privileges` table encoded.
enum Privilege {
  // Lost & found
  manageExpiredItems,
  manageClaimedItems,
  viewOnlyFoundItems,
  addLostAndFound,
  deleteLostAndFound,
  editLostAndFound,

  // Forms
  fillOutForms,
  requestForm,
  approveForm,

  // Accounts
  viewAccounts,
  viewGuidanceAccounts,
  viewParentAccounts,
  viewPrincipalAccounts,
  viewStudentAccounts,
  viewTeacherAccounts,

  // Misc
  manageWebsiteContent,
  manageRoles,
  viewStudentSummary,
  viewStudentsAnecdotal,
  writeStudentsAnecdotal,
  studentPrivileges,
  parentPrivileges,

  /// The catch-all the original gave to admins.
  admin;

  String get id => name;
}
