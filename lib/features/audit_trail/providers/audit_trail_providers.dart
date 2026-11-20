import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/core/models/audit_log.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:hooks_riverpod/legacy.dart';

/// Search string for the audit-trail list.
final StateProvider<String> auditSearchProvider = StateProvider<String>(
  (ref) => '',
);

/// Filtered list, newest first.
final Provider<List<AuditLog>> filteredAuditLogsProvider =
    Provider<List<AuditLog>>((ref) {
      final List<AuditLog> all = ref.watch(auditLogsProvider);
      final String q = ref.watch(auditSearchProvider).trim().toLowerCase();
      if (q.isEmpty) return all;
      return all
          .where((a) {
            return a.action.toLowerCase().contains(q) ||
                a.description.toLowerCase().contains(q) ||
                (a.userFullName ?? '').toLowerCase().contains(q);
          })
          .toList(growable: false);
    });
