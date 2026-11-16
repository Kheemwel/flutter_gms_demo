// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'role_form_dialog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoleForm {

 String get name; RoleKind get kind; Set<Privilege> get privileges;
/// Create a copy of RoleForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleFormCopyWith<RoleForm> get copyWith => _$RoleFormCopyWithImpl<RoleForm>(this as RoleForm, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoleForm;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleForm&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&const DeepCollectionEquality().equals(other.privileges, _this.privileges));
}


@override
int get hashCode {
  final _this = this as RoleForm;
  return Object.hash(runtimeType,_this.name,_this.kind,const DeepCollectionEquality().hash(_this.privileges));
}

@override
String toString() {
  final _this = this as RoleForm;
  return 'RoleForm(name: ${_this.name}, kind: ${_this.kind}, privileges: ${_this.privileges})';
}


}

/// @nodoc
abstract mixin class $RoleFormCopyWith<$Res>  {
  factory $RoleFormCopyWith(RoleForm value, $Res Function(RoleForm) _then) = _$RoleFormCopyWithImpl;
@useResult
$Res call({
 String name, RoleKind kind, Set<Privilege> privileges
});




}
/// @nodoc
class _$RoleFormCopyWithImpl<$Res>
    implements $RoleFormCopyWith<$Res> {
  _$RoleFormCopyWithImpl(this._self, this._then);

  final RoleForm _self;
  final $Res Function(RoleForm) _then;

/// Create a copy of RoleForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? kind = null,Object? privileges = null,}) {
  return _then(RoleForm(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RoleKind,privileges: null == privileges ? _self.privileges : privileges // ignore: cast_nullable_to_non_nullable
as Set<Privilege>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleForm].
extension RoleFormPatterns on RoleForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleForm value)  $default,){
final _that = this;
switch (_that) {
case _RoleForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleForm value)?  $default,){
final _that = this;
switch (_that) {
case _RoleForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  RoleKind kind,  Set<Privilege> privileges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleForm() when $default != null:
return $default(_that.name,_that.kind,_that.privileges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  RoleKind kind,  Set<Privilege> privileges)  $default,) {final _that = this;
switch (_that) {
case _RoleForm():
return $default(_that.name,_that.kind,_that.privileges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  RoleKind kind,  Set<Privilege> privileges)?  $default,) {final _that = this;
switch (_that) {
case _RoleForm() when $default != null:
return $default(_that.name,_that.kind,_that.privileges);case _:
  return null;

}
}

}

/// @nodoc


class _RoleForm implements RoleForm {
  const _RoleForm({required this.name, required this.kind, required  Set<Privilege> privileges}): _privileges = privileges;
  

@override final  String name;
@override final  RoleKind kind;
 final  Set<Privilege> _privileges;
@override Set<Privilege> get privileges {
  if (_privileges is EqualUnmodifiableSetView) return _privileges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_privileges);
}


/// Create a copy of RoleForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleFormCopyWith<_RoleForm> get copyWith => __$RoleFormCopyWithImpl<_RoleForm>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleForm&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.privileges, _privileges));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,kind,const DeepCollectionEquality().hash(_privileges));
}

@override
String toString() {
    return 'RoleForm(name: $name, kind: $kind, privileges: $privileges)';
}


}

/// @nodoc
abstract mixin class _$RoleFormCopyWith<$Res> implements $RoleFormCopyWith<$Res> {
  factory _$RoleFormCopyWith(_RoleForm value, $Res Function(_RoleForm) _then) = __$RoleFormCopyWithImpl;
@override @useResult
$Res call({
 String name, RoleKind kind, Set<Privilege> privileges
});




}
/// @nodoc
class __$RoleFormCopyWithImpl<$Res>
    implements _$RoleFormCopyWith<$Res> {
  __$RoleFormCopyWithImpl(this._self, this._then);

  final _RoleForm _self;
  final $Res Function(_RoleForm) _then;

/// Create a copy of RoleForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? kind = null,Object? privileges = null,}) {
  return _then(_RoleForm(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RoleKind,privileges: null == privileges ? _self._privileges : privileges // ignore: cast_nullable_to_non_nullable
as Set<Privilege>,
  ));
}


}

// dart format on
