import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/data/in_memory/lost_and_found_repository.dart';

part 'lost_and_found_notifier.g.dart';

@Riverpod(keepAlive: true)
LostAndFoundRepository lostAndFoundRepository(Ref ref) =>
    InMemoryLostAndFoundRepository();

@Riverpod(keepAlive: true)
class LostAndFoundItems extends _$LostAndFoundItems {
  late LostAndFoundRepository _repo;

  @override
  List<LostAndFoundItem> build() {
    _repo = ref.watch(lostAndFoundRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllItems();
    });
    return const <LostAndFoundItem>[];
  }

  LostAndFoundItem? byId(String id) {
    for (final LostAndFoundItem i in state) {
      if (i.id == id) return i;
    }
    return null;
  }

  Future<void> add(LostAndFoundItem item) async {
    await _repo.saveItem(item);
    state = [...state, item];
  }

  Future<void> update(LostAndFoundItem updated) async {
    await _repo.saveItem(updated);
    state = [for (final i in state) i.id == updated.id ? updated : i];
  }

  Future<void> delete(String id) async {
    await _repo.deleteItem(id);
    state = state.where((i) => i.id != id).toList(growable: false);
  }

  Future<void> claim({
    required String id,
    required DateTime claimedDatetime,
    required String claimerName,
    required String claimerContact,
    required String claimerEmail,
    required String claimerAddress,
  }) async {
    final LostAndFoundItem? item = byId(id);
    if (item == null) return;
    await update(
      item.copyWith(
        isClaimed: true,
        claimedDatetime: claimedDatetime,
        claimerName: claimerName,
        claimerContact: claimerContact,
        claimerEmail: claimerEmail,
        claimerAddress: claimerAddress,
      ),
    );
  }

  Future<void> unclaim(String id) async {
    final LostAndFoundItem? item = byId(id);
    if (item == null) return;
    await update(
      item.copyWith(
        isClaimed: false,
        claimedDatetime: null,
        claimerName: null,
        claimerContact: null,
        claimerEmail: null,
        claimerAddress: null,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
class ItemTypes extends _$ItemTypes {
  late LostAndFoundRepository _repo;

  @override
  List<ItemType> build() {
    _repo = ref.watch(lostAndFoundRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllTypes();
    });
    return const <ItemType>[];
  }

  ItemType? byId(String id) {
    for (final ItemType t in state) {
      if (t.id == id) return t;
    }
    return null;
  }

  Future<void> add(ItemType type) async {
    await _repo.saveType(type);
    state = [...state, type];
  }

  Future<void> update(ItemType updated) async {
    await _repo.saveType(updated);
    state = [for (final t in state) t.id == updated.id ? updated : t];
  }

  Future<void> delete(String id) async {
    await _repo.deleteType(id);
    state = state.where((t) => t.id != id).toList(growable: false);
  }
}

@Riverpod(keepAlive: true)
class ItemTags extends _$ItemTags {
  late LostAndFoundRepository _repo;

  @override
  List<ItemTag> build() {
    _repo = ref.watch(lostAndFoundRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllTags();
    });
    return const <ItemTag>[];
  }

  ItemTag? byId(String id) {
    for (final ItemTag t in state) {
      if (t.id == id) return t;
    }
    return null;
  }

  Future<void> add(ItemTag tag) async {
    await _repo.saveTag(tag);
    state = [...state, tag];
  }

  Future<void> update(ItemTag updated) async {
    await _repo.saveTag(updated);
    state = [for (final t in state) t.id == updated.id ? updated : t];
  }

  Future<void> delete(String id) async {
    await _repo.deleteTag(id);
    state = state.where((t) => t.id != id).toList(growable: false);
  }
}
