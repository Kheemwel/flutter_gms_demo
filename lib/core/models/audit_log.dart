import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_log.freezed.dart';

@freezed
abstract class AuditLog with _$AuditLog {
  const factory AuditLog({
    required String id,
    required String userAccountId,
    required String action,
    required String description,
    required DateTime createdAt,

    /// Resolved at write time so the list doesn't need a lookup.
    /// Null for actions taken by "system" (scheduler, migrations).
    String? userFullName,
  }) = _AuditLog;
}
