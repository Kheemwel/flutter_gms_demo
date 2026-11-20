import 'package:flutter_gms_demo/core/extensions/user_role_x.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/features/user_accounts/presentation/role_picker_dialog.dart';
import 'package:flutter_gms_demo/features/user_accounts/presentation/user_form_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_providers.dart';
import 'package:flutter_gms_demo/features/user_accounts/presentation/view_user_dialog.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_providers.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';

class UserAccountsPage extends ConsumerWidget {
  const UserAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({int active, int archived}) counts = ref.watch(userCountsProvider);
    final bool canManage =
        ref.can(Privilege.manageRoles) ||
        ref.can(Privilege.admin); // demo permission — adjust later

    return AppPageScaffold(
      title: 'User Accounts',
      subtitle:
          'All users in the system. Archive to hide without deleting; '
          'archived accounts can be restored at any time.',
      actions: [
        if (canManage)
          FilledButton.icon(
            // TODO(Batch 3 part 2): open add-user flow
            onPressed: () => _openAddFlow(context, ref),
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: const Text('Add user'),
          ),
        const SizedBox(width: 8),
        if (canManage)
          OutlinedButton.icon(
            // TODO(Batch 9): CSV import dialog
            onPressed: () => _showPlaceholder(context, 'Import CSV'),
            icon: const Icon(Icons.upload_file_rounded),
            label: const Text('Import'),
          ),
      ],
      child: AppTabs(
        tabs: [
          AppTabSpec(label: 'Active', count: counts.active),
          AppTabSpec(label: 'Archived', count: counts.archived),
        ],
        children: const [
          _UserListView(tab: UserAccountTab.active),
          _UserListView(tab: UserAccountTab.archived),
        ],
      ),
    );
  }

  void _showPlaceholder(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label will land in a later batch.')),
    );
  }

  Future<void> _openAddFlow(BuildContext context, WidgetRef ref) async {
    final RoleKind? kind = await showRolePicker(context);
    if (kind == null || !context.mounted) return;
    final UserAccount? created = await showUserForm(context, kind: kind);
    if (created == null || !context.mounted) return;
    // Record in audit log
    final UserAccount? me = ref.read(authProvider);
    ref
        .read(auditLogsProvider.notifier)
        .log(
          userAccountId: me?.id ?? 'system',
          action: 'Create User',
          description:
              'Created ${created.roleId} account '
              '"${created.fullName}" (${created.email})',
        );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('"${created.fullName}" created.')));
  }
}

class _UserListView extends ConsumerStatefulWidget {
  const _UserListView({required this.tab});
  final UserAccountTab tab;

  @override
  ConsumerState<_UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends ConsumerState<_UserListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<UserAccount> users = ref.watch(usersForTabProvider(widget.tab));
    final String search = ref.watch(userAccountSearchProvider);
    final RoleKind? roleFilter = ref.watch(userAccountRoleFilterProvider);
    final bool canManage =
        ref.can(Privilege.manageRoles) || ref.can(Privilege.admin);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FiltersRow(
          search: search,
          roleFilter: roleFilter,
          onSearch: (v) =>
              ref.read(userAccountSearchProvider.notifier).state = v,
          onRoleFilter: (v) =>
              ref.read(userAccountRoleFilterProvider.notifier).state = v,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: users.isEmpty
              ? AppEmptyState(
                  icon: widget.tab == UserAccountTab.archived
                      ? Icons.archive_outlined
                      : Icons.people_outline_rounded,
                  title: widget.tab == UserAccountTab.archived
                      ? 'No archived users'
                      : 'No users found',
                  message: search.isEmpty
                      ? widget.tab == UserAccountTab.archived
                            ? 'Users you archive will appear here.'
                            : 'Create your first user to get started.'
                      : 'Try a different search or filter.',
                )
              : _UsersTable(
                  users: users,
                  isArchivedTab: widget.tab == UserAccountTab.archived,
                  canManage: canManage,
                ),
        ),
      ],
    );
  }
}

class _FiltersRow extends ConsumerWidget {
  const _FiltersRow({
    required this.search,
    required this.roleFilter,
    required this.onSearch,
    required this.onRoleFilter,
  });

  final String search;
  final RoleKind? roleFilter;
  final ValueChanged<String> onSearch;
  final ValueChanged<RoleKind?> onRoleFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search by name or email…',
              prefixIcon: Icon(Icons.search_rounded),
            ),
            onChanged: onSearch,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 220,
          child: DropdownButtonFormField<RoleKind?>(
            initialValue: roleFilter,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.filter_alt_outlined),
            ),
            items: [
              const DropdownMenuItem<RoleKind?>(
                value: null,
                child: Text('All roles'),
              ),
              for (final kind in RoleKind.values)
                DropdownMenuItem<RoleKind?>(
                  value: kind,
                  child: Text(kind.label),
                ),
            ],
            onChanged: onRoleFilter,
          ),
        ),
      ],
    );
  }
}

class _UsersTable extends ConsumerWidget {
  const _UsersTable({
    required this.users,
    required this.isArchivedTab,
    required this.canManage,
  });

  final List<UserAccount> users;
  final bool isArchivedTab;
  final bool canManage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Last login')),
              DataColumn(label: Text('')),
            ],
            rows: [for (final u in users) _row(context, ref, u)],
          ),
        ),
      ),
    );
  }

  DataRow _row(BuildContext context, WidgetRef ref, UserAccount u) {
    final Role? role = ref.watch(roleByIdProvider(u.roleId));
    return DataRow(
      onSelectChanged: (_) => _viewUser(context, u),
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: context.colorScheme.primaryContainer,
                child: Text(
                  _initials(u.fullName),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(u.fullName),
            ],
          ),
        ),
        DataCell(Text(u.email)),
        DataCell(
          Chip(
            avatar: Icon(role?.kind.icon ?? Icons.person_rounded, size: 14),
            label: Text(role?.name ?? '—'),
            visualDensity: VisualDensity.compact,
          ),
        ),
        DataCell(
          Text(u.lastLogin == null ? 'Never' : _formatRelative(u.lastLogin!)),
        ),
        DataCell(
          PopupMenuButton<_RowAction>(
            onSelected: (a) => _handle(context, ref, u, a),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: _RowAction.view,
                child: ListTile(
                  leading: Icon(Icons.visibility_outlined),
                  title: Text('View details'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              if (canManage) ...[
                const PopupMenuItem(
                  value: _RowAction.edit,
                  child: ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Edit'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                if (isArchivedTab)
                  const PopupMenuItem(
                    value: _RowAction.unarchive,
                    child: ListTile(
                      leading: Icon(Icons.unarchive_outlined),
                      title: Text('Restore'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                else
                  const PopupMenuItem(
                    value: _RowAction.archive,
                    child: ListTile(
                      leading: Icon(Icons.archive_outlined),
                      title: Text('Archive'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                const PopupMenuItem(
                  value: _RowAction.delete,
                  child: ListTile(
                    leading: Icon(Icons.delete_outline_rounded),
                    title: Text('Delete'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handle(
    BuildContext context,
    WidgetRef ref,
    UserAccount user,
    _RowAction action,
  ) async {
    final UserAccounts notifier = ref.read(userAccountsProvider.notifier);
    final AuditLogsNotifier audit = ref.read(auditLogsProvider.notifier);
    final UserAccount? me = ref.read(authProvider);

    switch (action) {
      case _RowAction.view:
        await _viewUser(context, user);
        return;
      case _RowAction.edit:
        final UserAccount? created = await showUserForm(
          context,
          kind: _kindForUser(user, ref),
          existing: user,
        );
        if (created == null) return;
        audit.log(
          userAccountId: me?.id ?? 'system',
          action: 'Update User',
          description: 'Updated user "${created.fullName}" (${created.email})',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('"${created.fullName}" updated.')),
          );
        }
        return;
      case _RowAction.archive:
        final bool ok = await appConfirm(
          context,
          title: 'Archive user?',
          message:
              'Archive "${user.fullName}"? They will not be able to log in '
              'but their records remain intact.',
          confirmLabel: 'Archive',
        );
        if (!ok) return;
        await notifier.archive(user.id);
        audit.log(
          userAccountId: me?.id ?? 'system',
          action: 'Archive User',
          description: 'Archived user "${user.fullName}" (${user.email})',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('"${user.fullName}" archived.')),
          );
        }
        return;
      case _RowAction.unarchive:
        await notifier.unarchive(user.id);
        audit.log(
          userAccountId: me?.id ?? 'system',
          action: 'Restore User',
          description: 'Restored user "${user.fullName}" (${user.email})',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('"${user.fullName}" restored.')),
          );
        }
        return;
      case _RowAction.delete:
        final bool ok = await appConfirm(
          context,
          title: 'Delete user?',
          message:
              'Permanently delete "${user.fullName}"? '
              'This cannot be undone. Consider archiving instead.',
          confirmLabel: 'Delete',
          destructive: true,
        );
        if (!ok) return;
        await notifier.delete(user.id);
        audit.log(
          userAccountId: me?.id ?? 'system',
          action: 'Delete User',
          description: 'Deleted user "${user.fullName}" (${user.email})',
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('"${user.fullName}" deleted.')),
          );
        }
        return;
    }
  }

  Future<void> _viewUser(BuildContext context, UserAccount user) {
    return showDialog<void>(
      context: context,
      builder: (_) => ViewUserDialog(user: user),
    );
  }

  String _initials(String fullName) {
    final List<String> parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  String _formatRelative(DateTime d) {
    final Duration diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 30) return '${diff.inDays}d ago';
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  RoleKind _kindForUser(UserAccount user, WidgetRef ref) {
    final Role? role = ref.read(roleByIdProvider(user.roleId));
    return role?.kind ?? RoleKind.student;
  }
}

enum _RowAction { view, edit, archive, unarchive, delete }
