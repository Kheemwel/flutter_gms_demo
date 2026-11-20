import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/site_content.dart';
import 'package:flutter_gms_demo/core/utilities/logo_palette.dart';
import 'package:flutter_gms_demo/features/content_management/providers/site_content_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gms_demo/data/in_memory/seed_users.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SiteContent content = ref.watch(siteContentProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  // Gradient "logo" placeholder
                  Center(
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: logoPalette(context, content.logoPreset),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        color: context.colorScheme.onPrimary,
                        size: 48,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    content.title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.displaySmall?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    content.subtitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Primary actions
                  Center(
                    child: FilledButton.icon(
                      onPressed: () => context.go('/login'),
                      icon: const Icon(Icons.login_rounded),
                      label: const Text('Sign in'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'or jump straight in as a role:',
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final u in seedUsers.where(
                        (u) => !u.id.endsWith('b'),
                      ))
                        OutlinedButton.icon(
                          onPressed: () {
                            ref.read(authProvider.notifier).loginAs(u);
                            context.go('/app/dashboard');
                          },
                          icon: Icon(_iconFor(u.roleId), size: 18),
                          label: Text(u.lastName),
                        ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Demo password for every account: password',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String roleId) => switch (roleId) {
    'role-admin' => Icons.admin_panel_settings_rounded,
    'role-guidance' => Icons.support_agent_rounded,
    'role-student' => Icons.school_rounded,
    'role-parent' => Icons.family_restroom_rounded,
    'role-teacher' => Icons.co_present_rounded,
    'role-principal-jr' || 'role-principal-sr' => Icons.badge_rounded,
    _ => Icons.person_rounded,
  };
}
