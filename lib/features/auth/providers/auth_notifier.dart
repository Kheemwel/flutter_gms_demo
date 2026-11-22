import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_users.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';

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
  /// The only place passwords live. In-memory only; a real backend
  /// would store hashes server-side. Seeded lazily as `demoPassword`.
  final Map<String, String> _passwords = {};

  @override
  UserAccount? build() => null;

  String _passwordFor(String userId) => _passwords[userId] ?? demoPassword;

  /// Reads from the one true user table (UserAccountsNotifier),
  /// never from the seed list directly. That way newly created users,
  /// edited profiles, and archived state are all visible to login.
  Future<UserAccount?> _findByEmail(String normalizedEmail) async {
    final List<UserAccount> all = ref.read(userAccountsProvider);
    for (final UserAccount u in all) {
      if (u.email.toLowerCase() == normalizedEmail) return u;
    }
    return null;
  }

  Future<LoginResult> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final UserAccount? match = await _findByEmail(email.trim().toLowerCase());

    if (match == null) {
      return const LoginFailure('Invalid email or password.');
    }
    if (match.isArchived) {
      return const LoginFailure('This account has been archived.');
    }
    if (password != _passwordFor(match.id)) {
      return const LoginFailure('Invalid email or password.');
    }

    final UserAccount updated = match.copyWith(
      totalLogin: match.totalLogin + 1,
      lastLogin: DateTime.now(),
      rememberToken: rememberMe ? 'demo-remember-token' : null,
    );
    state = updated;

    // Persist the login counters back into the user table so the
    // admin-facing list reflects "last seen" too.
    await ref
        .read(userAccountsProvider.notifier)
        .update(
          match.copyWith(
            totalLogin: updated.totalLogin,
            lastLogin: updated.lastLogin,
            rememberToken: updated.rememberToken,
          ),
        );

    ref
        .read(auditLogsProvider.notifier)
        .log(
          userAccountId: updated.id,
          userFullName: updated.fullName,
          action: 'Login',
          description: '${updated.fullName} signed in.',
        );

    return LoginSuccess(updated);
  }

  /// Demo shortcut from the landing page. Same store, same password
  /// rule — if the user changed their password, the shortcut still
  /// works (it's a demo shortcut), but it goes through the same user
  /// table so profile edits are respected.
  void loginAs(UserAccount seedUser) {
    final List<UserAccount> all = ref.read(userAccountsProvider);
    final UserAccount resolved = all.firstWhere(
      (u) => u.id == seedUser.id,
      orElse: () => seedUser,
    );

    final UserAccount updated = resolved.copyWith(
      totalLogin: resolved.totalLogin + 1,
      lastLogin: DateTime.now(),
    );
    state = updated;

    ref
        .read(userAccountsProvider.notifier)
        .update(
          resolved.copyWith(
            totalLogin: updated.totalLogin,
            lastLogin: updated.lastLogin,
          ),
        );

    ref
        .read(auditLogsProvider.notifier)
        .log(
          userAccountId: updated.id,
          userFullName: updated.fullName,
          action: 'Login (demo shortcut)',
          description: '${updated.fullName} signed in via demo shortcut.',
        );
  }

  void logout() {
    final UserAccount? me = state;
    if (me != null) {
      ref
          .read(auditLogsProvider.notifier)
          .log(
            userAccountId: me.id,
            userFullName: me.fullName,
            action: 'Logout',
            description: '${me.fullName} signed out.',
          );
    }
    state = null;
  }

  Future<String?> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final UserAccount? me = state;
    if (me == null) return 'Not logged in.';
    if (currentPassword != _passwordFor(me.id)) {
      return 'Current password is incorrect.';
    }
    if (newPassword.length < 8) {
      return 'New password must be at least 8 characters.';
    }
    if (newPassword == currentPassword) {
      return 'New password must be different from the current one.';
    }
    if (newPassword != confirmPassword) {
      return 'New password and confirmation do not match.';
    }

    _passwords[me.id] = newPassword;
    final UserAccount updated = me.copyWith(mustChangePassword: false);
    state = updated;

    await ref.read(userAccountsProvider.notifier).update(updated);

    ref
        .read(auditLogsProvider.notifier)
        .log(
          userAccountId: me.id,
          userFullName: me.fullName,
          action: 'Change Password',
          description: '${me.fullName} changed their password.',
        );

    return null;
  }

  Future<String?> updateOwnProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final UserAccount? me = state;
    if (me == null) return 'Not logged in.';

    final String fn = firstName.trim();
    final String ln = lastName.trim();
    final String em = email.trim().toLowerCase();

    if (fn.isEmpty) return 'First name is required.';
    if (ln.isEmpty) return 'Last name is required.';
    if (em.isEmpty) return 'Email is required.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(em)) {
      return 'Enter a valid email address.';
    }

    // Uniqueness check across the real user table, excluding self.
    final List<UserAccount> all = ref.read(userAccountsProvider);
    for (final UserAccount u in all) {
      if (u.id != me.id && u.email.toLowerCase() == em) {
        return 'That email is already used by another account.';
      }
    }

    final UserAccount updated = me.copyWith(
      firstName: fn,
      lastName: ln,
      email: em,
    );
    state = updated;

    await ref.read(userAccountsProvider.notifier).update(updated);

    ref
        .read(auditLogsProvider.notifier)
        .log(
          userAccountId: me.id,
          userFullName: updated.fullName,
          action: 'Update Profile',
          description: '${me.fullName} updated their own profile.',
        );

    return null;
  }
}
