import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_gms_demo/core/models/audit_log.dart';

part 'audit_log_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuditLogsNotifier extends _$AuditLogsNotifier {
  @override
  List<AuditLog> build() => const <AuditLog>[];

  void log({
    required String userAccountId,
    required String action,
    required String description,
    String? userFullName,
  }) {
    final entry = AuditLog(
      id: 'audit-${DateTime.now().microsecondsSinceEpoch}',
      userAccountId: userAccountId,
      userFullName: userFullName,
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
