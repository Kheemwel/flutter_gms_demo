import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/data/in_memory/offenses_repository.dart';

part 'offenses_notifier.g.dart';

@Riverpod(keepAlive: true)
OffensesRepository offensesRepository(Ref ref) => InMemoryOffensesRepository();

@Riverpod(keepAlive: true)
class Offenses extends _$Offenses {
  late OffensesRepository _repo;

  @override
  List<Offense> build() {
    _repo = ref.watch(offensesRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllOffenses();
    });
    return const <Offense>[];
  }

  Offense? byId(String id) {
    for (final Offense o in state) {
      if (o.id == id) return o;
    }
    return null;
  }

  Future<void> add(Offense o) async {
    await _repo.saveOffense(o);
    state = [...state, o];
  }

  Future<void> update(Offense updated) async {
    await _repo.saveOffense(updated);
    state = [for (final o in state) o.id == updated.id ? updated : o];
  }

  Future<void> delete(String id) async {
    await _repo.deleteOffense(id);
    state = state.where((o) => o.id != id).toList(growable: false);
  }
}

@Riverpod(keepAlive: true)
class OffenseCategories extends _$OffenseCategories {
  late OffensesRepository _repo;

  @override
  List<OffenseCategory> build() {
    _repo = ref.watch(offensesRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllCategories();
    });
    return const <OffenseCategory>[];
  }

  OffenseCategory? byId(String id) {
    for (final OffenseCategory c in state) {
      if (c.id == id) return c;
    }
    return null;
  }

  Future<void> add(OffenseCategory c) async {
    await _repo.saveCategory(c);
    state = [...state, c];
  }

  Future<void> update(OffenseCategory updated) async {
    await _repo.saveCategory(updated);
    state = [for (final c in state) c.id == updated.id ? updated : c];
  }

  Future<void> delete(String id) async {
    await _repo.deleteCategory(id);
    state = state.where((c) => c.id != id).toList(growable: false);
  }
}

@Riverpod(keepAlive: true)
class OffenseLevels extends _$OffenseLevels {
  late OffensesRepository _repo;

  @override
  List<OffenseLevel> build() {
    _repo = ref.watch(offensesRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllLevels();
    });
    return const <OffenseLevel>[];
  }

  OffenseLevel? byId(String id) {
    for (final OffenseLevel l in state) {
      if (l.id == id) return l;
    }
    return null;
  }

  Future<void> add(OffenseLevel l) async {
    await _repo.saveLevel(l);
    state = [...state, l];
  }

  Future<void> update(OffenseLevel updated) async {
    await _repo.saveLevel(updated);
    state = [for (final l in state) l.id == updated.id ? updated : l];
  }

  Future<void> delete(String id) async {
    await _repo.deleteLevel(id);
    state = state.where((l) => l.id != id).toList(growable: false);
  }
}

@Riverpod(keepAlive: true)
class DisciplinaryActions extends _$DisciplinaryActions {
  late OffensesRepository _repo;

  @override
  List<DisciplinaryAction> build() {
    _repo = ref.watch(offensesRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllActions();
    });
    return const <DisciplinaryAction>[];
  }

  DisciplinaryAction? byId(String id) {
    for (final DisciplinaryAction a in state) {
      if (a.id == id) return a;
    }
    return null;
  }

  Future<void> add(DisciplinaryAction a) async {
    await _repo.saveAction(a);
    state = [...state, a];
  }

  Future<void> update(DisciplinaryAction updated) async {
    await _repo.saveAction(updated);
    state = [for (final a in state) a.id == updated.id ? updated : a];
  }

  Future<void> delete(String id) async {
    await _repo.deleteAction(id);
    state = state.where((a) => a.id != id).toList(growable: false);
  }
}
