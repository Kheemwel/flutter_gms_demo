import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_forms.dart';

abstract interface class FormsRepository {
  Future<List<Form>> getAll();
  Future<void> save(Form form);
  Future<void> delete(String id);
}

class InMemoryFormsRepository implements FormsRepository {
  InMemoryFormsRepository() : _store = {for (final f in seedForms()) f.id: f};

  final Map<String, Form> _store;

  @override
  Future<List<Form>> getAll() async => _store.values.toList(growable: false);

  @override
  Future<void> save(Form form) async => _store[form.id] = form;

  @override
  Future<void> delete(String id) async => _store.remove(id);
}
