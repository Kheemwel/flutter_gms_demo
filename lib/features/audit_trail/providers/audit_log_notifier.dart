import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/audit_log.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';

part 'audit_log_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuditLogsNotifier extends _$AuditLogsNotifier {
  @override
  List<AuditLog> build() => const <AuditLog>[];

  void log({
    required String userAccountId,
    required String action,
    required String description,
  }) {
    final UserAccount? me = ref.read(authProvider);
    final entry = AuditLog(
      id: 'audit-${DateTime.now().microsecondsSinceEpoch}',
      userAccountId: userAccountId,
      userFullName: userAccountId == me?.id ? me?.fullName : null,
      action: action,
      description: description,
      createdAt: DateTime.now(),
    );
    state = [entry, ...state];
  }

  void delete(String id) {
    state = state.where((a) => a.id != id).toList(growable: false);
  }

  void clearAll() => state = const <AuditLog>[];
}
