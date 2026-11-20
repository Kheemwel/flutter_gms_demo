import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/data/in_memory/student_records_repository.dart';

part 'student_records_notifier.g.dart';

@Riverpod(keepAlive: true)
StudentRecordsRepository studentRecordsRepository(Ref ref) =>
    InMemoryStudentRecordsRepository();

@Riverpod(keepAlive: true)
class StudentInventoriesNotifier extends _$StudentInventoriesNotifier {
  late StudentRecordsRepository _repo;

  @override
  List<StudentIndividualInventory> build() {
    _repo = ref.watch(studentRecordsRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getInventories();
    });
    return const <StudentIndividualInventory>[];
  }

  StudentIndividualInventory? forStudent(String studentId) {
    for (final StudentIndividualInventory inv in state) {
      if (inv.studentId == studentId) return inv;
    }
    return null;
  }

  Future<void> save(StudentIndividualInventory inv) async {
    await _repo.saveInventory(inv);
    final bool exists = state.any((i) => i.id == inv.id);
    state = exists
        ? [for (final i in state) i.id == inv.id ? inv : i]
        : [...state, inv];
  }
}

@Riverpod(keepAlive: true)
class StudentAnecdotalsNotifier extends _$StudentAnecdotalsNotifier {
  late StudentRecordsRepository _repo;

  @override
  List<StudentAnecdotal> build() {
    _repo = ref.watch(studentRecordsRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAnecdotals();
    });
    return const <StudentAnecdotal>[];
  }

  List<StudentAnecdotal> forStudent(String studentId) {
    return state.where((a) => a.studentId == studentId).toList(growable: false)
      ..sort((a, b) => b.observedAt.compareTo(a.observedAt));
  }

  Future<void> add(StudentAnecdotal anecdotal) async {
    await _repo.saveAnecdotal(anecdotal);
    state = [...state, anecdotal];
  }

  Future<void> delete(String id) async {
    await _repo.deleteAnecdotal(id);
    state = state.where((a) => a.id != id).toList(growable: false);
  }

  Future<void> setStudentSignature({
    required String anecdotalId,
    required String dataUrl,
  }) async {
    final StudentAnecdotal? entry = state.where((a) => a.id == anecdotalId).firstOrNull;
    if (entry == null) return;
    final StudentAnecdotal updated = entry.copyWith(studentSignatureDataUrl: dataUrl);
    await _repo.saveAnecdotal(updated);
    state = [for (final a in state) a.id == anecdotalId ? updated : a];
  }

  Future<void> setParentSignature({
    required String anecdotalId,
    required String dataUrl,
  }) async {
    final StudentAnecdotal? entry = state.where((a) => a.id == anecdotalId).firstOrNull;
    if (entry == null) return;
    final StudentAnecdotal updated = entry.copyWith(parentSignatureDataUrl: dataUrl);
    await _repo.saveAnecdotal(updated);
    state = [for (final a in state) a.id == anecdotalId ? updated : a];
  }
}
