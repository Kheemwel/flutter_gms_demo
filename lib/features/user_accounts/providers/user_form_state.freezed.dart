// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserFormState {

 RoleKind get kind; String get firstName; String get lastName; String get email; String get lrn; GradeLevel get gradeLevel; List<String> get parentIds; List<String> get childIds; PrincipalPosition get position;
/// Create a copy of UserFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFormStateCopyWith<UserFormState> get copyWith => _$UserFormStateCopyWithImpl<UserFormState>(this as UserFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFormState&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.lrn, _this.lrn) || other.lrn == _this.lrn)&&(identical(other.gradeLevel, _this.gradeLevel) || other.gradeLevel == _this.gradeLevel)&&const DeepCollectionEquality().equals(other.parentIds, _this.parentIds)&&const DeepCollectionEquality().equals(other.childIds, _this.childIds)&&(identical(other.position, _this.position) || other.position == _this.position));
}


@override
int get hashCode {
  final _this = this as UserFormState;
  return Object.hash(runtimeType,_this.kind,_this.firstName,_this.lastName,_this.email,_this.lrn,_this.gradeLevel,const DeepCollectionEquality().hash(_this.parentIds),const DeepCollectionEquality().hash(_this.childIds),_this.position);
}

@override
String toString() {
  final _this = this as UserFormState;
  return 'UserFormState(kind: ${_this.kind}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, email: ${_this.email}, lrn: ${_this.lrn}, gradeLevel: ${_this.gradeLevel}, parentIds: ${_this.parentIds}, childIds: ${_this.childIds}, position: ${_this.position})';
}


}

/// @nodoc
abstract mixin class $UserFormStateCopyWith<$Res>  {
  factory $UserFormStateCopyWith(UserFormState value, $Res Function(UserFormState) _then) = _$UserFormStateCopyWithImpl;
@useResult
$Res call({
 RoleKind kind, String firstName, String lastName, String email, String lrn, GradeLevel gradeLevel, List<String> parentIds, List<String> childIds, PrincipalPosition position
});




}
/// @nodoc
class _$UserFormStateCopyWithImpl<$Res>
    implements $UserFormStateCopyWith<$Res> {
  _$UserFormStateCopyWithImpl(this._self, this._then);

  final UserFormState _self;
  final $Res Function(UserFormState) _then;

/// Create a copy of UserFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? lrn = null,Object? gradeLevel = null,Object? parentIds = null,Object? childIds = null,Object? position = null,}) {
  return _then(UserFormState(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RoleKind,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lrn: null == lrn ? _self.lrn : lrn // ignore: cast_nullable_to_non_nullable
as String,gradeLevel: null == gradeLevel ? _self.gradeLevel : gradeLevel // ignore: cast_nullable_to_non_nullable
as GradeLevel,parentIds: null == parentIds ? _self.parentIds : parentIds // ignore: cast_nullable_to_non_nullable
as List<String>,childIds: null == childIds ? _self.childIds : childIds // ignore: cast_nullable_to_non_nullable
as List<String>,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as PrincipalPosition,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFormState].
extension UserFormStatePatterns on UserFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFormState value)  $default,){
final _that = this;
switch (_that) {
case _UserFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFormState value)?  $default,){
final _that = this;
switch (_that) {
case _UserFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RoleKind kind,  String firstName,  String lastName,  String email,  String lrn,  GradeLevel gradeLevel,  List<String> parentIds,  List<String> childIds,  PrincipalPosition position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFormState() when $default != null:
return $default(_that.kind,_that.firstName,_that.lastName,_that.email,_that.lrn,_that.gradeLevel,_that.parentIds,_that.childIds,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RoleKind kind,  String firstName,  String lastName,  String email,  String lrn,  GradeLevel gradeLevel,  List<String> parentIds,  List<String> childIds,  PrincipalPosition position)  $default,) {final _that = this;
switch (_that) {
case _UserFormState():
return $default(_that.kind,_that.firstName,_that.lastName,_that.email,_that.lrn,_that.gradeLevel,_that.parentIds,_that.childIds,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RoleKind kind,  String firstName,  String lastName,  String email,  String lrn,  GradeLevel gradeLevel,  List<String> parentIds,  List<String> childIds,  PrincipalPosition position)?  $default,) {final _that = this;
switch (_that) {
case _UserFormState() when $default != null:
return $default(_that.kind,_that.firstName,_that.lastName,_that.email,_that.lrn,_that.gradeLevel,_that.parentIds,_that.childIds,_that.position);case _:
  return null;

}
}

}

/// @nodoc


class _UserFormState implements UserFormState {
  const _UserFormState({required this.kind, required this.firstName, required this.lastName, required this.email, this.lrn = '', this.gradeLevel = GradeLevel.grade9,  List<String> parentIds = const <String>[],  List<String> childIds = const <String>[], this.position = PrincipalPosition.juniorHigh}): _parentIds = parentIds,_childIds = childIds;
  

@override final  RoleKind kind;
@override final  String firstName;
@override final  String lastName;
@override final  String email;
@override@JsonKey() final  String lrn;
@override@JsonKey() final  GradeLevel gradeLevel;
 final  List<String> _parentIds;
@override@JsonKey() List<String> get parentIds {
  if (_parentIds is EqualUnmodifiableListView) return _parentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parentIds);
}

 final  List<String> _childIds;
@override@JsonKey() List<String> get childIds {
  if (_childIds is EqualUnmodifiableListView) return _childIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_childIds);
}

@override@JsonKey() final  PrincipalPosition position;

/// Create a copy of UserFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFormStateCopyWith<_UserFormState> get copyWith => __$UserFormStateCopyWithImpl<_UserFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFormState&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.lrn, lrn) || other.lrn == lrn)&&(identical(other.gradeLevel, gradeLevel) || other.gradeLevel == gradeLevel)&&const DeepCollectionEquality().equals(other.parentIds, _parentIds)&&const DeepCollectionEquality().equals(other.childIds, _childIds)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,firstName,lastName,email,lrn,gradeLevel,const DeepCollectionEquality().hash(_parentIds),const DeepCollectionEquality().hash(_childIds),position);
}

@override
String toString() {
    return 'UserFormState(kind: $kind, firstName: $firstName, lastName: $lastName, email: $email, lrn: $lrn, gradeLevel: $gradeLevel, parentIds: $parentIds, childIds: $childIds, position: $position)';
}


}

/// @nodoc
abstract mixin class _$UserFormStateCopyWith<$Res> implements $UserFormStateCopyWith<$Res> {
  factory _$UserFormStateCopyWith(_UserFormState value, $Res Function(_UserFormState) _then) = __$UserFormStateCopyWithImpl;
@override @useResult
$Res call({
 RoleKind kind, String firstName, String lastName, String email, String lrn, GradeLevel gradeLevel, List<String> parentIds, List<String> childIds, PrincipalPosition position
});




}
/// @nodoc
class __$UserFormStateCopyWithImpl<$Res>
    implements _$UserFormStateCopyWith<$Res> {
  __$UserFormStateCopyWithImpl(this._self, this._then);

  final _UserFormState _self;
  final $Res Function(_UserFormState) _then;

/// Create a copy of UserFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? lrn = null,Object? gradeLevel = null,Object? parentIds = null,Object? childIds = null,Object? position = null,}) {
  return _then(_UserFormState(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RoleKind,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,lrn: null == lrn ? _self.lrn : lrn // ignore: cast_nullable_to_non_nullable
as String,gradeLevel: null == gradeLevel ? _self.gradeLevel : gradeLevel // ignore: cast_nullable_to_non_nullable
as GradeLevel,parentIds: null == parentIds ? _self._parentIds : parentIds // ignore: cast_nullable_to_non_nullable
as List<String>,childIds: null == childIds ? _self._childIds : childIds // ignore: cast_nullable_to_non_nullable
as List<String>,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as PrincipalPosition,
  ));
}


}

// dart format on
