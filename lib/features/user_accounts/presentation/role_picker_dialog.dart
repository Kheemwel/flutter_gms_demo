import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/extensions/user_role_x.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';

/// Shows the role picker; returns the chosen kind, or null on cancel.
Future<RoleKind?> showRolePicker(BuildContext context) {
  return showDialog<RoleKind>(
    context: context,
    builder: (_) => const _RolePickerDialog(),
  );
}

class _RolePickerDialog extends ConsumerWidget {
  const _RolePickerDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'What kind of user?',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Text(
                'The role determines what fields you fill in next '
                'and what the account can do.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (final kind in RoleKind.values)
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: context.colorScheme.primaryContainer,
                        child: Icon(
                          kind.icon,
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      title: Text(kind.label),
                      subtitle: Text(_blurbFor(kind)),
                      onTap: () => Navigator.of(context).pop(kind),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _blurbFor(RoleKind kind) => switch (kind) {
    RoleKind.admin => 'Full system access, manages roles and accounts.',
    RoleKind.guidance => 'Approves forms, manages student records.',
    RoleKind.student => 'Views own records, signs own forms.',
    RoleKind.parent => 'Views their children\'s records and forms.',
    RoleKind.teacher => 'Creates form requests for their students.',
    RoleKind.principal => 'Signs and reviews home visitation forms.',
  };
}
