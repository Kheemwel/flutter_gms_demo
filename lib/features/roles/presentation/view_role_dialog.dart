import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/role.dart';

class ViewRoleDialog extends ConsumerWidget {
  const ViewRoleDialog({super.key, required this.role});

  final Role role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(role.name, style: context.textTheme.titleLarge),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                spacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.category_rounded, size: 16),
                    label: Text(role.kind.label),
                  ),
                  Chip(
                    avatar: const Icon(Icons.key_rounded, size: 16),
                    label: Text('${role.privileges.length} privileges'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                children: [
                  for (final group in PrivilegeGroup.values)
                    _GroupTile(group: group, privileges: role.privileges),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupTile extends StatelessWidget {
  const _GroupTile({required this.group, required this.privileges});

  final PrivilegeGroup group;
  final Set<Privilege> privileges;

  @override
  Widget build(BuildContext context) {
    final List<Privilege> members = Privilege.values
        .where((p) => p.group == group && privileges.contains(p))
        .toList();
    if (members.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.label, style: context.textTheme.titleSmall),
          const SizedBox(height: 4),
          for (final p in members)
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 2),
              child: Row(
                children: [
                  const Icon(Icons.check_rounded, size: 16),
                  const SizedBox(width: 8),
                  Text(p.label, style: context.textTheme.bodyMedium),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
