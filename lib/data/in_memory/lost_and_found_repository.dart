import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_lost_and_found.dart';

abstract interface class LostAndFoundRepository {
  Future<List<LostAndFoundItem>> getAllItems();
  Future<void> saveItem(LostAndFoundItem item);
  Future<void> deleteItem(String id);

  Future<List<ItemType>> getAllTypes();
  Future<void> saveType(ItemType type);
  Future<void> deleteType(String id);

  Future<List<ItemTag>> getAllTags();
  Future<void> saveTag(ItemTag tag);
  Future<void> deleteTag(String id);
}

class InMemoryLostAndFoundRepository implements LostAndFoundRepository {
  InMemoryLostAndFoundRepository()
    : _items = {for (final i in seedLostAndFoundItems()) i.id: i},
      _types = {for (final t in seedItemTypes) t.id: t},
      _tags = {for (final t in seedItemTags) t.id: t};

  final Map<String, LostAndFoundItem> _items;
  final Map<String, ItemType> _types;
  final Map<String, ItemTag> _tags;

  @override
  Future<List<LostAndFoundItem>> getAllItems() async =>
      _items.values.toList(growable: false);

  @override
  Future<void> saveItem(LostAndFoundItem item) async => _items[item.id] = item;

  @override
  Future<void> deleteItem(String id) async => _items.remove(id);

  @override
  Future<List<ItemType>> getAllTypes() async =>
      _types.values.toList(growable: false);

  @override
  Future<void> saveType(ItemType type) async => _types[type.id] = type;

  @override
  Future<void> deleteType(String id) async => _types.remove(id);

  @override
  Future<List<ItemTag>> getAllTags() async =>
      _tags.values.toList(growable: false);

  @override
  Future<void> saveTag(ItemTag tag) async => _tags[tag.id] = tag;

  @override
  Future<void> deleteTag(String id) async => _tags.remove(id);
}
