// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guidance_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GuidanceScheduleTag {

 String get id; String get tagName;/// Hex color string, e.g. `#4CAF50`.
 String get color;
/// Create a copy of GuidanceScheduleTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuidanceScheduleTagCopyWith<GuidanceScheduleTag> get copyWith => _$GuidanceScheduleTagCopyWithImpl<GuidanceScheduleTag>(this as GuidanceScheduleTag, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GuidanceScheduleTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuidanceScheduleTag&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tagName, _this.tagName) || other.tagName == _this.tagName)&&(identical(other.color, _this.color) || other.color == _this.color));
}


@override
int get hashCode {
  final _this = this as GuidanceScheduleTag;
  return Object.hash(runtimeType,_this.id,_this.tagName,_this.color);
}

@override
String toString() {
  final _this = this as GuidanceScheduleTag;
  return 'GuidanceScheduleTag(id: ${_this.id}, tagName: ${_this.tagName}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $GuidanceScheduleTagCopyWith<$Res>  {
  factory $GuidanceScheduleTagCopyWith(GuidanceScheduleTag value, $Res Function(GuidanceScheduleTag) _then) = _$GuidanceScheduleTagCopyWithImpl;
@useResult
$Res call({
 String id, String tagName, String color
});




}
/// @nodoc
class _$GuidanceScheduleTagCopyWithImpl<$Res>
    implements $GuidanceScheduleTagCopyWith<$Res> {
  _$GuidanceScheduleTagCopyWithImpl(this._self, this._then);

  final GuidanceScheduleTag _self;
  final $Res Function(GuidanceScheduleTag) _then;

/// Create a copy of GuidanceScheduleTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tagName = null,Object? color = null,}) {
  return _then(GuidanceScheduleTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tagName: null == tagName ? _self.tagName : tagName // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GuidanceScheduleTag].
extension GuidanceScheduleTagPatterns on GuidanceScheduleTag {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuidanceScheduleTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuidanceScheduleTag() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuidanceScheduleTag value)  $default,){
final _that = this;
switch (_that) {
case _GuidanceScheduleTag():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuidanceScheduleTag value)?  $default,){
final _that = this;
switch (_that) {
case _GuidanceScheduleTag() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tagName,  String color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuidanceScheduleTag() when $default != null:
return $default(_that.id,_that.tagName,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tagName,  String color)  $default,) {final _that = this;
switch (_that) {
case _GuidanceScheduleTag():
return $default(_that.id,_that.tagName,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tagName,  String color)?  $default,) {final _that = this;
switch (_that) {
case _GuidanceScheduleTag() when $default != null:
return $default(_that.id,_that.tagName,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _GuidanceScheduleTag extends GuidanceScheduleTag {
  const _GuidanceScheduleTag({required this.id, required this.tagName, required this.color}): super._();
  

@override final  String id;
@override final  String tagName;
/// Hex color string, e.g. `#4CAF50`.
@override final  String color;

/// Create a copy of GuidanceScheduleTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuidanceScheduleTagCopyWith<_GuidanceScheduleTag> get copyWith => __$GuidanceScheduleTagCopyWithImpl<_GuidanceScheduleTag>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuidanceScheduleTag&&(identical(other.id, id) || other.id == id)&&(identical(other.tagName, tagName) || other.tagName == tagName)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,tagName,color);
}

@override
String toString() {
    return 'GuidanceScheduleTag(id: $id, tagName: $tagName, color: $color)';
}


}

/// @nodoc
abstract mixin class _$GuidanceScheduleTagCopyWith<$Res> implements $GuidanceScheduleTagCopyWith<$Res> {
  factory _$GuidanceScheduleTagCopyWith(_GuidanceScheduleTag value, $Res Function(_GuidanceScheduleTag) _then) = __$GuidanceScheduleTagCopyWithImpl;
@override @useResult
$Res call({
 String id, String tagName, String color
});




}
/// @nodoc
class __$GuidanceScheduleTagCopyWithImpl<$Res>
    implements _$GuidanceScheduleTagCopyWith<$Res> {
  __$GuidanceScheduleTagCopyWithImpl(this._self, this._then);

  final _GuidanceScheduleTag _self;
  final $Res Function(_GuidanceScheduleTag) _then;

/// Create a copy of GuidanceScheduleTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tagName = null,Object? color = null,}) {
  return _then(_GuidanceScheduleTag(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tagName: null == tagName ? _self.tagName : tagName // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$GuidanceProgram {

 String get id; String get title; String get description; DateTime get programStart; DateTime get programEnd; String get scheduleTagId; bool get isPublic;/// Only used when [isPublic] is false. Creator is always in this
/// list — matches original's `$this->selected_users[] = $this->user_id`.
 List<String> get privateRecipients; String get createdByUserId;
/// Create a copy of GuidanceProgram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuidanceProgramCopyWith<GuidanceProgram> get copyWith => _$GuidanceProgramCopyWithImpl<GuidanceProgram>(this as GuidanceProgram, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GuidanceProgram;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuidanceProgram&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.programStart, _this.programStart) || other.programStart == _this.programStart)&&(identical(other.programEnd, _this.programEnd) || other.programEnd == _this.programEnd)&&(identical(other.scheduleTagId, _this.scheduleTagId) || other.scheduleTagId == _this.scheduleTagId)&&(identical(other.isPublic, _this.isPublic) || other.isPublic == _this.isPublic)&&const DeepCollectionEquality().equals(other.privateRecipients, _this.privateRecipients)&&(identical(other.createdByUserId, _this.createdByUserId) || other.createdByUserId == _this.createdByUserId));
}


@override
int get hashCode {
  final _this = this as GuidanceProgram;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.programStart,_this.programEnd,_this.scheduleTagId,_this.isPublic,const DeepCollectionEquality().hash(_this.privateRecipients),_this.createdByUserId);
}

@override
String toString() {
  final _this = this as GuidanceProgram;
  return 'GuidanceProgram(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, programStart: ${_this.programStart}, programEnd: ${_this.programEnd}, scheduleTagId: ${_this.scheduleTagId}, isPublic: ${_this.isPublic}, privateRecipients: ${_this.privateRecipients}, createdByUserId: ${_this.createdByUserId})';
}


}

/// @nodoc
abstract mixin class $GuidanceProgramCopyWith<$Res>  {
  factory $GuidanceProgramCopyWith(GuidanceProgram value, $Res Function(GuidanceProgram) _then) = _$GuidanceProgramCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, DateTime programStart, DateTime programEnd, String scheduleTagId, bool isPublic, List<String> privateRecipients, String createdByUserId
});




}
/// @nodoc
class _$GuidanceProgramCopyWithImpl<$Res>
    implements $GuidanceProgramCopyWith<$Res> {
  _$GuidanceProgramCopyWithImpl(this._self, this._then);

  final GuidanceProgram _self;
  final $Res Function(GuidanceProgram) _then;

/// Create a copy of GuidanceProgram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? programStart = null,Object? programEnd = null,Object? scheduleTagId = null,Object? isPublic = null,Object? privateRecipients = null,Object? createdByUserId = null,}) {
  return _then(GuidanceProgram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,programStart: null == programStart ? _self.programStart : programStart // ignore: cast_nullable_to_non_nullable
as DateTime,programEnd: null == programEnd ? _self.programEnd : programEnd // ignore: cast_nullable_to_non_nullable
as DateTime,scheduleTagId: null == scheduleTagId ? _self.scheduleTagId : scheduleTagId // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,privateRecipients: null == privateRecipients ? _self.privateRecipients : privateRecipients // ignore: cast_nullable_to_non_nullable
as List<String>,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GuidanceProgram].
extension GuidanceProgramPatterns on GuidanceProgram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuidanceProgram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuidanceProgram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuidanceProgram value)  $default,){
final _that = this;
switch (_that) {
case _GuidanceProgram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuidanceProgram value)?  $default,){
final _that = this;
switch (_that) {
case _GuidanceProgram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  DateTime programStart,  DateTime programEnd,  String scheduleTagId,  bool isPublic,  List<String> privateRecipients,  String createdByUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuidanceProgram() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.programStart,_that.programEnd,_that.scheduleTagId,_that.isPublic,_that.privateRecipients,_that.createdByUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  DateTime programStart,  DateTime programEnd,  String scheduleTagId,  bool isPublic,  List<String> privateRecipients,  String createdByUserId)  $default,) {final _that = this;
switch (_that) {
case _GuidanceProgram():
return $default(_that.id,_that.title,_that.description,_that.programStart,_that.programEnd,_that.scheduleTagId,_that.isPublic,_that.privateRecipients,_that.createdByUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  DateTime programStart,  DateTime programEnd,  String scheduleTagId,  bool isPublic,  List<String> privateRecipients,  String createdByUserId)?  $default,) {final _that = this;
switch (_that) {
case _GuidanceProgram() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.programStart,_that.programEnd,_that.scheduleTagId,_that.isPublic,_that.privateRecipients,_that.createdByUserId);case _:
  return null;

}
}

}

/// @nodoc


class _GuidanceProgram extends GuidanceProgram {
  const _GuidanceProgram({required this.id, required this.title, this.description = '', required this.programStart, required this.programEnd, required this.scheduleTagId, required this.isPublic,  List<String> privateRecipients = const <String>[], required this.createdByUserId}): _privateRecipients = privateRecipients,super._();
  

@override final  String id;
@override final  String title;
@override@JsonKey() final  String description;
@override final  DateTime programStart;
@override final  DateTime programEnd;
@override final  String scheduleTagId;
@override final  bool isPublic;
/// Only used when [isPublic] is false. Creator is always in this
/// list — matches original's `$this->selected_users[] = $this->user_id`.
 final  List<String> _privateRecipients;
/// Only used when [isPublic] is false. Creator is always in this
/// list — matches original's `$this->selected_users[] = $this->user_id`.
@override@JsonKey() List<String> get privateRecipients {
  if (_privateRecipients is EqualUnmodifiableListView) return _privateRecipients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_privateRecipients);
}

@override final  String createdByUserId;

/// Create a copy of GuidanceProgram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuidanceProgramCopyWith<_GuidanceProgram> get copyWith => __$GuidanceProgramCopyWithImpl<_GuidanceProgram>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuidanceProgram&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.programStart, programStart) || other.programStart == programStart)&&(identical(other.programEnd, programEnd) || other.programEnd == programEnd)&&(identical(other.scheduleTagId, scheduleTagId) || other.scheduleTagId == scheduleTagId)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&const DeepCollectionEquality().equals(other.privateRecipients, _privateRecipients)&&(identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,programStart,programEnd,scheduleTagId,isPublic,const DeepCollectionEquality().hash(_privateRecipients),createdByUserId);
}

@override
String toString() {
    return 'GuidanceProgram(id: $id, title: $title, description: $description, programStart: $programStart, programEnd: $programEnd, scheduleTagId: $scheduleTagId, isPublic: $isPublic, privateRecipients: $privateRecipients, createdByUserId: $createdByUserId)';
}


}

/// @nodoc
abstract mixin class _$GuidanceProgramCopyWith<$Res> implements $GuidanceProgramCopyWith<$Res> {
  factory _$GuidanceProgramCopyWith(_GuidanceProgram value, $Res Function(_GuidanceProgram) _then) = __$GuidanceProgramCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, DateTime programStart, DateTime programEnd, String scheduleTagId, bool isPublic, List<String> privateRecipients, String createdByUserId
});




}
/// @nodoc
class __$GuidanceProgramCopyWithImpl<$Res>
    implements _$GuidanceProgramCopyWith<$Res> {
  __$GuidanceProgramCopyWithImpl(this._self, this._then);

  final _GuidanceProgram _self;
  final $Res Function(_GuidanceProgram) _then;

/// Create a copy of GuidanceProgram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? programStart = null,Object? programEnd = null,Object? scheduleTagId = null,Object? isPublic = null,Object? privateRecipients = null,Object? createdByUserId = null,}) {
  return _then(_GuidanceProgram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,programStart: null == programStart ? _self.programStart : programStart // ignore: cast_nullable_to_non_nullable
as DateTime,programEnd: null == programEnd ? _self.programEnd : programEnd // ignore: cast_nullable_to_non_nullable
as DateTime,scheduleTagId: null == scheduleTagId ? _self.scheduleTagId : scheduleTagId // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,privateRecipients: null == privateRecipients ? _self._privateRecipients : privateRecipients // ignore: cast_nullable_to_non_nullable
as List<String>,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
