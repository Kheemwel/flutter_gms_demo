import 'package:flutter_gms_demo/core/models/lost_and_found.dart';

/// Taxonomy. Kept minimal — the point is to demo the CRUD screens.
final List<ItemType> seedItemTypes = const [
  ItemType(id: 'type-phone', itemType: 'Phone'),
  ItemType(id: 'type-wallet', itemType: 'Wallet'),
  ItemType(id: 'type-id', itemType: 'ID / Card'),
  ItemType(id: 'type-bag', itemType: 'Bag'),
  ItemType(id: 'type-other', itemType: 'Other'),
];

final List<ItemTag> seedItemTags = const [
  ItemTag(id: 'tag-high', priorityTag: 'High value', daysExpired: 90),
  ItemTag(id: 'tag-normal', priorityTag: 'Normal', daysExpired: 30),
  ItemTag(id: 'tag-low', priorityTag: 'Low priority', daysExpired: 14),
];

/// Now-anchored seed items so expiry is always meaningful on first run.
List<LostAndFoundItem> seedLostAndFoundItems() {
  final DateTime now = DateTime.now();

  return [
    LostAndFoundItem(
      id: 'item-1',
      itemName: 'Black iPhone 13',
      itemTypeId: 'type-phone',
      itemTagId: 'tag-high',
      description: 'Cracked corner, purple case.',
      datetimeFound: now.subtract(const Duration(days: 3)),
      finderName: 'Tina Teacher',
      locationFound: 'Library, 2nd floor',
      isClaimed: false,
    ),
    LostAndFoundItem(
      id: 'item-2',
      itemName: 'Brown leather wallet',
      itemTypeId: 'type-wallet',
      itemTagId: 'tag-high',
      description: 'Contains an ID for a "S. Student".',
      datetimeFound: now.subtract(const Duration(days: 10)),
      finderName: 'Grace Guidance',
      locationFound: 'Cafeteria',
      isClaimed: false,
    ),
    LostAndFoundItem(
      id: 'item-3',
      itemName: 'Blue backpack',
      itemTypeId: 'type-bag',
      itemTagId: 'tag-normal',
      description: 'Has PE uniform inside.',
      datetimeFound: now.subtract(const Duration(days: 5)),
      finderName: 'Ada Admin',
      locationFound: 'Gym',
      isClaimed: true,
      claimedDatetime: now.subtract(const Duration(days: 1)),
      claimerName: 'Alex Student',
      claimerContact: '09171234567',
      claimerEmail: 'student2@gms.demo',
      claimerAddress: 'Mabini St., Brgy. Poblacion',
    ),
    LostAndFoundItem(
      id: 'item-4',
      itemName: 'Student ID',
      itemTypeId: 'type-id',
      itemTagId: 'tag-normal',
      description: 'Name visible: S. Student.',
      datetimeFound: now.subtract(const Duration(days: 40)),
      finderName: 'Tina Teacher',
      locationFound: 'Room 204',
      isClaimed: false,
      // Will be expired because 40 > tag.daysExpired (30)
    ),
    LostAndFoundItem(
      id: 'item-5',
      itemName: 'Umbrella',
      itemTypeId: 'type-other',
      itemTagId: 'tag-low',
      description: 'Blue folding umbrella.',
      datetimeFound: now.subtract(const Duration(days: 20)),
      finderName: 'Junior Principal',
      locationFound: 'Entrance',
      isClaimed: false,
      // Expired: 20 > 14
    ),
  ];
}
