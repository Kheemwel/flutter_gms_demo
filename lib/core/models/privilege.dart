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
  manageStudentInventory,
  studentPrivileges,
  parentPrivileges,

  /// The catch-all the original gave to admins.
  admin;

  String get id => name;

  PrivilegeGroup get group => switch (this) {
    manageExpiredItems ||
    manageClaimedItems ||
    viewOnlyFoundItems ||
    addLostAndFound ||
    deleteLostAndFound ||
    editLostAndFound => PrivilegeGroup.lostAndFound,
    fillOutForms || requestForm || approveForm => PrivilegeGroup.forms,
    viewAccounts ||
    viewGuidanceAccounts ||
    viewParentAccounts ||
    viewPrincipalAccounts ||
    viewStudentAccounts ||
    viewTeacherAccounts => PrivilegeGroup.accounts,
    manageWebsiteContent => PrivilegeGroup.content,
    manageRoles => PrivilegeGroup.roles,
    viewStudentSummary ||
    viewStudentsAnecdotal ||
    writeStudentsAnecdotal ||
    manageStudentInventory => PrivilegeGroup.studentRecords,
    studentPrivileges || parentPrivileges => PrivilegeGroup.portal,
    admin => PrivilegeGroup.system,
  };

  String get label => switch (this) {
    manageExpiredItems => 'Manage expired items',
    manageClaimedItems => 'Manage claimed items',
    viewOnlyFoundItems => 'View found items only',
    addLostAndFound => 'Add lost & found item',
    deleteLostAndFound => 'Delete lost & found item',
    editLostAndFound => 'Edit lost & found item',
    fillOutForms => 'Fill out forms',
    requestForm => 'Request forms',
    approveForm => 'Approve forms',
    viewAccounts => 'View all accounts',
    viewGuidanceAccounts => 'View guidance accounts',
    viewParentAccounts => 'View parent accounts',
    viewPrincipalAccounts => 'View principal accounts',
    viewStudentAccounts => 'View student accounts',
    viewTeacherAccounts => 'View teacher accounts',
    manageWebsiteContent => 'Manage website content',
    manageRoles => 'Manage roles & privileges',
    viewStudentSummary => 'View student summary',
    viewStudentsAnecdotal => 'View student anecdotal',
    writeStudentsAnecdotal => 'Write student anecdotal',
    manageStudentInventory => 'Manage student inventory',
    studentPrivileges => 'Student portal access',
    parentPrivileges => 'Parent portal access',
    admin => 'System administrator',
  };
}

enum PrivilegeGroup {
  lostAndFound('Lost & Found'),
  forms('Forms'),
  accounts('User Accounts'),
  content('Website Content'),
  roles('Roles & Privileges'),
  studentRecords('Student Records'),
  portal('Portal Access'),
  system('System');

  const PrivilegeGroup(this.label);
  final String label;
}
