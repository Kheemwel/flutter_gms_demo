import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/features/home/presentation/dashboard_page.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/lost_and_found_page.dart';
import 'package:flutter_gms_demo/features/user_accounts/presentation/user_accounts_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gms_demo/core/privilege_map.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/auth/presentation/forgot_password_page.dart';
import 'package:flutter_gms_demo/features/auth/presentation/login_page.dart';
import 'package:flutter_gms_demo/features/home/presentation/landing_page.dart';
import 'package:flutter_gms_demo/features/roles/presentation/roles_page.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_providers.dart';
import 'package:flutter_gms_demo/shared/layout/app_shell.dart';
import 'package:flutter_gms_demo/shared/widgets/placeholder_page.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  final ValueNotifier<int> notifier = ValueNotifier<int>(0);
  ref.listen(authProvider, (_, _) => notifier.value++);
  ref.listen(currentPrivilegesProvider, (_, _) => notifier.value++);
  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (BuildContext context, GoRouterState state) {
      final UserAccount? user = ref.read(authProvider);
      final String loc = state.uri.toString();

      const Set<String> publicPaths = {'/', '/login', '/forgot-password'};
      final bool onPublic = publicPaths.contains(loc);

      if (user == null && !onPublic) return '/login';
      if (user != null && onPublic) return '/app/dashboard';

      if (user != null && loc.startsWith('/app/')) {
        final Set<Privilege> privileges = ref.read(currentPrivilegesProvider);
        if (!PrivilegeMap.canAccess(loc, privileges)) {
          return '/app/dashboard';
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const LandingPage()),
      GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
      GoRoute(
        path: '/forgot-password',
        builder: (_, _) => const ForgotPasswordPage(),
      ),
      ShellRoute(
        builder: (_, _, Widget child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/app/dashboard',
            builder: (_, _) => const DashboardPage(),
          ),
          GoRoute(
            path: '/app/user-accounts',
            builder: (_, _) => const UserAccountsPage(),
          ),
          GoRoute(path: '/app/roles', builder: (_, _) => const RolesPage()),
          GoRoute(
            path: '/app/lost-and-found',
            builder: (_, _) => const LostAndFoundPage(),
          ),
          _appRoute('/app/offenses', 'Offenses'),
          _appRoute('/app/forms', 'Fill Out Forms'),
          _appRoute('/app/request-forms', 'Request Forms'),
          _appRoute('/app/approval', 'Approval Forms'),
          _appRoute('/app/program', 'Guidance Program'),
          _appRoute('/app/students', 'Students'),
          _appRoute('/app/student-records', 'My Records'),
          _appRoute('/app/child-records', 'My Child Records'),
          _appRoute('/app/content', 'Content Management'),
          _appRoute('/app/audit-trail', 'Audit Trail'),
          _appRoute('/app/notifications', 'Notifications'),
        ],
      ),
    ],
  );
});

GoRoute _appRoute(String path, String title) => GoRoute(
  path: path,
  builder: (_, _) => PlaceholderPage(title: title),
);
