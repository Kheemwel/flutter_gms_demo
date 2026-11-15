// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UserProfile()';
}


}

/// @nodoc
class $UserProfileCopyWith<$Res>  {
$UserProfileCopyWith(UserProfile _, $Res Function(UserProfile) __);
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AdminProfile value)?  admin,TResult Function( GuidanceProfile value)?  guidance,TResult Function( TeacherProfile value)?  teacher,TResult Function( StudentProfile value)?  student,TResult Function( ParentProfile value)?  parent,TResult Function( PrincipalProfile value)?  principal,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AdminProfile() when admin != null:
return admin(_that);case GuidanceProfile() when guidance != null:
return guidance(_that);case TeacherProfile() when teacher != null:
return teacher(_that);case StudentProfile() when student != null:
return student(_that);case ParentProfile() when parent != null:
return parent(_that);case PrincipalProfile() when principal != null:
return principal(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AdminProfile value)  admin,required TResult Function( GuidanceProfile value)  guidance,required TResult Function( TeacherProfile value)  teacher,required TResult Function( StudentProfile value)  student,required TResult Function( ParentProfile value)  parent,required TResult Function( PrincipalProfile value)  principal,}){
final _that = this;
switch (_that) {
case AdminProfile():
return admin(_that);case GuidanceProfile():
return guidance(_that);case TeacherProfile():
return teacher(_that);case StudentProfile():
return student(_that);case ParentProfile():
return parent(_that);case PrincipalProfile():
return principal(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AdminProfile value)?  admin,TResult? Function( GuidanceProfile value)?  guidance,TResult? Function( TeacherProfile value)?  teacher,TResult? Function( StudentProfile value)?  student,TResult? Function( ParentProfile value)?  parent,TResult? Function( PrincipalProfile value)?  principal,}){
final _that = this;
switch (_that) {
case AdminProfile() when admin != null:
return admin(_that);case GuidanceProfile() when guidance != null:
return guidance(_that);case TeacherProfile() when teacher != null:
return teacher(_that);case StudentProfile() when student != null:
return student(_that);case ParentProfile() when parent != null:
return parent(_that);case PrincipalProfile() when principal != null:
return principal(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  admin,TResult Function()?  guidance,TResult Function()?  teacher,TResult Function( String lrn,  GradeLevel gradeLevel)?  student,TResult Function( List<String> childIds)?  parent,TResult Function( PrincipalPosition position)?  principal,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AdminProfile() when admin != null:
return admin();case GuidanceProfile() when guidance != null:
return guidance();case TeacherProfile() when teacher != null:
return teacher();case StudentProfile() when student != null:
return student(_that.lrn,_that.gradeLevel);case ParentProfile() when parent != null:
return parent(_that.childIds);case PrincipalProfile() when principal != null:
return principal(_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  admin,required TResult Function()  guidance,required TResult Function()  teacher,required TResult Function( String lrn,  GradeLevel gradeLevel)  student,required TResult Function( List<String> childIds)  parent,required TResult Function( PrincipalPosition position)  principal,}) {final _that = this;
switch (_that) {
case AdminProfile():
return admin();case GuidanceProfile():
return guidance();case TeacherProfile():
return teacher();case StudentProfile():
return student(_that.lrn,_that.gradeLevel);case ParentProfile():
return parent(_that.childIds);case PrincipalProfile():
return principal(_that.position);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  admin,TResult? Function()?  guidance,TResult? Function()?  teacher,TResult? Function( String lrn,  GradeLevel gradeLevel)?  student,TResult? Function( List<String> childIds)?  parent,TResult? Function( PrincipalPosition position)?  principal,}) {final _that = this;
switch (_that) {
case AdminProfile() when admin != null:
return admin();case GuidanceProfile() when guidance != null:
return guidance();case TeacherProfile() when teacher != null:
return teacher();case StudentProfile() when student != null:
return student(_that.lrn,_that.gradeLevel);case ParentProfile() when parent != null:
return parent(_that.childIds);case PrincipalProfile() when principal != null:
return principal(_that.position);case _:
  return null;

}
}

}

/// @nodoc


class AdminProfile implements UserProfile {
  const AdminProfile();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UserProfile.admin()';
}


}




/// @nodoc


class GuidanceProfile implements UserProfile {
  const GuidanceProfile();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GuidanceProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UserProfile.guidance()';
}


}




/// @nodoc


class TeacherProfile implements UserProfile {
  const TeacherProfile();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UserProfile.teacher()';
}


}




/// @nodoc


class StudentProfile implements UserProfile {
  const StudentProfile({required this.lrn, required this.gradeLevel});
  

 final  String lrn;
 final  GradeLevel gradeLevel;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentProfileCopyWith<StudentProfile> get copyWith => _$StudentProfileCopyWithImpl<StudentProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentProfile&&(identical(other.lrn, lrn) || other.lrn == lrn)&&(identical(other.gradeLevel, gradeLevel) || other.gradeLevel == gradeLevel));
}


@override
int get hashCode {
    return Object.hash(runtimeType,lrn,gradeLevel);
}

@override
String toString() {
    return 'UserProfile.student(lrn: $lrn, gradeLevel: $gradeLevel)';
}


}

/// @nodoc
abstract mixin class $StudentProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory $StudentProfileCopyWith(StudentProfile value, $Res Function(StudentProfile) _then) = _$StudentProfileCopyWithImpl;
@useResult
$Res call({
 String lrn, GradeLevel gradeLevel
});




}
/// @nodoc
class _$StudentProfileCopyWithImpl<$Res>
    implements $StudentProfileCopyWith<$Res> {
  _$StudentProfileCopyWithImpl(this._self, this._then);

  final StudentProfile _self;
  final $Res Function(StudentProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lrn = null,Object? gradeLevel = null,}) {
  return _then(StudentProfile(
lrn: null == lrn ? _self.lrn : lrn // ignore: cast_nullable_to_non_nullable
as String,gradeLevel: null == gradeLevel ? _self.gradeLevel : gradeLevel // ignore: cast_nullable_to_non_nullable
as GradeLevel,
  ));
}


}

/// @nodoc


class ParentProfile implements UserProfile {
  const ParentProfile({required  List<String> childIds}): _childIds = childIds;
  

 final  List<String> _childIds;
 List<String> get childIds {
  if (_childIds is EqualUnmodifiableListView) return _childIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_childIds);
}


/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParentProfileCopyWith<ParentProfile> get copyWith => _$ParentProfileCopyWithImpl<ParentProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ParentProfile&&const DeepCollectionEquality().equals(other.childIds, _childIds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_childIds));
}

@override
String toString() {
    return 'UserProfile.parent(childIds: $childIds)';
}


}

/// @nodoc
abstract mixin class $ParentProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory $ParentProfileCopyWith(ParentProfile value, $Res Function(ParentProfile) _then) = _$ParentProfileCopyWithImpl;
@useResult
$Res call({
 List<String> childIds
});




}
/// @nodoc
class _$ParentProfileCopyWithImpl<$Res>
    implements $ParentProfileCopyWith<$Res> {
  _$ParentProfileCopyWithImpl(this._self, this._then);

  final ParentProfile _self;
  final $Res Function(ParentProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? childIds = null,}) {
  return _then(ParentProfile(
childIds: null == childIds ? _self._childIds : childIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class PrincipalProfile implements UserProfile {
  const PrincipalProfile({required this.position});
  

 final  PrincipalPosition position;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrincipalProfileCopyWith<PrincipalProfile> get copyWith => _$PrincipalProfileCopyWithImpl<PrincipalProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PrincipalProfile&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode {
    return Object.hash(runtimeType,position);
}

@override
String toString() {
    return 'UserProfile.principal(position: $position)';
}


}

/// @nodoc
abstract mixin class $PrincipalProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory $PrincipalProfileCopyWith(PrincipalProfile value, $Res Function(PrincipalProfile) _then) = _$PrincipalProfileCopyWithImpl;
@useResult
$Res call({
 PrincipalPosition position
});




}
/// @nodoc
class _$PrincipalProfileCopyWithImpl<$Res>
    implements $PrincipalProfileCopyWith<$Res> {
  _$PrincipalProfileCopyWithImpl(this._self, this._then);

  final PrincipalProfile _self;
  final $Res Function(PrincipalProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? position = null,}) {
  return _then(PrincipalProfile(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as PrincipalPosition,
  ));
}


}

// dart format on
