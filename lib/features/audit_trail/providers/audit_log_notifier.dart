import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audit_log_notifier.freezed.dart';
part 'audit_log_notifier.g.dart';

@freezed
abstract class AuditLog with _$AuditLog {
  const factory AuditLog({
    required String id,
    required String userAccountId,
    required String action,
    required String description,
    required DateTime createdAt,
  }) = _AuditLog;
}

@Riverpod(keepAlive: true)
class AuditLogs extends _$AuditLogs {
  @override
  List<AuditLog> build() => const <AuditLog>[];

  void record({
    required String userAccountId,
    required String action,
    required String description,
  }) {
    state = [
      AuditLog(
        id: 'audit-${DateTime.now().microsecondsSinceEpoch}',
        userAccountId: userAccountId,
        action: action,
        description: description,
        createdAt: DateTime.now(),
      ),
      ...state,
    ];
  }

  void delete(String id) {
    state = state.where((a) => a.id != id).toList(growable: false);
  }
}
