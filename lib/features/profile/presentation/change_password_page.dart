import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class ChangePasswordPage extends HookConsumerWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController currentCtrl = useTextEditingController();
    final TextEditingController newCtrl = useTextEditingController();
    final TextEditingController confirmCtrl = useTextEditingController();
    final ValueNotifier<String?> error = useState<String?>(null);
    final ValueNotifier<bool> submitting = useState(false);

    Future<void> submit() async {
      error.value = null;
      submitting.value = true;
      final String? err = await ref
          .read(authProvider.notifier)
          .changePassword(
            currentPassword: currentCtrl.text,
            newPassword: newCtrl.text,
            confirmPassword: confirmCtrl.text,
          );
      submitting.value = false;
      if (err != null) {
        error.value = err;
        return;
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Password changed.')));
        context.go('/app/profile');
      }
    }

    return AppPageScaffold(
      title: 'Change Password',
      subtitle:
          'Your current password is required. New passwords must be at '
          'least 8 characters and cannot match the current one.',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: currentCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Current password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: newCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New password',
                      prefixIcon: Icon(Icons.lock_reset_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm new password',
                      prefixIcon: Icon(Icons.lock_reset_rounded),
                    ),
                    onSubmitted: (_) => submit(),
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
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: submitting.value ? null : submit,
                    child: submitting.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Change password'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/app/profile'),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
