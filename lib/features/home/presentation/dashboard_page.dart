import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? user = ref.watch(authProvider);
    if (user == null) return const SizedBox.shrink();

    return AppPageScaffold(
      title: 'Welcome back, ${user.firstName}',
      subtitle: 'This is a placeholder dashboard. Real content lands later.',
      child: ListView(
        children: [
          if (user.mustChangePassword) _MustChangePasswordBanner(),
          const SizedBox(height: 16),
          Text(
            'You are logged in as ${user.email}.',
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _MustChangePasswordBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(Batch 8): real "change password" dialog with current-password
    // verification. For now this just clears the flag so the demo can
    // progress past first login.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: context.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'You are using the temporary password. Change it to clear '
              'this notice.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onErrorContainer,
              ),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.tonal(
            onPressed: () {
              ref
                  .read(authProvider.notifier)
                  .changePassword(newPassword: 'anything');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Demo: password change simulated.'),
                ),
              );
            },
            child: const Text('Change now'),
          ),
        ],
      ),
    );
  }
}
