import 'package:freezed_annotation/freezed_annotation.dart';

part 'lost_and_found.freezed.dart';

@freezed
abstract class ItemType with _$ItemType {
  const factory ItemType({required String id, required String itemType}) =
      _ItemType;
}

@freezed
abstract class ItemTag with _$ItemTag {
  const factory ItemTag({
    required String id,
    required String priorityTag,
    required int daysExpired,
  }) = _ItemTag;
}

@freezed
abstract class LostAndFoundItem with _$LostAndFoundItem {
  const factory LostAndFoundItem({
    required String id,
    required String itemName,
    required String itemTypeId,
    required String itemTagId,
    required String description,
    required DateTime datetimeFound,
    required String finderName,
    required String locationFound,
    required bool isClaimed,

    // Claim fields (non-null when isClaimed is true)
    DateTime? claimedDatetime,
    String? claimerName,
    String? claimerContact,
    String? claimerEmail,
    String? claimerAddress,
  }) = _LostAndFoundItem;

  const LostAndFoundItem._();

  /// Derived expiry: item expires `tag.daysExpired` days after
  /// `datetimeFound`. Returns `false` if tag is null (defensive).
  bool isExpired(ItemTag? tag, {DateTime? now}) {
    if (tag == null) return false;
    final DateTime expiry = datetimeFound.add(Duration(days: tag.daysExpired));
    return (now ?? DateTime.now()).isAfter(expiry);
  }

  DateTime? expirationDate(ItemTag? tag) =>
      tag == null ? null : datetimeFound.add(Duration(days: tag.daysExpired));
}
