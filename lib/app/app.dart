import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'router.dart';
import 'theme.dart';

class GmsDemoApp extends ConsumerWidget {
  const GmsDemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Rebuild the router when auth changes so redirects fire.
    ref.watch(authProvider);
    final GoRouter router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter GMS Demo',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      routerConfig: router,
    );
  }
}
