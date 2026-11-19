import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_form_requests.dart';

abstract interface class FormRequestsRepository {
  Future<List<FormRequest>> getAll();
  Future<void> save(FormRequest request);
  Future<void> delete(String id);
}

class InMemoryFormRequestsRepository implements FormRequestsRepository {
  InMemoryFormRequestsRepository()
    : _store = {for (final r in seedFormRequests()) r.id: r};

  final Map<String, FormRequest> _store;

  @override
  Future<List<FormRequest>> getAll() async =>
      _store.values.toList(growable: false);

  @override
  Future<void> save(FormRequest request) async => _store[request.id] = request;

  @override
  Future<void> delete(String id) async => _store.remove(id);
}
