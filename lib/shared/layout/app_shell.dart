import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/site_content.dart';
import 'package:flutter_gms_demo/core/utilities/logo_palette.dart';
import 'package:flutter_gms_demo/features/content_management/providers/site_content_notifier.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_providers.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? user = ref.watch(authProvider);
    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Sidebar(user: user),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                _TopBar(user: user),
                const Divider(height: 1),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.user});
  final UserAccount user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String location = GoRouterState.of(context).uri.toString();
    final Set<Privilege> privileges = ref.watch(currentPrivilegesProvider);
    final List<_NavItem> visible = _navItems
        .where((_NavItem i) => _canSee(privileges, i))
        .toList();

    return Material(
      color: context.colorScheme.surface,
      child: SizedBox(
        width: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BrandBlock(),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (final _NavItem item in visible)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: ListTile(
                        leading: Icon(
                          item.icon,
                          size: 20,
                          color: location == item.path
                              ? context.colorScheme.onSecondaryContainer
                              : context.colorScheme.onSurfaceVariant,
                        ),
                        title: Text(
                          item.label,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: location == item.path
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: location == item.path
                                ? context.colorScheme.onSecondaryContainer
                                : context.colorScheme.onSurface,
                          ),
                        ),
                        selected: location == item.path,
                        selectedTileColor: context
                            .colorScheme
                            .secondaryContainer
                            .withValues(alpha: 0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        onTap: () => context.go(item.path),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                title: Text(
                  'Logout',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                onTap: () {
                  ref.read(authProvider.notifier).logout();
                  context.go('/');
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  bool _canSee(Set<Privilege> privileges, _NavItem item) {
    if (privileges.contains(Privilege.admin)) return true;
    if (item.requiredPrivileges.isEmpty) return true;
    return item.requiredPrivileges.any(privileges.contains);
  }
}

class _BrandBlock extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SiteContent content = ref.watch(siteContentProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: logoPalette(context, content.logoPreset),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.school_rounded,
              color: context.colorScheme.onPrimary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content.schoolName.isEmpty ? 'GMS Demo' : content.schoolName,
                  style: context.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('v0.1.0', style: context.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar({required this.user});
  final UserAccount user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme scheme = context.colorScheme;
    final List<AppNotification> notifications = ref.watch(
      appNotificationsProvider,
    );
    final int unread = notifications
        .where((n) => n.toUserId == user.id && !n.isRead)
        .length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Text(
            ref.watch(siteContentProvider.select((selector) => selector.title)),
            style: context.textTheme.titleMedium,
          ),
          const Spacer(),
          PopupMenuButton<String>(
            tooltip: 'Notifications',
            offset: const Offset(0, 44),
            onSelected: (value) {
              if (value == 'view') {
                context.go('/app/notifications');
              } else if (value == 'read') {
                ref
                    .read(appNotificationsProvider.notifier)
                    .markAllReadFor(user.id);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'view',
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.list_alt_rounded),
                  title: Text('View all notifications'),
                ),
              ),
              if (unread > 0)
                const PopupMenuItem(
                  value: 'read',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.done_all_rounded),
                    title: Text('Mark all read'),
                  ),
                ),
            ],
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const IconButton(
                  onPressed: null, // handled by popup
                  icon: Icon(Icons.notifications_none_rounded),
                ),
                if (unread > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        unread > 9 ? '9+' : '$unread',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: scheme.onError,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 18,
            backgroundColor: scheme.primaryContainer,
            child: Text(
              user.firstName.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user.fullName, style: context.textTheme.labelLarge),
              Text(user.email, style: context.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.path, this.label, this.icon, this.requiredPrivileges);
  final String path;
  final String label;
  final IconData icon;
  final Set<Privilege> requiredPrivileges;
}

const List<_NavItem> _navItems = <_NavItem>[
  _NavItem(
    '/app/dashboard',
    'Dashboard',
    Icons.dashboard_rounded,
    <Privilege>{},
  ),
  _NavItem(
    '/app/user-accounts',
    'User Accounts',
    Icons.people_rounded,
    <Privilege>{
      Privilege.viewAccounts,
      Privilege.viewGuidanceAccounts,
      Privilege.viewParentAccounts,
      Privilege.viewPrincipalAccounts,
      Privilege.viewStudentAccounts,
      Privilege.viewTeacherAccounts,
    },
  ),
  _NavItem(
    '/app/roles',
    'Roles & Privileges',
    Icons.shield_rounded,
    <Privilege>{Privilege.manageRoles},
  ),
  _NavItem(
    '/app/lost-and-found',
    'Lost & Found',
    Icons.search_rounded,
    <Privilege>{
      Privilege.manageExpiredItems,
      Privilege.manageClaimedItems,
      Privilege.viewOnlyFoundItems,
      Privilege.addLostAndFound,
      Privilege.deleteLostAndFound,
      Privilege.editLostAndFound,
    },
  ),
  _NavItem('/app/offenses', 'Offenses', Icons.gavel_rounded, <Privilege>{
    Privilege.admin,
  }),
  _NavItem('/app/forms', 'Fill Out Forms', Icons.edit_document, <Privilege>{
    Privilege.fillOutForms,
  }),
  _NavItem(
    '/app/request-forms',
    'Request Forms',
    Icons.outbox_rounded,
    <Privilege>{Privilege.requestForm},
  ),
  _NavItem('/app/approval', 'Approval Forms', Icons.rule_rounded, <Privilege>{
    Privilege.approveForm,
  }),
  _NavItem(
    '/app/program',
    'Guidance Program',
    Icons.calendar_month_rounded,
    <Privilege>{},
  ),
  _NavItem('/app/students', 'Students', Icons.groups_rounded, <Privilege>{
    Privilege.viewStudentSummary,
    Privilege.viewStudentsAnecdotal,
    Privilege.writeStudentsAnecdotal,
  }),
  _NavItem(
    '/app/student-records',
    'My Records',
    Icons.folder_shared_rounded,
    <Privilege>{Privilege.studentPrivileges},
  ),
  _NavItem(
    '/app/child-records',
    'My Child Records',
    Icons.family_restroom_rounded,
    <Privilege>{Privilege.parentPrivileges},
  ),
  _NavItem('/app/content', 'Content Management', Icons.web_rounded, <Privilege>{
    Privilege.manageWebsiteContent,
  }),
  _NavItem(
    '/app/audit-trail',
    'Audit Trail',
    Icons.history_rounded,
    <Privilege>{Privilege.admin},
  ),
  _NavItem(
    '/app/notifications',
    'Notifications',
    Icons.notifications_rounded,
    <Privilege>{},
  ),
];
