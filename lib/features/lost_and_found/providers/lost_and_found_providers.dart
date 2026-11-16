import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_notifier.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:hooks_riverpod/misc.dart';

/// Enum identifying the three item categories on the L&F page.
enum LostFoundTab { found, claimed, expired }

/// Search string shared across the three item tabs.
final StateProvider<String> lostFoundSearchProvider = StateProvider<String>(
  (ref) => '',
);

/// Current item-type filter — null means all types.
final StateProvider<String?> lostFoundTypeFilterProvider =
    StateProvider<String?>((ref) => null);

/// Lookup helpers for the item tables.
final Provider<Map<String, ItemType>> itemTypeByIdProvider =
    Provider<Map<String, ItemType>>((ref) {
      final List<ItemType> types = ref.watch(itemTypesProvider);
      return {for (final t in types) t.id: t};
    });

final Provider<Map<String, ItemTag>> itemTagByIdProvider =
    Provider<Map<String, ItemTag>>((ref) {
      final List<ItemTag> tags = ref.watch(itemTagsProvider);
      return {for (final t in tags) t.id: t};
    });

/// Items filtered by [tab], search, and type filter.
final ProviderFamily<List<LostAndFoundItem>, LostFoundTab> itemsForTabProvider =
    Provider.family<List<LostAndFoundItem>, LostFoundTab>((ref, tab) {
      final List<LostAndFoundItem> all = ref.watch(lostAndFoundItemsProvider);
      final Map<String, ItemTag> tagById = ref.watch(itemTagByIdProvider);
      final String search = ref
          .watch(lostFoundSearchProvider)
          .trim()
          .toLowerCase();
      final String? typeFilter = ref.watch(lostFoundTypeFilterProvider);

      final now = DateTime.now();

      bool inTab(LostAndFoundItem i) {
        final bool expired = i.isExpired(tagById[i.itemTagId], now: now);
        return switch (tab) {
          LostFoundTab.found => !i.isClaimed && !expired,
          LostFoundTab.claimed => i.isClaimed,
          LostFoundTab.expired => !i.isClaimed && expired,
        };
      }

      return all
          .where((i) {
            if (!inTab(i)) return false;
            if (typeFilter != null && i.itemTypeId != typeFilter) return false;
            if (search.isEmpty) return true;
            return i.itemName.toLowerCase().contains(search) ||
                i.locationFound.toLowerCase().contains(search) ||
                i.finderName.toLowerCase().contains(search) ||
                (i.claimerName ?? '').toLowerCase().contains(search);
          })
          .toList(growable: false)
        ..sort((a, b) => a.datetimeFound.compareTo(b.datetimeFound));
    });

/// Counts for tab badges.
final Provider<({int found, int claimed, int expired})>
lostFoundCountsProvider = Provider<({int found, int claimed, int expired})>((
  ref,
) {
  final List<LostAndFoundItem> all = ref.watch(lostAndFoundItemsProvider);
  final Map<String, ItemTag> tagById = ref.watch(itemTagByIdProvider);
  final now = DateTime.now();

  int found = 0, claimed = 0, expired = 0;
  for (final i in all) {
    final bool isExpired = i.isExpired(tagById[i.itemTagId], now: now);
    if (i.isClaimed) {
      claimed++;
    } else if (isExpired) {
      expired++;
    } else {
      found++;
    }
  }
  return (found: found, claimed: claimed, expired: expired);
});

/// Count how many items point at a given type — for delete guard.
final ProviderFamily<int, String> itemCountForTypeProvider =
    Provider.family<int, String>((ref, typeId) {
      return ref
          .watch(lostAndFoundItemsProvider)
          .where((i) => i.itemTypeId == typeId)
          .length;
    });

/// Count how many items point at a given tag — for delete guard.
final ProviderFamily<int, String> itemCountForTagProvider =
    Provider.family<int, String>((ref, tagId) {
      return ref
          .watch(lostAndFoundItemsProvider)
          .where((i) => i.itemTagId == tagId)
          .length;
    });
