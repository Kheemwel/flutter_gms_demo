// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offense.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OffenseCategory {

 String get id; String get name;
/// Create a copy of OffenseCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffenseCategoryCopyWith<OffenseCategory> get copyWith => _$OffenseCategoryCopyWithImpl<OffenseCategory>(this as OffenseCategory, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OffenseCategory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffenseCategory&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}


@override
int get hashCode {
  final _this = this as OffenseCategory;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as OffenseCategory;
  return 'OffenseCategory(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $OffenseCategoryCopyWith<$Res>  {
  factory $OffenseCategoryCopyWith(OffenseCategory value, $Res Function(OffenseCategory) _then) = _$OffenseCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$OffenseCategoryCopyWithImpl<$Res>
    implements $OffenseCategoryCopyWith<$Res> {
  _$OffenseCategoryCopyWithImpl(this._self, this._then);

  final OffenseCategory _self;
  final $Res Function(OffenseCategory) _then;

/// Create a copy of OffenseCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(OffenseCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OffenseCategory].
extension OffenseCategoryPatterns on OffenseCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OffenseCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OffenseCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OffenseCategory value)  $default,){
final _that = this;
switch (_that) {
case _OffenseCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OffenseCategory value)?  $default,){
final _that = this;
switch (_that) {
case _OffenseCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OffenseCategory() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _OffenseCategory():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _OffenseCategory() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _OffenseCategory implements OffenseCategory {
  const _OffenseCategory({required this.id, required this.name});
  

@override final  String id;
@override final  String name;

/// Create a copy of OffenseCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OffenseCategoryCopyWith<_OffenseCategory> get copyWith => __$OffenseCategoryCopyWithImpl<_OffenseCategory>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OffenseCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'OffenseCategory(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$OffenseCategoryCopyWith<$Res> implements $OffenseCategoryCopyWith<$Res> {
  factory _$OffenseCategoryCopyWith(_OffenseCategory value, $Res Function(_OffenseCategory) _then) = __$OffenseCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$OffenseCategoryCopyWithImpl<$Res>
    implements _$OffenseCategoryCopyWith<$Res> {
  __$OffenseCategoryCopyWithImpl(this._self, this._then);

  final _OffenseCategory _self;
  final $Res Function(_OffenseCategory) _then;

/// Create a copy of OffenseCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_OffenseCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OffenseLevel {

 String get id; String get name;/// 1 = minor, 5 = severe. Used for sorting the offense list
/// and for visual severity chips.
 int get severity;
/// Create a copy of OffenseLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffenseLevelCopyWith<OffenseLevel> get copyWith => _$OffenseLevelCopyWithImpl<OffenseLevel>(this as OffenseLevel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OffenseLevel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffenseLevel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.severity, _this.severity) || other.severity == _this.severity));
}


@override
int get hashCode {
  final _this = this as OffenseLevel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.severity);
}

@override
String toString() {
  final _this = this as OffenseLevel;
  return 'OffenseLevel(id: ${_this.id}, name: ${_this.name}, severity: ${_this.severity})';
}


}

/// @nodoc
abstract mixin class $OffenseLevelCopyWith<$Res>  {
  factory $OffenseLevelCopyWith(OffenseLevel value, $Res Function(OffenseLevel) _then) = _$OffenseLevelCopyWithImpl;
@useResult
$Res call({
 String id, String name, int severity
});




}
/// @nodoc
class _$OffenseLevelCopyWithImpl<$Res>
    implements $OffenseLevelCopyWith<$Res> {
  _$OffenseLevelCopyWithImpl(this._self, this._then);

  final OffenseLevel _self;
  final $Res Function(OffenseLevel) _then;

/// Create a copy of OffenseLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? severity = null,}) {
  return _then(OffenseLevel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OffenseLevel].
extension OffenseLevelPatterns on OffenseLevel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OffenseLevel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OffenseLevel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OffenseLevel value)  $default,){
final _that = this;
switch (_that) {
case _OffenseLevel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OffenseLevel value)?  $default,){
final _that = this;
switch (_that) {
case _OffenseLevel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int severity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OffenseLevel() when $default != null:
return $default(_that.id,_that.name,_that.severity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int severity)  $default,) {final _that = this;
switch (_that) {
case _OffenseLevel():
return $default(_that.id,_that.name,_that.severity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int severity)?  $default,) {final _that = this;
switch (_that) {
case _OffenseLevel() when $default != null:
return $default(_that.id,_that.name,_that.severity);case _:
  return null;

}
}

}

/// @nodoc


class _OffenseLevel implements OffenseLevel {
  const _OffenseLevel({required this.id, required this.name, required this.severity});
  

@override final  String id;
@override final  String name;
/// 1 = minor, 5 = severe. Used for sorting the offense list
/// and for visual severity chips.
@override final  int severity;

/// Create a copy of OffenseLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OffenseLevelCopyWith<_OffenseLevel> get copyWith => __$OffenseLevelCopyWithImpl<_OffenseLevel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OffenseLevel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.severity, severity) || other.severity == severity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,severity);
}

@override
String toString() {
    return 'OffenseLevel(id: $id, name: $name, severity: $severity)';
}


}

/// @nodoc
abstract mixin class _$OffenseLevelCopyWith<$Res> implements $OffenseLevelCopyWith<$Res> {
  factory _$OffenseLevelCopyWith(_OffenseLevel value, $Res Function(_OffenseLevel) _then) = __$OffenseLevelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int severity
});




}
/// @nodoc
class __$OffenseLevelCopyWithImpl<$Res>
    implements _$OffenseLevelCopyWith<$Res> {
  __$OffenseLevelCopyWithImpl(this._self, this._then);

  final _OffenseLevel _self;
  final $Res Function(_OffenseLevel) _then;

/// Create a copy of OffenseLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? severity = null,}) {
  return _then(_OffenseLevel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$DisciplinaryAction {

 String get id; String get name; String get description;
/// Create a copy of DisciplinaryAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisciplinaryActionCopyWith<DisciplinaryAction> get copyWith => _$DisciplinaryActionCopyWithImpl<DisciplinaryAction>(this as DisciplinaryAction, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DisciplinaryAction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisciplinaryAction&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as DisciplinaryAction;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description);
}

@override
String toString() {
  final _this = this as DisciplinaryAction;
  return 'DisciplinaryAction(id: ${_this.id}, name: ${_this.name}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $DisciplinaryActionCopyWith<$Res>  {
  factory $DisciplinaryActionCopyWith(DisciplinaryAction value, $Res Function(DisciplinaryAction) _then) = _$DisciplinaryActionCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description
});




}
/// @nodoc
class _$DisciplinaryActionCopyWithImpl<$Res>
    implements $DisciplinaryActionCopyWith<$Res> {
  _$DisciplinaryActionCopyWithImpl(this._self, this._then);

  final DisciplinaryAction _self;
  final $Res Function(DisciplinaryAction) _then;

/// Create a copy of DisciplinaryAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,}) {
  return _then(DisciplinaryAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DisciplinaryAction].
extension DisciplinaryActionPatterns on DisciplinaryAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisciplinaryAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisciplinaryAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisciplinaryAction value)  $default,){
final _that = this;
switch (_that) {
case _DisciplinaryAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisciplinaryAction value)?  $default,){
final _that = this;
switch (_that) {
case _DisciplinaryAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisciplinaryAction() when $default != null:
return $default(_that.id,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description)  $default,) {final _that = this;
switch (_that) {
case _DisciplinaryAction():
return $default(_that.id,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description)?  $default,) {final _that = this;
switch (_that) {
case _DisciplinaryAction() when $default != null:
return $default(_that.id,_that.name,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _DisciplinaryAction implements DisciplinaryAction {
  const _DisciplinaryAction({required this.id, required this.name, this.description = ''});
  

@override final  String id;
@override final  String name;
@override@JsonKey() final  String description;

/// Create a copy of DisciplinaryAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisciplinaryActionCopyWith<_DisciplinaryAction> get copyWith => __$DisciplinaryActionCopyWithImpl<_DisciplinaryAction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisciplinaryAction&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description);
}

@override
String toString() {
    return 'DisciplinaryAction(id: $id, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$DisciplinaryActionCopyWith<$Res> implements $DisciplinaryActionCopyWith<$Res> {
  factory _$DisciplinaryActionCopyWith(_DisciplinaryAction value, $Res Function(_DisciplinaryAction) _then) = __$DisciplinaryActionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description
});




}
/// @nodoc
class __$DisciplinaryActionCopyWithImpl<$Res>
    implements _$DisciplinaryActionCopyWith<$Res> {
  __$DisciplinaryActionCopyWithImpl(this._self, this._then);

  final _DisciplinaryAction _self;
  final $Res Function(_DisciplinaryAction) _then;

/// Create a copy of DisciplinaryAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,}) {
  return _then(_DisciplinaryAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Offense {

 String get id; String get name; String get categoryId; String get levelId;/// Set of DisciplinaryAction ids that can be applied to this offense.
 List<String> get actionIds; String get description;
/// Create a copy of Offense
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffenseCopyWith<Offense> get copyWith => _$OffenseCopyWithImpl<Offense>(this as Offense, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Offense;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Offense&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.levelId, _this.levelId) || other.levelId == _this.levelId)&&const DeepCollectionEquality().equals(other.actionIds, _this.actionIds)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as Offense;
  return Object.hash(runtimeType,_this.id,_this.name,_this.categoryId,_this.levelId,const DeepCollectionEquality().hash(_this.actionIds),_this.description);
}

@override
String toString() {
  final _this = this as Offense;
  return 'Offense(id: ${_this.id}, name: ${_this.name}, categoryId: ${_this.categoryId}, levelId: ${_this.levelId}, actionIds: ${_this.actionIds}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $OffenseCopyWith<$Res>  {
  factory $OffenseCopyWith(Offense value, $Res Function(Offense) _then) = _$OffenseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String categoryId, String levelId, List<String> actionIds, String description
});




}
/// @nodoc
class _$OffenseCopyWithImpl<$Res>
    implements $OffenseCopyWith<$Res> {
  _$OffenseCopyWithImpl(this._self, this._then);

  final Offense _self;
  final $Res Function(Offense) _then;

/// Create a copy of Offense
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categoryId = null,Object? levelId = null,Object? actionIds = null,Object? description = null,}) {
  return _then(Offense(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,levelId: null == levelId ? _self.levelId : levelId // ignore: cast_nullable_to_non_nullable
as String,actionIds: null == actionIds ? _self.actionIds : actionIds // ignore: cast_nullable_to_non_nullable
as List<String>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Offense].
extension OffensePatterns on Offense {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Offense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Offense() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Offense value)  $default,){
final _that = this;
switch (_that) {
case _Offense():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Offense value)?  $default,){
final _that = this;
switch (_that) {
case _Offense() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String categoryId,  String levelId,  List<String> actionIds,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Offense() when $default != null:
return $default(_that.id,_that.name,_that.categoryId,_that.levelId,_that.actionIds,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String categoryId,  String levelId,  List<String> actionIds,  String description)  $default,) {final _that = this;
switch (_that) {
case _Offense():
return $default(_that.id,_that.name,_that.categoryId,_that.levelId,_that.actionIds,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String categoryId,  String levelId,  List<String> actionIds,  String description)?  $default,) {final _that = this;
switch (_that) {
case _Offense() when $default != null:
return $default(_that.id,_that.name,_that.categoryId,_that.levelId,_that.actionIds,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _Offense implements Offense {
  const _Offense({required this.id, required this.name, required this.categoryId, required this.levelId,  List<String> actionIds = const <String>[], this.description = ''}): _actionIds = actionIds;
  

@override final  String id;
@override final  String name;
@override final  String categoryId;
@override final  String levelId;
/// Set of DisciplinaryAction ids that can be applied to this offense.
 final  List<String> _actionIds;
/// Set of DisciplinaryAction ids that can be applied to this offense.
@override@JsonKey() List<String> get actionIds {
  if (_actionIds is EqualUnmodifiableListView) return _actionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actionIds);
}

@override@JsonKey() final  String description;

/// Create a copy of Offense
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OffenseCopyWith<_Offense> get copyWith => __$OffenseCopyWithImpl<_Offense>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Offense&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.levelId, levelId) || other.levelId == levelId)&&const DeepCollectionEquality().equals(other.actionIds, _actionIds)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,categoryId,levelId,const DeepCollectionEquality().hash(_actionIds),description);
}

@override
String toString() {
    return 'Offense(id: $id, name: $name, categoryId: $categoryId, levelId: $levelId, actionIds: $actionIds, description: $description)';
}


}

/// @nodoc
abstract mixin class _$OffenseCopyWith<$Res> implements $OffenseCopyWith<$Res> {
  factory _$OffenseCopyWith(_Offense value, $Res Function(_Offense) _then) = __$OffenseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String categoryId, String levelId, List<String> actionIds, String description
});




}
/// @nodoc
class __$OffenseCopyWithImpl<$Res>
    implements _$OffenseCopyWith<$Res> {
  __$OffenseCopyWithImpl(this._self, this._then);

  final _Offense _self;
  final $Res Function(_Offense) _then;

/// Create a copy of Offense
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categoryId = null,Object? levelId = null,Object? actionIds = null,Object? description = null,}) {
  return _then(_Offense(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,levelId: null == levelId ? _self.levelId : levelId // ignore: cast_nullable_to_non_nullable
as String,actionIds: null == actionIds ? _self._actionIds : actionIds // ignore: cast_nullable_to_non_nullable
as List<String>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
