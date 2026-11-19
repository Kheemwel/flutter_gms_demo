import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/data/in_memory/form_requests_repository.dart';

part 'form_requests_notifier.g.dart';

@Riverpod(keepAlive: true)
FormRequestsRepository formRequestsRepository(Ref ref) =>
    InMemoryFormRequestsRepository();

@Riverpod(keepAlive: true)
class FormRequestsNotifier extends _$FormRequestsNotifier {
  late FormRequestsRepository _repo;

  @override
  List<FormRequest> build() {
    _repo = ref.watch(formRequestsRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAll();
    });
    return const <FormRequest>[];
  }

  FormRequest? byId(String id) {
    for (final FormRequest r in state) {
      if (r.id == id) return r;
    }
    return null;
  }

  Future<void> add(FormRequest request) async {
    await _repo.save(request);
    state = [...state, request];
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    state = state.where((r) => r.id != id).toList(growable: false);
  }

  /// Approve a request. Mutates status, stores the spawned form's ID.
  /// The actual Form is created by the caller (widget/notifier layer)
  /// because it needs user-repo reads, which we don't want to couple
  /// into this notifier.
  Future<void> markApproved({
    required String requestId,
    required String resultingFormId,
    required String approvedByUserId,
  }) async {
    final FormRequest? r = byId(requestId);
    if (r == null) return;
    if (r.requestedByUserId == approvedByUserId) {
      throw StateError('A request cannot be approved by its own author.');
    }
    final FormRequest updated = r.copyWith(
      status: FormRequestStatus.approved,
      resultingFormId: resultingFormId,
    );
    await _repo.save(updated);
    state = [for (final x in state) x.id == updated.id ? updated : x];
  }

  Future<void> markDisapproved({
    required String requestId,
    required String reason,
    required String approvedByUserId,
  }) async {
    final FormRequest? r = byId(requestId);
    if (r == null) return;
    if (r.requestedByUserId == approvedByUserId) {
      throw StateError('A request cannot be approved by its own author.');
    }
    final FormRequest updated = r.copyWith(
      status: FormRequestStatus.disapproved,
      disapprovalReason: reason.trim(),
    );
    await _repo.save(updated);
    state = [for (final x in state) x.id == updated.id ? updated : x];
  }
}
