import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/help_section.dart';

/// The full contents of the in-app user manual.
/// Grouped into top-level sections, each with one or more subsections.
const List<HelpSection> helpSections = [
  // ─────────────────────────────────────────────────────────────────
  // Getting started
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'getting-started',
    title: 'Getting Started',
    icon: Icons.rocket_launch_rounded,
    subsections: [
      HelpSubsection(
        id: 'overview',
        title: 'What is this app?',
        description:
            'A guidance management system for schools. It helps the '
            'guidance office manage student records, handle requests, '
            'schedule events, and coordinate with teachers, students, '
            'parents, and principals.',
        steps: [
          HelpStep(
            text:
                'Sign in with your school account. If you were issued a '
                'temporary password, you will be prompted to change it '
                'after your first login.',
            icon: Icons.login_rounded,
          ),
          HelpStep(
            text:
                'Use the left sidebar to navigate. Each role sees a '
                'different set of menu items based on its permissions.',
            icon: Icons.menu_rounded,
          ),
          HelpStep(
            text:
                'Your name, avatar, and notifications live in the top '
                'bar. Click your name for profile and password options.',
            icon: Icons.account_circle_rounded,
          ),
        ],
        note:
            'The Dashboard shows everything that needs your attention '
            'right now — pending forms, upcoming events, unread notifications.',
      ),
      HelpSubsection(
        id: 'sidebar',
        title: 'Using the sidebar',
        description:
            'The left sidebar lists every page you can open. Items you '
            'see are filtered by your role’s permissions.',
        steps: [
          HelpStep(
            text: 'Click any item to navigate to that page.',
            icon: Icons.touch_app_rounded,
          ),
          HelpStep(
            text:
                'The current page is highlighted so you always know '
                'where you are.',
            icon: Icons.radio_button_checked_rounded,
          ),
          HelpStep(
            text:
                'Click Logout at the bottom of the sidebar to sign out '
                'of your account.',
            icon: Icons.logout_rounded,
          ),
        ],
        note:
            'If you don’t see a feature you expected, your role may not '
            'have permission for it. Contact an administrator.',
      ),
      HelpSubsection(
        id: 'top-bar',
        title: 'Top bar: notifications and profile',
        description:
            'The top bar gives you quick access to notifications and '
            'your account.',
        steps: [
          HelpStep(
            text:
                'Click the bell icon to see unread notifications. You can '
                'mark them read individually or all at once.',
            icon: Icons.notifications_none_rounded,
          ),
          HelpStep(
            text:
                'Click your name or avatar to open a menu: view profile, '
                'change password, or log out.',
            icon: Icons.person_outline_rounded,
          ),
          HelpStep(
            text:
                'A red badge on the bell shows how many unread '
                'notifications you have (9+ if more than nine).',
            icon: Icons.badge_rounded,
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Your profile
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'profile',
    title: 'Your Profile',
    icon: Icons.person_rounded,
    subsections: [
      HelpSubsection(
        id: 'edit-profile',
        title: 'Edit your name and email',
        description:
            'You can update your own first name, last name, and email '
            'from the profile page.',
        steps: [
          HelpStep(
            text:
                'Click your name in the top-right corner and choose '
                '“My profile.”',
            icon: Icons.person_outline_rounded,
          ),
          HelpStep(
            text:
                'Edit the fields you want to change. The Save button '
                'becomes enabled as soon as you make an edit.',
            icon: Icons.edit_rounded,
          ),
          HelpStep(
            text: 'Click Save to apply the changes.',
            icon: Icons.save_rounded,
          ),
        ],
        note:
            'Your email must be unique across all accounts. If another '
            'user already has it, you will see a validation error.',
      ),
      HelpSubsection(
        id: 'change-password',
        title: 'Change your password',
        description:
            'You can change your own password at any time. You will '
            'need to confirm the current one first.',
        steps: [
          HelpStep(
            text:
                'Open your profile from the top-right menu and click '
                '“Change password.”',
            icon: Icons.password_rounded,
          ),
          HelpStep(
            text: 'Enter your current password.',
            icon: Icons.lock_outline_rounded,
          ),
          HelpStep(
            text:
                'Enter your new password twice (at least 8 characters, '
                'different from the current one).',
            icon: Icons.lock_reset_rounded,
          ),
          HelpStep(
            text: 'Click Change password to apply.',
            icon: Icons.check_rounded,
          ),
        ],
        note:
            'If you were issued a temporary password, the dashboard '
            'will show a banner asking you to change it on first login.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Dashboard
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'dashboard',
    title: 'Dashboard',
    icon: Icons.dashboard_rounded,
    subsections: [
      HelpSubsection(
        id: 'dashboard-overview',
        title: 'Reading your dashboard',
        description:
            'The dashboard is your landing page. It summarises what '
            'needs your attention today.',
        steps: [
          HelpStep(
            text:
                'The KPI cards at the top show live counts relevant to '
                'your role.',
            icon: Icons.insights_rounded,
          ),
          HelpStep(
            text:
                '“Needs your attention” lists pending requests, '
                'incomplete forms, and unread notifications.',
            icon: Icons.priority_high_rounded,
          ),
          HelpStep(
            text:
                '“Upcoming schedule” shows the next five events you can '
                'see.',
            icon: Icons.event_rounded,
          ),
          HelpStep(
            text:
                '“Quick actions” gets you to the screens you use most '
                'often in one click.',
            icon: Icons.flash_on_rounded,
          ),
        ],
        note:
            'Every card is clickable. If a form completes while you are '
            'on another page, its count updates as soon as you return '
            'to the dashboard.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // User accounts
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'accounts',
    title: 'User Accounts',
    icon: Icons.people_rounded,
    subsections: [
      HelpSubsection(
        id: 'add-user',
        title: 'Adding a user',
        description:
            'Admins create user accounts from the User Accounts page. '
            'Each account is assigned a role that determines what the '
            'user can see and do.',
        steps: [
          HelpStep(
            text: 'Open User Accounts from the sidebar and click “Add user.”',
            icon: Icons.person_add_alt_1_rounded,
          ),
          HelpStep(
            text:
                'Choose the kind of account you are creating: '
                'Administrator, Guidance, Student, Parent, Teacher, or '
                'Principal.',
            icon: Icons.category_rounded,
          ),
          HelpStep(
            text:
                'Fill in the account details. Student accounts need an '
                'LRN and grade level. Parent accounts can be linked to '
                'one or more students. Principal accounts need a '
                'position (junior or senior high).',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Click Create user. The account uses the demo default '
                'password and will be prompted to change it on first '
                'login.',
            icon: Icons.check_rounded,
          ),
        ],
        note:
            'A student account can be created without a parent linked. '
            'Link parents from the student edit dialog at any time.',
      ),
      HelpSubsection(
        id: 'edit-user',
        title: 'Editing, archiving, and deleting users',
        description:
            'You can update a user’s details, archive them (soft-disable), '
            'or delete them permanently.',
        steps: [
          HelpStep(
            text:
                'Find the account in the Active or Archived tab and open '
                'the row menu.',
            icon: Icons.more_vert_rounded,
          ),
          HelpStep(
            text:
                'Choose Edit to change fields. Archived accounts must be '
                'restored before editing.',
            icon: Icons.edit_rounded,
          ),
          HelpStep(
            text:
                'Choose Archive to disable login without deleting. The '
                'account still exists in the system but cannot sign in.',
            icon: Icons.archive_rounded,
          ),
          HelpStep(
            text:
                'Choose Delete to permanently remove an account. This '
                'cannot be undone.',
            icon: Icons.delete_outline_rounded,
          ),
        ],
        note:
            'Archived users are hidden from most pickers and dropdowns '
            'throughout the app. Restore the account to make it visible '
            'again.',
      ),
      HelpSubsection(
        id: 'link-parent',
        title: 'Linking a student to a parent',
        description:
            'Home visitation forms require a parent. A student with no '
            'linked parent cannot participate in that workflow.',
        steps: [
          HelpStep(
            text:
                'Open User Accounts and edit the student account (or '
                'the parent account — links can be managed from either '
                'side).',
            icon: Icons.edit_rounded,
          ),
          HelpStep(
            text:
                'On the student form, use the “Parents (optional)” '
                'picker to check one or more parents.',
            icon: Icons.link_rounded,
          ),
          HelpStep(
            text:
                'Save the form. The parent’s “Children” list updates '
                'immediately.',
            icon: Icons.save_rounded,
          ),
        ],
        note:
            'You can also do it the other way around: edit the parent '
            'account and tick their children in the multi-select picker.',
      ),
      HelpSubsection(
        id: 'import-users',
        title: 'Importing users',
        description:
            'Bulk-create accounts by uploading a spreadsheet of users.',
        comingSoon: true,
      ),
      HelpSubsection(
        id: 'export-users',
        title: 'Exporting users',
        description:
            'Download a spreadsheet of every user account in the system.',
        comingSoon: true,
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Roles & privileges
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'roles',
    title: 'Roles & Privileges',
    icon: Icons.shield_rounded,
    subsections: [
      HelpSubsection(
        id: 'add-role',
        title: 'Adding a role',
        description:
            'Create custom roles that behave like a base kind but with '
            'different permissions.',
        steps: [
          HelpStep(
            text: 'Open Roles & Privileges from the sidebar.',
            icon: Icons.shield_rounded,
          ),
          HelpStep(text: 'Click “Add role.”', icon: Icons.add_rounded),
          HelpStep(
            text:
                'Enter a name and pick the kind. The kind determines '
                'what the role can fundamentally do; the privileges '
                'decide which screens are visible.',
            icon: Icons.category_rounded,
          ),
          HelpStep(
            text:
                'Tick the privileges you want. They are grouped by '
                'feature area.',
            icon: Icons.checklist_rounded,
          ),
          HelpStep(text: 'Click Create to save.', icon: Icons.check_rounded),
        ],
        note:
            'A role that is currently assigned to users cannot be '
            'deleted until those users are reassigned.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Offenses
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'offenses',
    title: 'Offenses',
    icon: Icons.gavel_rounded,
    subsections: [
      HelpSubsection(
        id: 'offense',
        title: 'Adding an offense',
        description: 'Define an offense that can appear on violation forms.',
        steps: [
          HelpStep(
            text: 'Open Offenses from the sidebar.',
            icon: Icons.gavel_rounded,
          ),
          HelpStep(
            text: 'On the Offenses tab, click “Add offense.”',
            icon: Icons.add_rounded,
          ),
          HelpStep(
            text:
                'Enter the offense name and description, and pick its '
                'category and severity level.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Tick the disciplinary actions that can be applied to '
                'this offense.',
            icon: Icons.checklist_rounded,
          ),
          HelpStep(text: 'Click Add to save.', icon: Icons.check_rounded),
        ],
      ),
      HelpSubsection(
        id: 'offense-category',
        title: 'Adding an offense category',
        description:
            'Categories group related offenses (e.g., Attendance, '
            'Conduct, Violence).',
        steps: [
          HelpStep(
            text: 'Open Offenses → Categories tab.',
            icon: Icons.category_rounded,
          ),
          HelpStep(text: 'Click “Add category.”', icon: Icons.add_rounded),
          HelpStep(
            text: 'Enter the category name and save.',
            icon: Icons.check_rounded,
          ),
        ],
        note:
            'A category that has offenses assigned to it cannot be '
            'deleted until those offenses are moved or deleted.',
      ),
      HelpSubsection(
        id: 'offense-level',
        title: 'Adding an offense level',
        description:
            'Levels describe severity. Higher severity numbers appear '
            'first in the offense list and use a redder chip.',
        steps: [
          HelpStep(
            text: 'Open Offenses → Levels tab.',
            icon: Icons.trending_up_rounded,
          ),
          HelpStep(text: 'Click “Add level.”', icon: Icons.add_rounded),
          HelpStep(
            text:
                'Enter a name and a severity number between 1 (minor) '
                'and 10 (critical).',
            icon: Icons.edit_document,
          ),
          HelpStep(text: 'Save.', icon: Icons.check_rounded),
        ],
      ),
      HelpSubsection(
        id: 'disciplinary-action',
        title: 'Adding a disciplinary action',
        description:
            'Disciplinary actions are the possible consequences for an '
            'offense (e.g., Verbal warning, Suspension).',
        steps: [
          HelpStep(
            text: 'Open Offenses → Disciplinary Actions tab.',
            icon: Icons.rule_rounded,
          ),
          HelpStep(text: 'Click “Add action.”', icon: Icons.add_rounded),
          HelpStep(
            text: 'Enter a name and description and save.',
            icon: Icons.check_rounded,
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Lost & Found
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'lost-found',
    title: 'Lost & Found',
    icon: Icons.search_rounded,
    subsections: [
      HelpSubsection(
        id: 'add-item',
        title: 'Logging a found item',
        description:
            'Record an item that was found on campus so its owner can '
            'claim it.',
        steps: [
          HelpStep(
            text: 'Open Lost & Found from the sidebar.',
            icon: Icons.search_rounded,
          ),
          HelpStep(
            text: 'On the Found tab, click “Add item.”',
            icon: Icons.add_rounded,
          ),
          HelpStep(
            text:
                'Fill in the item name, type, priority tag, and where '
                'and when it was found.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Save. The item appears in the Found tab and its '
                'expiry date is calculated from the priority tag.',
            icon: Icons.check_rounded,
          ),
        ],
        note:
            'Items expire automatically. Expired items move to the '
            'Expired tab and are no longer visible in Found.',
      ),
      HelpSubsection(
        id: 'claim-item',
        title: 'Claiming a found item',
        description: 'Record the person who picked up a found item.',
        steps: [
          HelpStep(
            text: 'Find the item on the Found tab and open its row menu.',
            icon: Icons.more_vert_rounded,
          ),
          HelpStep(
            text: 'Choose “Mark claimed.”',
            icon: Icons.check_circle_outline,
          ),
          HelpStep(
            text:
                'Enter the claimer’s name, contact number, email, '
                'address, and claim date.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Click “Mark claimed.” The item moves to the Claimed '
                'tab with the claimer details stored.',
            icon: Icons.check_rounded,
          ),
        ],
      ),
      HelpSubsection(
        id: 'item-types',
        title: 'Managing item types',
        description: 'Types categorise items (e.g., Phone, Wallet, Bag).',
        steps: [
          HelpStep(
            text: 'Open Lost & Found → Types & Tags → Types.',
            icon: Icons.category_rounded,
          ),
          HelpStep(text: 'Click “Add type.”', icon: Icons.add_rounded),
          HelpStep(
            text: 'Enter the type name and save.',
            icon: Icons.check_rounded,
          ),
        ],
        note:
            'A type that has items assigned to it cannot be deleted '
            'until those items are moved or deleted.',
      ),
      HelpSubsection(
        id: 'item-tags',
        title: 'Managing priority tags',
        description:
            'Priority tags decide how long an item stays available '
            'before it expires.',
        steps: [
          HelpStep(
            text: 'Open Lost & Found → Types & Tags → Priority tags.',
            icon: Icons.priority_high_rounded,
          ),
          HelpStep(text: 'Click “Add tag.”', icon: Icons.add_rounded),
          HelpStep(
            text:
                'Enter a name and the number of days until items with '
                'this tag expire.',
            icon: Icons.edit_document,
          ),
          HelpStep(text: 'Save.', icon: Icons.check_rounded),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Forms
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'forms',
    title: 'Forms',
    icon: Icons.edit_document,
    subsections: [
      HelpSubsection(
        id: 'fill-forms',
        title: 'Filling out a form',
        description:
            'Fill out forms assigned to you. Complete every required '
            'field and sign to move them forward.',
        steps: [
          HelpStep(
            text: 'Open Fill Out Forms from the sidebar.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text: 'Forms you need to act on appear in the To Fill tab.',
            icon: Icons.list_alt_rounded,
          ),
          HelpStep(
            text:
                'Click the open icon on a form to fill it out. Only the '
                'fields you are responsible for are editable; others '
                'show read-only.',
            icon: Icons.open_in_new_rounded,
          ),
          HelpStep(
            text:
                'Fill your required fields and click Sign to draw your '
                'signature.',
            icon: Icons.draw_rounded,
          ),
          HelpStep(
            text:
                'Save. When every required field and signature is in, '
                'the form moves to the Completed tab automatically.',
            icon: Icons.check_rounded,
          ),
        ],
        note:
            'You cannot edit a form after it is completed. Contact an '
            'administrator if a completed form needs correction.',
      ),
      HelpSubsection(
        id: 'request-forms',
        title: 'Requesting a form',
        description:
            'Teachers request home visitation or violation forms from '
            'guidance.',
        steps: [
          HelpStep(
            text: 'Open Request Forms from the sidebar.',
            icon: Icons.outbox_rounded,
          ),
          HelpStep(
            text:
                'Click “Request home visitation” or “Request violation '
                'form.”',
            icon: Icons.add_rounded,
          ),
          HelpStep(
            text:
                'Pick the student(s) and explain why you are '
                'requesting the form.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Submit. Guidance gets a notification and can approve '
                'or disapprove the request.',
            icon: Icons.send_rounded,
          ),
        ],
        note:
            'Home visitation requests require the student to have a '
            'linked parent. If no parent is linked, you will not see '
            'the student in the picker.',
      ),
      HelpSubsection(
        id: 'approve-forms',
        title: 'Approving or disapproving requests',
        description:
            'Guidance reviews teacher requests. Approving immediately '
            'creates the actual form.',
        steps: [
          HelpStep(
            text: 'Open Approval Forms from the sidebar.',
            icon: Icons.rule_rounded,
          ),
          HelpStep(
            text:
                'Open a pending request to read the teacher’s reason '
                'and pick a decision.',
            icon: Icons.visibility_outlined,
          ),
          HelpStep(
            text:
                'Click Approve to create the form and notify all '
                'participants.',
            icon: Icons.check_rounded,
          ),
          HelpStep(
            text:
                'Or click Disapprove, enter a reason, and confirm. The '
                'teacher gets the reason by notification.',
            icon: Icons.cancel_rounded,
          ),
        ],
        note:
            'You cannot approve your own request. If you submitted it, '
            'another guidance user must review it.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Students & records
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'students',
    title: 'Students & Records',
    icon: Icons.groups_rounded,
    subsections: [
      HelpSubsection(
        id: 'student-records',
        title: 'Viewing student records',
        description:
            'Open any student to see their individual inventory and '
            'anecdotal record.',
        steps: [
          HelpStep(
            text: 'Open Students from the sidebar.',
            icon: Icons.groups_rounded,
          ),
          HelpStep(
            text:
                'Search or filter by grade to find a student, then '
                'click the row.',
            icon: Icons.search_rounded,
          ),
          HelpStep(
            text:
                'The detail dialog opens with tabs for Individual '
                'inventory and Anecdotal record.',
            icon: Icons.person_outline_rounded,
          ),
        ],
      ),
      HelpSubsection(
        id: 'inventory',
        title: 'Adding or editing a student inventory',
        description:
            'The individual inventory captures the student’s personal, '
            'family, health, and academic background.',
        steps: [
          HelpStep(
            text:
                'Open the student’s detail dialog and go to the '
                'Individual inventory tab.',
            icon: Icons.folder_shared_rounded,
          ),
          HelpStep(
            text:
                'Click “Add inventory” (if none exists) or “Edit '
                'inventory.”',
            icon: Icons.edit_rounded,
          ),
          HelpStep(
            text:
                'Fill in the sections — basic information, family, '
                'health, and academic background.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Save. The inventory is now available to home '
                'visitation forms when created.',
            icon: Icons.check_rounded,
          ),
        ],
        note:
            'Inventory data prefills many fields on home visitation '
            'forms. Keeping it up to date saves the guidance officer '
            'time later.',
      ),
      HelpSubsection(
        id: 'anecdotal',
        title: 'Writing an anecdotal entry',
        description:
            'Anecdotal entries are notes about observations — '
            'behavioral, academic, or achievements.',
        steps: [
          HelpStep(
            text:
                'Open the student’s detail dialog and go to the '
                'Anecdotal record tab.',
            icon: Icons.notes_rounded,
          ),
          HelpStep(text: 'Click “Write entry.”', icon: Icons.note_add_rounded),
          HelpStep(
            text:
                'Pick a category and the date observed, then type your '
                'narrative.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Sign the entry as the author, then save. The student '
                'and their parents get a notification.',
            icon: Icons.draw_rounded,
          ),
        ],
        note:
            'Students and parents can sign an entry from their own '
            'records page to acknowledge it.',
      ),
      HelpSubsection(
        id: 'my-records',
        title: 'Viewing your own records (students)',
        description:
            'As a student, you can view your inventory and anecdotal '
            'record, and sign entries routed to you.',
        steps: [
          HelpStep(
            text: 'Open My Records from the sidebar.',
            icon: Icons.folder_shared_rounded,
          ),
          HelpStep(
            text:
                'The Individual inventory tab shows your personal '
                'information.',
            icon: Icons.person_outline_rounded,
          ),
          HelpStep(
            text:
                'The Anecdotal record tab lists entries about you. '
                'Click “Sign as student” on any entry to acknowledge it.',
            icon: Icons.draw_rounded,
          ),
        ],
      ),
      HelpSubsection(
        id: 'my-child-records',
        title: 'Viewing your child’s records (parents)',
        description:
            'As a parent, you can view each of your linked children’s '
            'inventory and anecdotal record.',
        steps: [
          HelpStep(
            text: 'Open My Child Records from the sidebar.',
            icon: Icons.family_restroom_rounded,
          ),
          HelpStep(
            text:
                'If you have more than one child linked, switch '
                'between them using the dropdown at the top.',
            icon: Icons.swap_horiz_rounded,
          ),
          HelpStep(
            text:
                'Sign any anecdotal entries routed to you with “Sign as '
                'parent.”',
            icon: Icons.draw_rounded,
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Guidance Program
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'program',
    title: 'Guidance Program',
    icon: Icons.calendar_month_rounded,
    subsections: [
      HelpSubsection(
        id: 'create-event',
        title: 'Creating an event',
        description:
            'Add a scheduled activity, meeting, or deadline to the '
            'school calendar.',
        steps: [
          HelpStep(
            text: 'Open Guidance Program from the sidebar.',
            icon: Icons.calendar_month_rounded,
          ),
          HelpStep(
            text:
                'Pick a day on the calendar to prefill the date, then '
                'click “Add event.”',
            icon: Icons.add_rounded,
          ),
          HelpStep(
            text:
                'Fill in the title, description, start and end time, '
                'and a schedule tag.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Choose whether the event is public (visible to all) '
                'or private (visible only to selected users).',
            icon: Icons.visibility_rounded,
          ),
          HelpStep(
            text:
                'Save. The event appears on the calendar, and private '
                'recipients get a notification.',
            icon: Icons.check_rounded,
          ),
        ],
      ),
      HelpSubsection(
        id: 'schedule-tag',
        title: 'Adding a schedule tag',
        description:
            'Schedule tags colour-code events so different categories '
            'stand out.',
        steps: [
          HelpStep(
            text: 'Open Guidance Program → Schedule Tags tab.',
            icon: Icons.label_outline_rounded,
          ),
          HelpStep(text: 'Click “Add tag.”', icon: Icons.add_rounded),
          HelpStep(
            text: 'Enter a name and pick a colour from the palette.',
            icon: Icons.palette_rounded,
          ),
          HelpStep(text: 'Save.', icon: Icons.check_rounded),
        ],
        note:
            'A tag that is used by any event cannot be deleted until '
            'those events are changed or deleted.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Notifications
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'notifications',
    title: 'Notifications',
    icon: Icons.notifications_rounded,
    subsections: [
      HelpSubsection(
        id: 'viewing-notifications',
        title: 'Viewing your notifications',
        description:
            'Every action that concerns you — a new form, an approved '
            'request, a new anecdotal entry — produces a notification.',
        steps: [
          HelpStep(
            text:
                'Click the bell in the top bar to open a quick menu: '
                'View all or Mark all read.',
            icon: Icons.notifications_none_rounded,
          ),
          HelpStep(
            text:
                'The Notifications page lists every notification you '
                'have received, newest first.',
            icon: Icons.list_alt_rounded,
          ),
          HelpStep(
            text:
                'Click an unread notification to mark it read. Or use '
                '“Mark all read” to clear the badge at once.',
            icon: Icons.done_all_rounded,
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Content Management
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'content',
    title: 'Content Management',
    icon: Icons.web_rounded,
    subsections: [
      HelpSubsection(
        id: 'edit-home-page',
        title: 'Editing the landing page',
        description:
            'Customise the title, subtitle, school name, and logo '
            'preset that appears on the public landing page.',
        steps: [
          HelpStep(
            text: 'Open Content Management from the sidebar.',
            icon: Icons.web_rounded,
          ),
          HelpStep(
            text:
                'Pick a logo preset from the swatches. The preview '
                'updates live.',
            icon: Icons.palette_rounded,
          ),
          HelpStep(
            text:
                'Edit the title, subtitle, and school name. The '
                'preview updates as you type.',
            icon: Icons.edit_document,
          ),
          HelpStep(
            text:
                'Click Save. Changes take effect immediately on the '
                'landing page.',
            icon: Icons.save_rounded,
          ),
        ],
        note:
            'Uploading a custom logo image will be supported in a '
            'future release. For now, choose from the preset palettes.',
      ),
    ],
  ),

  // ─────────────────────────────────────────────────────────────────
  // Audit Trail
  // ─────────────────────────────────────────────────────────────────
  HelpSection(
    id: 'audit',
    title: 'Audit Trail',
    icon: Icons.history_rounded,
    subsections: [
      HelpSubsection(
        id: 'viewing-audit',
        title: 'Reading the audit trail',
        description:
            'A chronological record of significant actions. Entries '
            'are append-only except for explicit deletion.',
        steps: [
          HelpStep(
            text: 'Open Audit Trail from the sidebar.',
            icon: Icons.history_rounded,
          ),
          HelpStep(
            text:
                'Search by action, description, or user to narrow the '
                'list.',
            icon: Icons.search_rounded,
          ),
          HelpStep(
            text:
                'Click the delete icon on an entry to remove it. This '
                'should only be used to remove accidental or test '
                'entries.',
            icon: Icons.delete_outline_rounded,
          ),
        ],
        note:
            'Exporting the audit log will be supported in a future '
            'release.',
      ),
    ],
  ),
];
