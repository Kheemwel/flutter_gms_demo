// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lost_and_found.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ItemType {

 String get id; String get itemType;
/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemTypeCopyWith<ItemType> get copyWith => _$ItemTypeCopyWithImpl<ItemType>(this as ItemType, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ItemType;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemType&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.itemType, _this.itemType) || other.itemType == _this.itemType));
}


@override
int get hashCode {
  final _this = this as ItemType;
  return Object.hash(runtimeType,_this.id,_this.itemType);
}

@override
String toString() {
  final _this = this as ItemType;
  return 'ItemType(id: ${_this.id}, itemType: ${_this.itemType})';
}


}

/// @nodoc
abstract mixin class $ItemTypeCopyWith<$Res>  {
  factory $ItemTypeCopyWith(ItemType value, $Res Function(ItemType) _then) = _$ItemTypeCopyWithImpl;
@useResult
$Res call({
 String id, String itemType
});




}
/// @nodoc
class _$ItemTypeCopyWithImpl<$Res>
    implements $ItemTypeCopyWith<$Res> {
  _$ItemTypeCopyWithImpl(this._self, this._then);

  final ItemType _self;
  final $Res Function(ItemType) _then;

/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemType = null,}) {
  return _then(ItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemType].
extension ItemTypePatterns on ItemType {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemType() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemType value)  $default,){
final _that = this;
switch (_that) {
case _ItemType():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemType value)?  $default,){
final _that = this;
switch (_that) {
case _ItemType() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String itemType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemType() when $default != null:
return $default(_that.id,_that.itemType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String itemType)  $default,) {final _that = this;
switch (_that) {
case _ItemType():
return $default(_that.id,_that.itemType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String itemType)?  $default,) {final _that = this;
switch (_that) {
case _ItemType() when $default != null:
return $default(_that.id,_that.itemType);case _:
  return null;

}
}

}

/// @nodoc


class _ItemType implements ItemType {
  const _ItemType({required this.id, required this.itemType});
  

@override final  String id;
@override final  String itemType;

/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemTypeCopyWith<_ItemType> get copyWith => __$ItemTypeCopyWithImpl<_ItemType>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemType&&(identical(other.id, id) || other.id == id)&&(identical(other.itemType, itemType) || other.itemType == itemType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,itemType);
}

@override
String toString() {
    return 'ItemType(id: $id, itemType: $itemType)';
}


}

/// @nodoc
abstract mixin class _$ItemTypeCopyWith<$Res> implements $ItemTypeCopyWith<$Res> {
  factory _$ItemTypeCopyWith(_ItemType value, $Res Function(_ItemType) _then) = __$ItemTypeCopyWithImpl;
@override @useResult
$Res call({
 String id, String itemType
});




}
/// @nodoc
class __$ItemTypeCopyWithImpl<$Res>
    implements _$ItemTypeCopyWith<$Res> {
  __$ItemTypeCopyWithImpl(this._self, this._then);

  final _ItemType _self;
  final $Res Function(_ItemType) _then;

/// Create a copy of ItemType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemType = null,}) {
  return _then(_ItemType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ItemTag {

 String get id; String get priorityTag; int get daysExpired;
/// Create a copy of ItemTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemTagCopyWith<ItemTag> get copyWith => _$ItemTagCopyWithImpl<ItemTag>(this as ItemTag, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ItemTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemTag&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.priorityTag, _this.priorityTag) || other.priorityTag == _this.priorityTag)&&(identical(other.daysExpired, _this.daysExpired) || other.daysExpired == _this.daysExpired));
}


@override
int get hashCode {
  final _this = this as ItemTag;
  return Object.hash(runtimeType,_this.id,_this.priorityTag,_this.daysExpired);
}

@override
String toString() {
  final _this = this as ItemTag;
  return 'ItemTag(id: ${_this.id}, priorityTag: ${_this.priorityTag}, daysExpired: ${_this.daysExpired})';
}


}

/// @nodoc
abstract mixin class $ItemTagCopyWith<$Res>  {
  factory $ItemTagCopyWith(ItemTag value, $Res Function(ItemTag) _then) = _$ItemTagCopyWithImpl;
@useResult
$Res call({
 String id, String priorityTag, int daysExpired
});




}
/// @nodoc
class _$ItemTagCopyWithImpl<$Res>
    implements $ItemTagCopyWith<$Res> {
  _$ItemTagCopyWithImpl(this._self, this._then);

  final ItemTag _self;
  final $Res Function(ItemTag) _then;

/// Create a copy of ItemTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? priorityTag = null,Object? daysExpired = null,}) {
  return _then(ItemTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,priorityTag: null == priorityTag ? _self.priorityTag : priorityTag // ignore: cast_nullable_to_non_nullable
as String,daysExpired: null == daysExpired ? _self.daysExpired : daysExpired // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemTag].
extension ItemTagPatterns on ItemTag {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemTag() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemTag value)  $default,){
final _that = this;
switch (_that) {
case _ItemTag():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemTag value)?  $default,){
final _that = this;
switch (_that) {
case _ItemTag() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String priorityTag,  int daysExpired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemTag() when $default != null:
return $default(_that.id,_that.priorityTag,_that.daysExpired);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String priorityTag,  int daysExpired)  $default,) {final _that = this;
switch (_that) {
case _ItemTag():
return $default(_that.id,_that.priorityTag,_that.daysExpired);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String priorityTag,  int daysExpired)?  $default,) {final _that = this;
switch (_that) {
case _ItemTag() when $default != null:
return $default(_that.id,_that.priorityTag,_that.daysExpired);case _:
  return null;

}
}

}

/// @nodoc


class _ItemTag implements ItemTag {
  const _ItemTag({required this.id, required this.priorityTag, required this.daysExpired});
  

@override final  String id;
@override final  String priorityTag;
@override final  int daysExpired;

/// Create a copy of ItemTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemTagCopyWith<_ItemTag> get copyWith => __$ItemTagCopyWithImpl<_ItemTag>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemTag&&(identical(other.id, id) || other.id == id)&&(identical(other.priorityTag, priorityTag) || other.priorityTag == priorityTag)&&(identical(other.daysExpired, daysExpired) || other.daysExpired == daysExpired));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,priorityTag,daysExpired);
}

@override
String toString() {
    return 'ItemTag(id: $id, priorityTag: $priorityTag, daysExpired: $daysExpired)';
}


}

/// @nodoc
abstract mixin class _$ItemTagCopyWith<$Res> implements $ItemTagCopyWith<$Res> {
  factory _$ItemTagCopyWith(_ItemTag value, $Res Function(_ItemTag) _then) = __$ItemTagCopyWithImpl;
@override @useResult
$Res call({
 String id, String priorityTag, int daysExpired
});




}
/// @nodoc
class __$ItemTagCopyWithImpl<$Res>
    implements _$ItemTagCopyWith<$Res> {
  __$ItemTagCopyWithImpl(this._self, this._then);

  final _ItemTag _self;
  final $Res Function(_ItemTag) _then;

/// Create a copy of ItemTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? priorityTag = null,Object? daysExpired = null,}) {
  return _then(_ItemTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,priorityTag: null == priorityTag ? _self.priorityTag : priorityTag // ignore: cast_nullable_to_non_nullable
as String,daysExpired: null == daysExpired ? _self.daysExpired : daysExpired // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LostAndFoundItem {

 String get id; String get itemName; String get itemTypeId; String get itemTagId; String get description; DateTime get datetimeFound; String get finderName; String get locationFound; bool get isClaimed; DateTime? get claimedDatetime; String? get claimerName; String? get claimerContact; String? get claimerEmail; String? get claimerAddress;
/// Create a copy of LostAndFoundItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LostAndFoundItemCopyWith<LostAndFoundItem> get copyWith => _$LostAndFoundItemCopyWithImpl<LostAndFoundItem>(this as LostAndFoundItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LostAndFoundItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LostAndFoundItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.itemName, _this.itemName) || other.itemName == _this.itemName)&&(identical(other.itemTypeId, _this.itemTypeId) || other.itemTypeId == _this.itemTypeId)&&(identical(other.itemTagId, _this.itemTagId) || other.itemTagId == _this.itemTagId)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.datetimeFound, _this.datetimeFound) || other.datetimeFound == _this.datetimeFound)&&(identical(other.finderName, _this.finderName) || other.finderName == _this.finderName)&&(identical(other.locationFound, _this.locationFound) || other.locationFound == _this.locationFound)&&(identical(other.isClaimed, _this.isClaimed) || other.isClaimed == _this.isClaimed)&&(identical(other.claimedDatetime, _this.claimedDatetime) || other.claimedDatetime == _this.claimedDatetime)&&(identical(other.claimerName, _this.claimerName) || other.claimerName == _this.claimerName)&&(identical(other.claimerContact, _this.claimerContact) || other.claimerContact == _this.claimerContact)&&(identical(other.claimerEmail, _this.claimerEmail) || other.claimerEmail == _this.claimerEmail)&&(identical(other.claimerAddress, _this.claimerAddress) || other.claimerAddress == _this.claimerAddress));
}


@override
int get hashCode {
  final _this = this as LostAndFoundItem;
  return Object.hash(runtimeType,_this.id,_this.itemName,_this.itemTypeId,_this.itemTagId,_this.description,_this.datetimeFound,_this.finderName,_this.locationFound,_this.isClaimed,_this.claimedDatetime,_this.claimerName,_this.claimerContact,_this.claimerEmail,_this.claimerAddress);
}

@override
String toString() {
  final _this = this as LostAndFoundItem;
  return 'LostAndFoundItem(id: ${_this.id}, itemName: ${_this.itemName}, itemTypeId: ${_this.itemTypeId}, itemTagId: ${_this.itemTagId}, description: ${_this.description}, datetimeFound: ${_this.datetimeFound}, finderName: ${_this.finderName}, locationFound: ${_this.locationFound}, isClaimed: ${_this.isClaimed}, claimedDatetime: ${_this.claimedDatetime}, claimerName: ${_this.claimerName}, claimerContact: ${_this.claimerContact}, claimerEmail: ${_this.claimerEmail}, claimerAddress: ${_this.claimerAddress})';
}


}

/// @nodoc
abstract mixin class $LostAndFoundItemCopyWith<$Res>  {
  factory $LostAndFoundItemCopyWith(LostAndFoundItem value, $Res Function(LostAndFoundItem) _then) = _$LostAndFoundItemCopyWithImpl;
@useResult
$Res call({
 String id, String itemName, String itemTypeId, String itemTagId, String description, DateTime datetimeFound, String finderName, String locationFound, bool isClaimed, DateTime? claimedDatetime, String? claimerName, String? claimerContact, String? claimerEmail, String? claimerAddress
});




}
/// @nodoc
class _$LostAndFoundItemCopyWithImpl<$Res>
    implements $LostAndFoundItemCopyWith<$Res> {
  _$LostAndFoundItemCopyWithImpl(this._self, this._then);

  final LostAndFoundItem _self;
  final $Res Function(LostAndFoundItem) _then;

/// Create a copy of LostAndFoundItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemName = null,Object? itemTypeId = null,Object? itemTagId = null,Object? description = null,Object? datetimeFound = null,Object? finderName = null,Object? locationFound = null,Object? isClaimed = null,Object? claimedDatetime = freezed,Object? claimerName = freezed,Object? claimerContact = freezed,Object? claimerEmail = freezed,Object? claimerAddress = freezed,}) {
  return _then(LostAndFoundItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,itemTypeId: null == itemTypeId ? _self.itemTypeId : itemTypeId // ignore: cast_nullable_to_non_nullable
as String,itemTagId: null == itemTagId ? _self.itemTagId : itemTagId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,datetimeFound: null == datetimeFound ? _self.datetimeFound : datetimeFound // ignore: cast_nullable_to_non_nullable
as DateTime,finderName: null == finderName ? _self.finderName : finderName // ignore: cast_nullable_to_non_nullable
as String,locationFound: null == locationFound ? _self.locationFound : locationFound // ignore: cast_nullable_to_non_nullable
as String,isClaimed: null == isClaimed ? _self.isClaimed : isClaimed // ignore: cast_nullable_to_non_nullable
as bool,claimedDatetime: freezed == claimedDatetime ? _self.claimedDatetime : claimedDatetime // ignore: cast_nullable_to_non_nullable
as DateTime?,claimerName: freezed == claimerName ? _self.claimerName : claimerName // ignore: cast_nullable_to_non_nullable
as String?,claimerContact: freezed == claimerContact ? _self.claimerContact : claimerContact // ignore: cast_nullable_to_non_nullable
as String?,claimerEmail: freezed == claimerEmail ? _self.claimerEmail : claimerEmail // ignore: cast_nullable_to_non_nullable
as String?,claimerAddress: freezed == claimerAddress ? _self.claimerAddress : claimerAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LostAndFoundItem].
extension LostAndFoundItemPatterns on LostAndFoundItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LostAndFoundItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LostAndFoundItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LostAndFoundItem value)  $default,){
final _that = this;
switch (_that) {
case _LostAndFoundItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LostAndFoundItem value)?  $default,){
final _that = this;
switch (_that) {
case _LostAndFoundItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String itemName,  String itemTypeId,  String itemTagId,  String description,  DateTime datetimeFound,  String finderName,  String locationFound,  bool isClaimed,  DateTime? claimedDatetime,  String? claimerName,  String? claimerContact,  String? claimerEmail,  String? claimerAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LostAndFoundItem() when $default != null:
return $default(_that.id,_that.itemName,_that.itemTypeId,_that.itemTagId,_that.description,_that.datetimeFound,_that.finderName,_that.locationFound,_that.isClaimed,_that.claimedDatetime,_that.claimerName,_that.claimerContact,_that.claimerEmail,_that.claimerAddress);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String itemName,  String itemTypeId,  String itemTagId,  String description,  DateTime datetimeFound,  String finderName,  String locationFound,  bool isClaimed,  DateTime? claimedDatetime,  String? claimerName,  String? claimerContact,  String? claimerEmail,  String? claimerAddress)  $default,) {final _that = this;
switch (_that) {
case _LostAndFoundItem():
return $default(_that.id,_that.itemName,_that.itemTypeId,_that.itemTagId,_that.description,_that.datetimeFound,_that.finderName,_that.locationFound,_that.isClaimed,_that.claimedDatetime,_that.claimerName,_that.claimerContact,_that.claimerEmail,_that.claimerAddress);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String itemName,  String itemTypeId,  String itemTagId,  String description,  DateTime datetimeFound,  String finderName,  String locationFound,  bool isClaimed,  DateTime? claimedDatetime,  String? claimerName,  String? claimerContact,  String? claimerEmail,  String? claimerAddress)?  $default,) {final _that = this;
switch (_that) {
case _LostAndFoundItem() when $default != null:
return $default(_that.id,_that.itemName,_that.itemTypeId,_that.itemTagId,_that.description,_that.datetimeFound,_that.finderName,_that.locationFound,_that.isClaimed,_that.claimedDatetime,_that.claimerName,_that.claimerContact,_that.claimerEmail,_that.claimerAddress);case _:
  return null;

}
}

}

/// @nodoc


class _LostAndFoundItem extends LostAndFoundItem {
  const _LostAndFoundItem({required this.id, required this.itemName, required this.itemTypeId, required this.itemTagId, required this.description, required this.datetimeFound, required this.finderName, required this.locationFound, required this.isClaimed, this.claimedDatetime, this.claimerName, this.claimerContact, this.claimerEmail, this.claimerAddress}): super._();
  

@override final  String id;
@override final  String itemName;
@override final  String itemTypeId;
@override final  String itemTagId;
@override final  String description;
@override final  DateTime datetimeFound;
@override final  String finderName;
@override final  String locationFound;
@override final  bool isClaimed;
@override final  DateTime? claimedDatetime;
@override final  String? claimerName;
@override final  String? claimerContact;
@override final  String? claimerEmail;
@override final  String? claimerAddress;

/// Create a copy of LostAndFoundItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LostAndFoundItemCopyWith<_LostAndFoundItem> get copyWith => __$LostAndFoundItemCopyWithImpl<_LostAndFoundItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LostAndFoundItem&&(identical(other.id, id) || other.id == id)&&(identical(other.itemName, itemName) || other.itemName == itemName)&&(identical(other.itemTypeId, itemTypeId) || other.itemTypeId == itemTypeId)&&(identical(other.itemTagId, itemTagId) || other.itemTagId == itemTagId)&&(identical(other.description, description) || other.description == description)&&(identical(other.datetimeFound, datetimeFound) || other.datetimeFound == datetimeFound)&&(identical(other.finderName, finderName) || other.finderName == finderName)&&(identical(other.locationFound, locationFound) || other.locationFound == locationFound)&&(identical(other.isClaimed, isClaimed) || other.isClaimed == isClaimed)&&(identical(other.claimedDatetime, claimedDatetime) || other.claimedDatetime == claimedDatetime)&&(identical(other.claimerName, claimerName) || other.claimerName == claimerName)&&(identical(other.claimerContact, claimerContact) || other.claimerContact == claimerContact)&&(identical(other.claimerEmail, claimerEmail) || other.claimerEmail == claimerEmail)&&(identical(other.claimerAddress, claimerAddress) || other.claimerAddress == claimerAddress));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,itemName,itemTypeId,itemTagId,description,datetimeFound,finderName,locationFound,isClaimed,claimedDatetime,claimerName,claimerContact,claimerEmail,claimerAddress);
}

@override
String toString() {
    return 'LostAndFoundItem(id: $id, itemName: $itemName, itemTypeId: $itemTypeId, itemTagId: $itemTagId, description: $description, datetimeFound: $datetimeFound, finderName: $finderName, locationFound: $locationFound, isClaimed: $isClaimed, claimedDatetime: $claimedDatetime, claimerName: $claimerName, claimerContact: $claimerContact, claimerEmail: $claimerEmail, claimerAddress: $claimerAddress)';
}


}

/// @nodoc
abstract mixin class _$LostAndFoundItemCopyWith<$Res> implements $LostAndFoundItemCopyWith<$Res> {
  factory _$LostAndFoundItemCopyWith(_LostAndFoundItem value, $Res Function(_LostAndFoundItem) _then) = __$LostAndFoundItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String itemName, String itemTypeId, String itemTagId, String description, DateTime datetimeFound, String finderName, String locationFound, bool isClaimed, DateTime? claimedDatetime, String? claimerName, String? claimerContact, String? claimerEmail, String? claimerAddress
});




}
/// @nodoc
class __$LostAndFoundItemCopyWithImpl<$Res>
    implements _$LostAndFoundItemCopyWith<$Res> {
  __$LostAndFoundItemCopyWithImpl(this._self, this._then);

  final _LostAndFoundItem _self;
  final $Res Function(_LostAndFoundItem) _then;

/// Create a copy of LostAndFoundItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemName = null,Object? itemTypeId = null,Object? itemTagId = null,Object? description = null,Object? datetimeFound = null,Object? finderName = null,Object? locationFound = null,Object? isClaimed = null,Object? claimedDatetime = freezed,Object? claimerName = freezed,Object? claimerContact = freezed,Object? claimerEmail = freezed,Object? claimerAddress = freezed,}) {
  return _then(_LostAndFoundItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemName: null == itemName ? _self.itemName : itemName // ignore: cast_nullable_to_non_nullable
as String,itemTypeId: null == itemTypeId ? _self.itemTypeId : itemTypeId // ignore: cast_nullable_to_non_nullable
as String,itemTagId: null == itemTagId ? _self.itemTagId : itemTagId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,datetimeFound: null == datetimeFound ? _self.datetimeFound : datetimeFound // ignore: cast_nullable_to_non_nullable
as DateTime,finderName: null == finderName ? _self.finderName : finderName // ignore: cast_nullable_to_non_nullable
as String,locationFound: null == locationFound ? _self.locationFound : locationFound // ignore: cast_nullable_to_non_nullable
as String,isClaimed: null == isClaimed ? _self.isClaimed : isClaimed // ignore: cast_nullable_to_non_nullable
as bool,claimedDatetime: freezed == claimedDatetime ? _self.claimedDatetime : claimedDatetime // ignore: cast_nullable_to_non_nullable
as DateTime?,claimerName: freezed == claimerName ? _self.claimerName : claimerName // ignore: cast_nullable_to_non_nullable
as String?,claimerContact: freezed == claimerContact ? _self.claimerContact : claimerContact // ignore: cast_nullable_to_non_nullable
as String?,claimerEmail: freezed == claimerEmail ? _self.claimerEmail : claimerEmail // ignore: cast_nullable_to_non_nullable
as String?,claimerAddress: freezed == claimerAddress ? _self.claimerAddress : claimerAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
