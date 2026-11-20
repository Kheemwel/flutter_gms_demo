import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/features/audit_trail/presentation/audit_trail_page.dart';
import 'package:flutter_gms_demo/features/content_management/presentation/content_management_page.dart';
import 'package:flutter_gms_demo/features/forms/presentation/approval_forms_page.dart';
import 'package:flutter_gms_demo/features/forms/presentation/forms_page.dart';
import 'package:flutter_gms_demo/features/forms/presentation/request_forms_page.dart';
import 'package:flutter_gms_demo/features/guidance_program/presentation/guidance_program_page.dart';
import 'package:flutter_gms_demo/features/home/presentation/dashboard_page.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/lost_and_found_page.dart';
import 'package:flutter_gms_demo/features/notifications/presentation/notifications_page.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/offenses_page.dart';
import 'package:flutter_gms_demo/features/student_records/presentation/my_child_records_page.dart';
import 'package:flutter_gms_demo/features/student_records/presentation/my_records_page.dart';
import 'package:flutter_gms_demo/features/student_records/presentation/students_page.dart';
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
          GoRoute(
            path: '/app/offenses',
            builder: (_, _) => const OffensesPage(),
          ),
          GoRoute(path: '/app/forms', builder: (_, _) => const FormsPage()),
          GoRoute(
            path: '/app/request-forms',
            builder: (_, _) => const RequestFormsPage(),
          ),
          GoRoute(
            path: '/app/approval',
            builder: (_, _) => const ApprovalFormsPage(),
          ),
          GoRoute(
            path: '/app/program',
            builder: (_, _) => const GuidanceProgramPage(),
          ),
          GoRoute(
            path: '/app/students',
            builder: (_, _) => const StudentsPage(),
          ),
          GoRoute(
            path: '/app/student-records',
            builder: (_, _) => const MyRecordsPage(),
          ),
          GoRoute(
            path: '/app/child-records',
            builder: (_, _) => const MyChildRecordsPage(),
          ),
          GoRoute(
            path: '/app/content',
            builder: (_, _) => const ContentManagementPage(),
          ),
          GoRoute(
            path: '/app/audit-trail',
            builder: (_, _) => const AuditTrailPage(),
          ),
          GoRoute(
            path: '/app/notifications',
            builder: (_, _) => const NotificationsPage(),
          ),
        ],
      ),
    ],
  );
});
