import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gms_demo/core/models/offense.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offenses_notifier.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:hooks_riverpod/misc.dart';

/// Search string for the offense tab.
final StateProvider<String> offenseSearchProvider = StateProvider<String>(
  (ref) => '',
);

/// Category filter — null means all.
final StateProvider<String?> offenseCategoryFilterProvider =
    StateProvider<String?>((ref) => null);

/// Level filter — null means all.
final StateProvider<String?> offenseLevelFilterProvider =
    StateProvider<String?>((ref) => null);

/// Lookup maps.
final Provider<Map<String, OffenseCategory>> offenseCategoryByIdProvider =
    Provider<Map<String, OffenseCategory>>((ref) {
      final List<OffenseCategory> all = ref.watch(offenseCategoriesProvider);
      return {for (final c in all) c.id: c};
    });

final Provider<Map<String, OffenseLevel>> offenseLevelByIdProvider =
    Provider<Map<String, OffenseLevel>>((ref) {
      final List<OffenseLevel> all = ref.watch(offenseLevelsProvider);
      return {for (final l in all) l.id: l};
    });

final Provider<Map<String, DisciplinaryAction>> offenseActionByIdProvider =
    Provider<Map<String, DisciplinaryAction>>((ref) {
      final List<DisciplinaryAction> all = ref.watch(
        disciplinaryActionsProvider,
      );
      return {for (final a in all) a.id: a};
    });

/// Offenses filtered + sorted by severity descending (most severe first).
final Provider<List<Offense>>
filteredOffensesProvider = Provider<List<Offense>>((ref) {
  final List<Offense> all = ref.watch(offensesProvider);
  final Map<String, OffenseCategory> cats = ref.watch(
    offenseCategoryByIdProvider,
  );
  final Map<String, OffenseLevel> levels = ref.watch(offenseLevelByIdProvider);
  final String search = ref.watch(offenseSearchProvider).trim().toLowerCase();
  final String? catFilter = ref.watch(offenseCategoryFilterProvider);
  final String? lvlFilter = ref.watch(offenseLevelFilterProvider);

  final List<Offense> filtered = all.where((o) {
    if (catFilter != null && o.categoryId != catFilter) return false;
    if (lvlFilter != null && o.levelId != lvlFilter) return false;
    if (search.isEmpty) return true;
    return o.name.toLowerCase().contains(search) ||
        o.description.toLowerCase().contains(search) ||
        (cats[o.categoryId]?.name.toLowerCase().contains(search) ?? false);
  }).toList();

  filtered.sort((a, b) {
    final int sa = levels[a.levelId]?.severity ?? 0;
    final int sb = levels[b.levelId]?.severity ?? 0;
    if (sa != sb) return sb.compareTo(sa); // higher severity first
    return a.name.compareTo(b.name);
  });
  return filtered;
});

/// Count offenses that reference a category.
final ProviderFamily<int, String> offenseCountForCategoryProvider =
    Provider.family<int, String>((ref, catId) {
      return ref
          .watch(offensesProvider)
          .where((o) => o.categoryId == catId)
          .length;
    });

/// Count offenses that reference a level.
final ProviderFamily<int, String> offenseCountForLevelProvider =
    Provider.family<int, String>((ref, lvlId) {
      return ref
          .watch(offensesProvider)
          .where((o) => o.levelId == lvlId)
          .length;
    });

/// Count offenses that reference a disciplinary action.
final ProviderFamily<int, String> offenseCountForActionProvider =
    Provider.family<int, String>((ref, actionId) {
      return ref
          .watch(offensesProvider)
          .where((o) => o.actionIds.contains(actionId))
          .length;
    });
