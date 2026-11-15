import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/data/in_memory/seed_users.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailCtrl = useTextEditingController();
    final TextEditingController passCtrl = useTextEditingController();
    final ValueNotifier<bool> rememberMe = useState(false);
    final ValueNotifier<bool> submitting = useState(false);
    final ValueNotifier<String?> error = useState<String?>(null);

    Future<void> submit() async {
      setStateSafely(() {
        error.value = null;
        submitting.value = true;
      });
      final LoginResult result = await ref
          .read(authProvider.notifier)
          .login(
            email: emailCtrl.text,
            password: passCtrl.text,
            rememberMe: rememberMe.value,
          );
      if (!context.mounted) return;
      submitting.value = false;
      switch (result) {
        case LoginSuccess():
          context.go('/app/dashboard');
        case LoginFailure(:final message):
          error.value = message;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Sign in', style: context.textTheme.headlineMedium),
                  const SizedBox(height: 6),
                  Text(
                    'Welcome back. Use one of the demo accounts.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.alternate_email_rounded),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                    obscureText: true,
                    onSubmitted: (_) => submit(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe.value,
                        onChanged: (v) => rememberMe.value = v ?? false,
                      ),
                      const Text('Remember me'),
                      const Spacer(),
                      TextButton(
                        onPressed: () => context.go('/forgot-password'),
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                  if (error.value != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      error.value!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: submitting.value ? null : submit,
                    child: submitting.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Sign in'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Back to home'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Demo accounts (password: password):',
                    style: context.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final u in seedUsers.where(
                        (u) => !u.id.endsWith('b'),
                      ))
                        ActionChip(
                          label: Text(u.email),
                          onPressed: () {
                            emailCtrl.text = u.email;
                            passCtrl.text = demoPassword;
                          },
                        ),
                    ],
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

/// tiny helper so hooks can be mutated inside async funcs without lint noise
void setStateSafely(VoidCallback fn) => fn();
