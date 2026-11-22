import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/extensions/user_role_x.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? me = ref.watch(authProvider);
    if (me == null) return const SizedBox.shrink();

    final TextEditingController firstCtrl = useTextEditingController(
      text: me.firstName,
    );
    final TextEditingController lastCtrl = useTextEditingController(
      text: me.lastName,
    );
    final TextEditingController emailCtrl = useTextEditingController(
      text: me.email,
    );
    final ValueNotifier<String?> error = useState<String?>(null);
    final ValueNotifier<bool> dirty = useState(false);

    // Reset controllers when the user object changes (e.g. after save).
    useEffect(() {
      firstCtrl.text = me.firstName;
      lastCtrl.text = me.lastName;
      emailCtrl.text = me.email;
      dirty.value = false;
      return null;
    }, [me.id, me.firstName, me.lastName, me.email]);

    useEffect(() {
      void listener() {
        dirty.value =
            firstCtrl.text != me.firstName ||
            lastCtrl.text != me.lastName ||
            emailCtrl.text != me.email;
      }

      firstCtrl.addListener(listener);
      lastCtrl.addListener(listener);
      emailCtrl.addListener(listener);
      return () {
        firstCtrl.removeListener(listener);
        lastCtrl.removeListener(listener);
        emailCtrl.removeListener(listener);
      };
    }, [firstCtrl, lastCtrl, emailCtrl]);

    final Role? role = ref.watch(roleByIdProvider(me.roleId));

    Future<void> save() async {
      final String? err = await ref
          .read(authProvider.notifier)
          .updateOwnProfile(
            firstName: firstCtrl.text,
            lastName: lastCtrl.text,
            email: emailCtrl.text,
          );
      error.value = err;
      if (err == null && context.mounted) {
        dirty.value = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile updated.')));
      }
    }

    return AppPageScaffold(
      title: 'My Profile',
      subtitle:
          'Update your own account details. Your role and profile-specific '
          'fields are managed by an administrator.',
      actions: [
        OutlinedButton.icon(
          onPressed: () => context.go('/app/profile/change-password'),
          icon: const Icon(Icons.password_rounded),
          label: const Text('Change password'),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: dirty.value ? save : null,
          icon: const Icon(Icons.save_rounded),
          label: const Text('Save'),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      child: Text(
                        me.firstName.substring(0, 1).toUpperCase(),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            me.fullName,
                            style: context.textTheme.titleLarge,
                          ),
                          Text(me.email, style: context.textTheme.bodySmall),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Chip(
                                avatar: Icon(
                                  role?.kind.icon ?? Icons.person_rounded,
                                  size: 14,
                                ),
                                label: Text(role?.name ?? '—'),
                                visualDensity: VisualDensity.compact,
                              ),
                              if (me.mustChangePassword) ...[
                                const SizedBox(width: 8),
                                Chip(
                                  avatar: const Icon(
                                    Icons.warning_amber_rounded,
                                    size: 14,
                                  ),
                                  label: const Text('Password change required'),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Account', style: context.textTheme.titleSmall),
                    const SizedBox(height: 12),
                    TextField(
                      controller: firstCtrl,
                      decoration: const InputDecoration(
                        labelText: 'First name',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: lastCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Last name',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email_rounded),
                      ),
                    ),
                    if (error.value != null) ...[
                      const SizedBox(height: 12),
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
            if (me.profile is StudentProfile) ...[
              const SizedBox(height: 16),
              _ReadOnlySection(
                title: 'Student profile',
                rows: [
                  ('LRN', (me.profile as StudentProfile).lrn),
                  (
                    'Grade level',
                    (me.profile as StudentProfile).gradeLevel.label,
                  ),
                  (
                    'School level',
                    (me.profile as StudentProfile).gradeLevel.schoolLevel.label,
                  ),
                ],
              ),
            ],
            if (me.profile is ParentProfile) ...[
              const SizedBox(height: 16),
              _ReadOnlySection(
                title: 'Parent profile',
                rows: [
                  (
                    'Children',
                    (me.profile as ParentProfile).childIds.join(', '),
                  ),
                ],
              ),
            ],
            if (me.profile is PrincipalProfile) ...[
              const SizedBox(height: 16),
              _ReadOnlySection(
                title: 'Principal profile',
                rows: [
                  ('Position', (me.profile as PrincipalProfile).position.label),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ReadOnlySection extends StatelessWidget {
  const _ReadOnlySection({required this.title, required this.rows});
  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: context.textTheme.titleSmall),
                ),
                Icon(
                  Icons.lock_outline_rounded,
                  size: 16,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final (label, value) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(label, style: context.textTheme.bodySmall),
                    ),
                    Expanded(
                      child: Text(value, style: context.textTheme.bodyMedium),
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
