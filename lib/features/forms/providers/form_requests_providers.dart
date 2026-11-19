import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_notifier.dart';
import 'package:hooks_riverpod/misc.dart';

/// Requests I've made (teacher-facing).
final Provider<List<FormRequest>> myRequestsProvider =
    Provider<List<FormRequest>>((ref) {
      final UserAccount? me = ref.watch(authProvider);
      final List<FormRequest> all = ref.watch(formRequestsProvider);
      if (me == null) return const [];
      return all
          .where((r) => r.requestedByUserId == me.id)
          .toList(growable: false)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });

/// All requests in a given status (guidance-facing).
final ProviderFamily<List<FormRequest>, FormRequestStatus>
requestsByStatusProvider =
    Provider.family<List<FormRequest>, FormRequestStatus>((ref, status) {
      final List<FormRequest> all = ref.watch(formRequestsProvider);
      return all.where((r) => r.status == status).toList(growable: false)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
