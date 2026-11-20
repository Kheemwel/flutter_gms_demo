import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_student_records.dart';

abstract interface class StudentRecordsRepository {
  Future<List<StudentIndividualInventory>> getInventories();
  Future<void> saveInventory(StudentIndividualInventory inventory);

  Future<List<StudentAnecdotal>> getAnecdotals();
  Future<void> saveAnecdotal(StudentAnecdotal anecdotal);
  Future<void> deleteAnecdotal(String id);
}

class InMemoryStudentRecordsRepository implements StudentRecordsRepository {
  InMemoryStudentRecordsRepository()
    : _inventories = {for (final i in seedStudentInventories()) i.id: i},
      _anecdotals = {for (final a in seedStudentAnecdotals()) a.id: a};

  final Map<String, StudentIndividualInventory> _inventories;
  final Map<String, StudentAnecdotal> _anecdotals;

  @override
  Future<List<StudentIndividualInventory>> getInventories() async =>
      _inventories.values.toList(growable: false);

  @override
  Future<void> saveInventory(StudentIndividualInventory inventory) async =>
      _inventories[inventory.id] = inventory;

  @override
  Future<List<StudentAnecdotal>> getAnecdotals() async =>
      _anecdotals.values.toList(growable: false);

  @override
  Future<void> saveAnecdotal(StudentAnecdotal anecdotal) async =>
      _anecdotals[anecdotal.id] = anecdotal;

  @override
  Future<void> deleteAnecdotal(String id) async => _anecdotals.remove(id);
}
