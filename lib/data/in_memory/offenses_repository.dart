import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_offenses.dart';

abstract interface class OffensesRepository {
  Future<List<Offense>> getAllOffenses();
  Future<void> saveOffense(Offense offense);
  Future<void> deleteOffense(String id);

  Future<List<OffenseCategory>> getAllCategories();
  Future<void> saveCategory(OffenseCategory category);
  Future<void> deleteCategory(String id);

  Future<List<OffenseLevel>> getAllLevels();
  Future<void> saveLevel(OffenseLevel level);
  Future<void> deleteLevel(String id);

  Future<List<DisciplinaryAction>> getAllActions();
  Future<void> saveAction(DisciplinaryAction action);
  Future<void> deleteAction(String id);
}

class InMemoryOffensesRepository implements OffensesRepository {
  InMemoryOffensesRepository()
    : _offenses = {for (final o in seedOffenses) o.id: o},
      _categories = {for (final c in seedOffenseCategories) c.id: c},
      _levels = {for (final l in seedOffenseLevels) l.id: l},
      _actions = {for (final a in seedDisciplinaryActions) a.id: a};

  final Map<String, Offense> _offenses;
  final Map<String, OffenseCategory> _categories;
  final Map<String, OffenseLevel> _levels;
  final Map<String, DisciplinaryAction> _actions;

  @override
  Future<List<Offense>> getAllOffenses() async =>
      _offenses.values.toList(growable: false);
  @override
  Future<void> saveOffense(Offense o) async => _offenses[o.id] = o;
  @override
  Future<void> deleteOffense(String id) async => _offenses.remove(id);

  @override
  Future<List<OffenseCategory>> getAllCategories() async =>
      _categories.values.toList(growable: false);
  @override
  Future<void> saveCategory(OffenseCategory c) async => _categories[c.id] = c;
  @override
  Future<void> deleteCategory(String id) async => _categories.remove(id);

  @override
  Future<List<OffenseLevel>> getAllLevels() async =>
      _levels.values.toList(growable: false);
  @override
  Future<void> saveLevel(OffenseLevel l) async => _levels[l.id] = l;
  @override
  Future<void> deleteLevel(String id) async => _levels.remove(id);

  @override
  Future<List<DisciplinaryAction>> getAllActions() async =>
      _actions.values.toList(growable: false);
  @override
  Future<void> saveAction(DisciplinaryAction a) async => _actions[a.id] = a;
  @override
  Future<void> deleteAction(String id) async => _actions.remove(id);
}
