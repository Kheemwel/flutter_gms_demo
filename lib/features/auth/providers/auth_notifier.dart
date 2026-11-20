import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_users.dart';

part 'auth_notifier.g.dart';

sealed class LoginResult {
  const LoginResult();
}

class LoginSuccess extends LoginResult {
  const LoginSuccess(this.user);
  final UserAccount user;
}

class LoginFailure extends LoginResult {
  const LoginFailure(this.message);
  final String message;
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  UserAccount? build() => null;

  Future<LoginResult> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final String normalized = email.trim().toLowerCase();
    UserAccount? match;
    for (final UserAccount u in seedUsers) {
      if (u.email.toLowerCase() == normalized) {
        match = u;
        break;
      }
    }
    if (match == null || password != demoPassword) {
      return const LoginFailure('Invalid email or password.');
    }
    if (match.isArchived) {
      return const LoginFailure('This account has been archived.');
    }

    final UserAccount updated = match.copyWith(
      totalLogin: match.totalLogin + 1,
      lastLogin: DateTime.now(),
      rememberToken: rememberMe ? 'demo-remember-token' : null,
    );
    state = updated;
    ref
        .read(auditLogsProvider.notifier)
        .log(
          userAccountId: updated.id,
          action: 'Login',
          description: '${updated.fullName} signed in.',
        );
    return LoginSuccess(updated);
  }

  void loginAs(UserAccount user) {
    state = user.copyWith(
      totalLogin: user.totalLogin + 1,
      lastLogin: DateTime.now(),
    );
  }

  /// Demo-only: flips `mustChangePassword` off. A real app would
  /// verify the current password and store the new hash.
  void changePassword({required String newPassword}) {
    final UserAccount? current = state;
    if (current == null) return;
    state = current.copyWith(mustChangePassword: false);
  }

  void logout() {
    final UserAccount? me = state;
    if (me != null) {
      ref
          .read(auditLogsProvider.notifier)
          .log(
            userAccountId: me.id,
            action: 'Logout',
            description: '${me.fullName} signed out.',
          );
    }
    state = null;
  }
}
