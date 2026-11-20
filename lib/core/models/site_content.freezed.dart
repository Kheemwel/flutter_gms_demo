// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SiteContent {

 String get title; String get subtitle; String get schoolName;/// Preset gradient palette id ("indigo", "teal", …).
/// Real logo upload lands in the assets batch.
 String get logoPreset;
/// Create a copy of SiteContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SiteContentCopyWith<SiteContent> get copyWith => _$SiteContentCopyWithImpl<SiteContent>(this as SiteContent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SiteContent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SiteContent&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.schoolName, _this.schoolName) || other.schoolName == _this.schoolName)&&(identical(other.logoPreset, _this.logoPreset) || other.logoPreset == _this.logoPreset));
}


@override
int get hashCode {
  final _this = this as SiteContent;
  return Object.hash(runtimeType,_this.title,_this.subtitle,_this.schoolName,_this.logoPreset);
}

@override
String toString() {
  final _this = this as SiteContent;
  return 'SiteContent(title: ${_this.title}, subtitle: ${_this.subtitle}, schoolName: ${_this.schoolName}, logoPreset: ${_this.logoPreset})';
}


}

/// @nodoc
abstract mixin class $SiteContentCopyWith<$Res>  {
  factory $SiteContentCopyWith(SiteContent value, $Res Function(SiteContent) _then) = _$SiteContentCopyWithImpl;
@useResult
$Res call({
 String title, String subtitle, String schoolName, String logoPreset
});




}
/// @nodoc
class _$SiteContentCopyWithImpl<$Res>
    implements $SiteContentCopyWith<$Res> {
  _$SiteContentCopyWithImpl(this._self, this._then);

  final SiteContent _self;
  final $Res Function(SiteContent) _then;

/// Create a copy of SiteContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,Object? schoolName = null,Object? logoPreset = null,}) {
  return _then(SiteContent(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,schoolName: null == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String,logoPreset: null == logoPreset ? _self.logoPreset : logoPreset // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SiteContent].
extension SiteContentPatterns on SiteContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SiteContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SiteContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SiteContent value)  $default,){
final _that = this;
switch (_that) {
case _SiteContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SiteContent value)?  $default,){
final _that = this;
switch (_that) {
case _SiteContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String subtitle,  String schoolName,  String logoPreset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SiteContent() when $default != null:
return $default(_that.title,_that.subtitle,_that.schoolName,_that.logoPreset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String subtitle,  String schoolName,  String logoPreset)  $default,) {final _that = this;
switch (_that) {
case _SiteContent():
return $default(_that.title,_that.subtitle,_that.schoolName,_that.logoPreset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String subtitle,  String schoolName,  String logoPreset)?  $default,) {final _that = this;
switch (_that) {
case _SiteContent() when $default != null:
return $default(_that.title,_that.subtitle,_that.schoolName,_that.logoPreset);case _:
  return null;

}
}

}

/// @nodoc


class _SiteContent implements SiteContent {
  const _SiteContent({required this.title, required this.subtitle, required this.schoolName, required this.logoPreset});
  

@override final  String title;
@override final  String subtitle;
@override final  String schoolName;
/// Preset gradient palette id ("indigo", "teal", …).
/// Real logo upload lands in the assets batch.
@override final  String logoPreset;

/// Create a copy of SiteContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SiteContentCopyWith<_SiteContent> get copyWith => __$SiteContentCopyWithImpl<_SiteContent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SiteContent&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.schoolName, schoolName) || other.schoolName == schoolName)&&(identical(other.logoPreset, logoPreset) || other.logoPreset == logoPreset));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,subtitle,schoolName,logoPreset);
}

@override
String toString() {
    return 'SiteContent(title: $title, subtitle: $subtitle, schoolName: $schoolName, logoPreset: $logoPreset)';
}


}

/// @nodoc
abstract mixin class _$SiteContentCopyWith<$Res> implements $SiteContentCopyWith<$Res> {
  factory _$SiteContentCopyWith(_SiteContent value, $Res Function(_SiteContent) _then) = __$SiteContentCopyWithImpl;
@override @useResult
$Res call({
 String title, String subtitle, String schoolName, String logoPreset
});




}
/// @nodoc
class __$SiteContentCopyWithImpl<$Res>
    implements _$SiteContentCopyWith<$Res> {
  __$SiteContentCopyWithImpl(this._self, this._then);

  final _SiteContent _self;
  final $Res Function(_SiteContent) _then;

/// Create a copy of SiteContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,Object? schoolName = null,Object? logoPreset = null,}) {
  return _then(_SiteContent(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,schoolName: null == schoolName ? _self.schoolName : schoolName // ignore: cast_nullable_to_non_nullable
as String,logoPreset: null == logoPreset ? _self.logoPreset : logoPreset // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
