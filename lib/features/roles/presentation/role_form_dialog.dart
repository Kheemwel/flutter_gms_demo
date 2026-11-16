import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';

part 'role_form_dialog.freezed.dart';

@freezed
abstract class RoleForm with _$RoleForm {
  const factory RoleForm({
    required String name,
    required RoleKind kind,
    required Set<Privilege> privileges,
  }) = _RoleForm;

  factory RoleForm.empty() => const RoleForm(
    name: '',
    kind: RoleKind.guidance,
    privileges: <Privilege>{},
  );

  factory RoleForm.fromRole(Role role) =>
      RoleForm(name: role.name, kind: role.kind, privileges: role.privileges);
}

class RoleFormDialog extends HookConsumerWidget {
  const RoleFormDialog({super.key, this.existing});

  final Role? existing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RoleForm initial = existing == null
        ? RoleForm.empty()
        : RoleForm.fromRole(existing!);
    final TextEditingController nameCtrl = useTextEditingController(
      text: initial.name,
    );
    final ValueNotifier<RoleKind> kind = useState<RoleKind>(initial.kind);
    final ValueNotifier<Set<Privilege>> privileges = useState<Set<Privilege>>(
      initial.privileges,
    );
    final ValueNotifier<String?> error = useState<String?>(null);

    bool submit() {
      final String trimmed = nameCtrl.text.trim();
      if (trimmed.isEmpty) {
        error.value = 'Role name is required.';
        return false;
      }
      if (privileges.value.isEmpty) {
        error.value = 'Select at least one privilege.';
        return false;
      }
      Navigator.of(context).pop<Role>(
        Role(
          id: existing?.id ?? 'role-${DateTime.now().microsecondsSinceEpoch}',
          name: trimmed,
          kind: kind.value,
          privileges: Set<Privilege>.unmodifiable(privileges.value),
        ),
      );
      return true;
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      existing == null ? 'Add role' : 'Edit role',
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
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Role name',
                        prefixIcon: Icon(Icons.badge_rounded),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Role kind', style: context.textTheme.labelLarge),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<RoleKind>(
                      initialValue: kind.value,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.category_rounded),
                      ),
                      items: [
                        for (final k in RoleKind.values)
                          DropdownMenuItem<RoleKind>(
                            value: k,
                            child: Text(k.label),
                          ),
                      ],
                      onChanged: (RoleKind? v) {
                        if (v != null) kind.value = v;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('Privileges', style: context.textTheme.labelLarge),
                    const SizedBox(height: 8),
                    for (final group in PrivilegeGroup.values) ...[
                      _PrivilegeGroupSection(
                        group: group,
                        selected: privileges.value,
                        onToggle: (Privilege p, bool on) {
                          final next = Set<Privilege>.from(privileges.value);
                          if (on) {
                            next.add(p);
                          } else {
                            next.remove(p);
                          }
                          privileges.value = next;
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (error.value != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        error.value!,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => submit(),
                    child: Text(existing == null ? 'Create' : 'Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivilegeGroupSection extends StatelessWidget {
  const _PrivilegeGroupSection({
    required this.group,
    required this.selected,
    required this.onToggle,
  });

  final PrivilegeGroup group;
  final Set<Privilege> selected;
  final void Function(Privilege, bool) onToggle;

  @override
  Widget build(BuildContext context) {
    final List<Privilege> members = Privilege.values
        .where((p) => p.group == group)
        .toList();
    if (members.isEmpty) return const SizedBox.shrink();

    final bool allSelected = members.every(selected.contains);
    final ColorScheme scheme = context.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CheckboxListTile(
              dense: true,
              title: Text(
                group.label,
                style: context.textTheme.titleSmall?.copyWith(
                  color: scheme.primary,
                ),
              ),
              value: allSelected,
              tristate: false,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? v) {
                for (final p in members) {
                  onToggle(p, v ?? false);
                }
              },
            ),
            for (final p in members)
              CheckboxListTile(
                dense: true,
                title: Text(p.label),
                subtitle: Text(p.id, style: context.textTheme.bodySmall),
                value: selected.contains(p),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (bool? v) => onToggle(p, v ?? false),
              ),
          ],
        ),
      ),
    );
  }
}
