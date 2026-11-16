import 'package:flutter_gms_demo/core/extensions/user_role_x.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/grade_level.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/new_user_factory.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_form_state.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_form_validator.dart';

/// Shows the create/edit user dialog. Returns the resulting account
/// on success (already saved via the notifier), or null on cancel.
Future<UserAccount?> showUserForm(
  BuildContext context, {
  required RoleKind kind,
  UserAccount? existing,
}) {
  return showDialog<UserAccount>(
    context: context,
    builder: (_) => _UserFormDialog(kind: kind, existing: existing),
  );
}

class _UserFormDialog extends HookConsumerWidget {
  const _UserFormDialog({required this.kind, this.existing});

  final RoleKind kind;
  final UserAccount? existing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = existing == null
        ? UserFormState.empty(kind)
        : UserFormState.fromUser(existing!);

    final TextEditingController firstNameCtrl = useTextEditingController(
      text: initial.firstName,
    );
    final TextEditingController lastNameCtrl = useTextEditingController(
      text: initial.lastName,
    );
    final TextEditingController emailCtrl = useTextEditingController(
      text: initial.email,
    );
    final TextEditingController lrnCtrl = useTextEditingController(
      text: initial.lrn,
    );

    final ValueNotifier<GradeLevel> gradeLevel = useState<GradeLevel>(
      initial.gradeLevel,
    );
    final ValueNotifier<List<String>> childIds = useState<List<String>>(
      initial.childIds,
    );
    final ValueNotifier<PrincipalPosition> position =
        useState<PrincipalPosition>(initial.position);

    final ValueNotifier<Map<String, String>> errors =
        useState<Map<String, String>>(const {});
    final ValueNotifier<bool> submitting = useState(false);

    UserFormState snapshot() => UserFormState(
      kind: kind,
      firstName: firstNameCtrl.text,
      lastName: lastNameCtrl.text,
      email: emailCtrl.text,
      lrn: lrnCtrl.text,
      gradeLevel: gradeLevel.value,
      childIds: childIds.value,
      position: position.value,
    );

    Future<void> submit() async {
      final UserFormState form = snapshot();

      // Build existing-email / existing-LRN lists excluding the
      // user being edited so we don't collide with ourselves.
      final List<UserAccount> allUsers = ref.read(userAccountsProvider);
      final existingEmails = <String>[];
      final existingLrns = <String>[];
      for (final u in allUsers) {
        if (u.id == existing?.id) continue;
        existingEmails.add(u.email.toLowerCase());
        if (u.profile is StudentProfile) {
          existingLrns.add((u.profile as StudentProfile).lrn);
        }
      }

      final Map<String, String> fieldErrors = validateUserForm(
        form: form,
        existingEmails: existingEmails,
        existingLrns: existingLrns,
      );
      if (fieldErrors.isNotEmpty) {
        errors.value = fieldErrors;
        return;
      }
      errors.value = const {};
      submitting.value = true;

      // Resolve the role the user selected — for create this is a
      // lookup by kind (there may be multiple roles of the same kind
      // once admins create custom ones). We pick the first match.
      final List<Role> roles = ref.read(rolesProvider);
      Role? resolved;
      if (existing != null) {
        resolved = roles.where((r) => r.id == existing!.roleId).firstOrNull;
      }
      resolved ??= roles.where((r) => r.kind == kind).firstOrNull;

      if (resolved == null) {
        submitting.value = false;
        errors.value = {
          '_':
              'No role of kind "${kind.label}" exists. '
              'Create one first under Roles & Privileges.',
        };
        return;
      }

      final UserAccount account = userFromForm(
        form: form,
        role: resolved,
        existing: existing,
      );

      final UserAccounts notifier = ref.read(userAccountsProvider.notifier);
      if (existing == null) {
        await notifier.add(account);
      } else {
        await notifier.update(account);
      }
      if (context.mounted) Navigator.of(context).pop(account);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(existing: existing, kind: kind),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _SectionLabel('Account'),
                    _Field(
                      label: 'First name',
                      controller: firstNameCtrl,
                      error: errors.value['firstName'],
                      icon: Icons.person_outline_rounded,
                    ),
                    _Field(
                      label: 'Last name',
                      controller: lastNameCtrl,
                      error: errors.value['lastName'],
                      icon: Icons.person_outline_rounded,
                    ),
                    _Field(
                      label: 'Email',
                      controller: emailCtrl,
                      error: errors.value['email'],
                      icon: Icons.alternate_email_rounded,
                      keyboard: TextInputType.emailAddress,
                    ),
                    if (existing == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          'Password will be the demo default ("password") '
                          'and the user will be prompted to change it.',
                          style: context.textTheme.bodySmall,
                        ),
                      ),

                    if (kind == RoleKind.student) ...[
                      const SizedBox(height: 24),
                      const _SectionLabel('Student profile'),
                      _Field(
                        label: 'LRN (12 digits)',
                        controller: lrnCtrl,
                        error: errors.value['lrn'],
                        icon: Icons.pin_outlined,
                        keyboard: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<GradeLevel>(
                        initialValue: gradeLevel.value,
                        decoration: const InputDecoration(
                          labelText: 'Grade level',
                          prefixIcon: Icon(Icons.school_outlined),
                        ),
                        items: [
                          for (final g in GradeLevel.values)
                            DropdownMenuItem<GradeLevel>(
                              value: g,
                              child: Text(g.label),
                            ),
                        ],
                        onChanged: (v) {
                          if (v != null) gradeLevel.value = v;
                        },
                      ),
                    ],

                    if (kind == RoleKind.parent) ...[
                      const SizedBox(height: 24),
                      const _SectionLabel('Parent profile'),
                      _ChildPicker(
                        selected: childIds.value,
                        onChanged: (v) => childIds.value = v,
                        error: errors.value['childIds'],
                      ),
                    ],

                    if (kind == RoleKind.principal) ...[
                      const SizedBox(height: 24),
                      const _SectionLabel('Principal profile'),
                      DropdownButtonFormField<PrincipalPosition>(
                        initialValue: position.value,
                        decoration: const InputDecoration(
                          labelText: 'Position',
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                        items: [
                          for (final p in PrincipalPosition.values)
                            DropdownMenuItem<PrincipalPosition>(
                              value: p,
                              child: Text(p.label),
                            ),
                        ],
                        onChanged: (v) {
                          if (v != null) position.value = v;
                        },
                      ),
                    ],

                    if (errors.value['_'] != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          errors.value['_']!,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onErrorContainer,
                          ),
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
                    onPressed: submitting.value
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: submitting.value ? null : submit,
                    child: submitting.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            existing == null ? 'Create user' : 'Save changes',
                          ),
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

class _Header extends StatelessWidget {
  const _Header({required this.existing, required this.kind});

  final UserAccount? existing;
  final RoleKind kind;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.colorScheme.primaryContainer,
            child: Icon(
              kind.icon,
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  existing == null ? 'Add ${kind.label}' : 'Edit ${kind.label}',
                  style: context.textTheme.titleLarge,
                ),
                Text(
                  existing == null
                      ? 'Fill in the details below.'
                      : 'Update the details and save.',
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: context.textTheme.titleSmall),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.error,
    this.icon,
    this.keyboard,
  });

  final String label;
  final TextEditingController controller;
  final String? error;
  final IconData? icon;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon == null ? null : Icon(icon),
          errorText: error,
        ),
      ),
    );
  }
}

class _ChildPicker extends ConsumerWidget {
  const _ChildPicker({
    required this.selected,
    required this.onChanged,
    this.error,
  });

  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UserAccount> allStudents = ref
        .watch(userAccountsProvider)
        .where((u) => u.profile is StudentProfile && !u.isArchived)
        .toList(growable: false);

    if (allStudents.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'No students available. Create a student first.',
          style: context.textTheme.bodySmall,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Children (${selected.length} selected)',
          style: context.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (final s in allStudents)
                CheckboxListTile(
                  dense: true,
                  title: Text(s.fullName),
                  subtitle: Text(s.email),
                  value: selected.contains(s.id),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? v) {
                    final next = List<String>.from(selected);
                    if (v ?? false) {
                      next.add(s.id);
                    } else {
                      next.remove(s.id);
                    }
                    onChanged(next);
                  },
                ),
            ],
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              error!,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
