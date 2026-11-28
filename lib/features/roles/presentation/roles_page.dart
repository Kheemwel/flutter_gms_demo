import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/features/roles/presentation/role_form_dialog.dart';
import 'package:flutter_gms_demo/features/roles/presentation/view_role_dialog.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_confirm_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class RolesPage extends ConsumerStatefulWidget {
  const RolesPage({super.key});

  @override
  ConsumerState<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends ConsumerState<RolesPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final List<Role> all = ref.watch(rolesProvider);
    final List<Role> filtered = _query.isEmpty
        ? all
        : all
              .where(
                (Role r) =>
                    r.name.toLowerCase().contains(_query.toLowerCase()) ||
                    r.kind.label.toLowerCase().contains(_query.toLowerCase()),
              )
              .toList();
    final bool canManage = ref.can(Privilege.manageRoles);

    return AppPageScaffold(
      title: 'Roles & Privileges',
      subtitle:
          'Define role variants and control what each can access. '
          'Role behavior is fixed by "kind"; privileges decide what '
          'screens are reachable.',
      actions: [
        if (canManage)
          FilledButton.icon(
            onPressed: () => _openForm(context),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add role'),
          ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SearchField(
            value: _query,
            onChanged: (String v) => setState(() => _query = v),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filtered.isEmpty
                ? AppEmptyState(
                    icon: Icons.shield_outlined,
                    title: _query.isEmpty
                        ? 'No roles yet'
                        : 'No roles match "$_query"',
                    message: _query.isEmpty
                        ? 'Create your first role to get started.'
                        : 'Try a different search term.',
                  )
                : _RolesTable(
                    roles: filtered,
                    canManage: canManage,
                    onView: (Role r) => _view(context, r),
                    onEdit: (Role r) => _openForm(context, existing: r),
                    onDelete: (Role r) => _delete(context, r),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _openForm(BuildContext context, {Role? existing}) async {
    final Role? result = await showDialog<Role>(
      context: context,
      builder: (_) => RoleFormDialog(existing: existing),
    );
    if (result == null) return;
    final RolesNotifier notifier = ref.read(rolesProvider.notifier);
    if (existing == null) {
      notifier.add(result);
    } else {
      notifier.update(result);
    }
  }

  Future<void> _view(BuildContext context, Role role) {
    return showDialog<void>(
      context: context,
      builder: (_) => ViewRoleDialog(role: role),
    );
  }

  Future<void> _delete(BuildContext context, Role role) async {
    final RolesNotifier notifier = ref.read(rolesProvider.notifier);
    if (notifier.isInUse(role.id)) {
      await appConfirm(
        context,
        title: 'Role in use',
        message:
            'The role "${role.name}" is assigned to one or more users. '
            'Reassign those users before deleting this role.',
        confirmLabel: 'OK',
        cancelLabel: 'Close',
        destructive: true,
      );
      return;
    }
    final bool ok = await appConfirm(
      context,
      title: 'Delete role?',
      message:
          'Delete "${role.name}"? This cannot be undone. '
          'Users already assigned to it will lose their privileges.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (ok) notifier.remove(role.id);
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Search by role name or kind…',
        prefixIcon: Icon(Icons.search_rounded),
      ),
    );
  }
}

class _RolesTable extends StatelessWidget {
  const _RolesTable({
    required this.roles,
    required this.canManage,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Role> roles;
  final bool canManage;
  final ValueChanged<Role> onView;
  final ValueChanged<Role> onEdit;
  final ValueChanged<Role> onDelete;

  @override
  Widget build(BuildContext context) {
    return AppDataTable<Role>(
      columns: [
        AppDataTableColumn(label: 'Role', sortBy: (r) => r.name.toLowerCase()),
        AppDataTableColumn(
          label: 'Kind',
          sortBy: (r) => r.kind.label.toLowerCase(),
        ),
        AppDataTableColumn(
          label: 'Privileges',
          numeric: true,
          sortBy: (r) => r.privileges.length,
        ),
        const AppDataTableColumn(label: 'Actions'),
      ],
      onRowTap: onView,
      mobileTileBuilder: (context, role) => ListTile(
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: context.colorScheme.primaryContainer,
          child: Icon(
            _iconForKind(role.kind.name),
            size: 16,
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(role.name),
        subtitle: Text(
          '${role.kind.label} • ${role.privileges.length} privileges',
        ),
        trailing: canManage
            ? IconButton(
                tooltip: 'Delete',
                onPressed: () => onDelete(role),
                icon: const Icon(Icons.delete_outline_rounded),
              )
            : const Icon(Icons.chevron_right_rounded),
      ),
      rows: [
        for (final role in roles)
          AppDataRow<Role>(
            payload: role,
            cells: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: context.colorScheme.primaryContainer,
                    child: Icon(
                      _iconForKind(role.kind.name),
                      size: 16,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(role.name),
                ],
              ),
              Chip(
                label: Text(role.kind.label),
                visualDensity: VisualDensity.compact,
              ),
              Text('${role.privileges.length}'),
              Row(
                children: [
                  IconButton(
                    tooltip: 'View',
                    onPressed: () => onView(role),
                    icon: const Icon(Icons.visibility_outlined),
                  ),
                  if (canManage) ...[
                    IconButton(
                      tooltip: 'Edit',
                      onPressed: () => onEdit(role),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      tooltip: 'Delete',
                      onPressed: () => onDelete(role),
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ],
                ],
              ),
            ],
          ),
      ],
    );
  }

  IconData _iconForKind(String kind) => switch (kind) {
    'admin' => Icons.admin_panel_settings_rounded,
    'guidance' => Icons.support_agent_rounded,
    'student' => Icons.school_rounded,
    'parent' => Icons.family_restroom_rounded,
    'teacher' => Icons.co_present_rounded,
    'principal' => Icons.badge_rounded,
    _ => Icons.shield_rounded,
  };
}
