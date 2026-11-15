// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserAccount {

 String get id; String get firstName; String get lastName; String get email; String get roleId; UserProfile get profile; bool get isArchived; int get totalLogin; bool get mustChangePassword; DateTime? get lastLogin; String? get rememberToken;
/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAccountCopyWith<UserAccount> get copyWith => _$UserAccountCopyWithImpl<UserAccount>(this as UserAccount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserAccount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAccount&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.roleId, _this.roleId) || other.roleId == _this.roleId)&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&(identical(other.isArchived, _this.isArchived) || other.isArchived == _this.isArchived)&&(identical(other.totalLogin, _this.totalLogin) || other.totalLogin == _this.totalLogin)&&(identical(other.mustChangePassword, _this.mustChangePassword) || other.mustChangePassword == _this.mustChangePassword)&&(identical(other.lastLogin, _this.lastLogin) || other.lastLogin == _this.lastLogin)&&(identical(other.rememberToken, _this.rememberToken) || other.rememberToken == _this.rememberToken));
}


@override
int get hashCode {
  final _this = this as UserAccount;
  return Object.hash(runtimeType,_this.id,_this.firstName,_this.lastName,_this.email,_this.roleId,_this.profile,_this.isArchived,_this.totalLogin,_this.mustChangePassword,_this.lastLogin,_this.rememberToken);
}

@override
String toString() {
  final _this = this as UserAccount;
  return 'UserAccount(id: ${_this.id}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, email: ${_this.email}, roleId: ${_this.roleId}, profile: ${_this.profile}, isArchived: ${_this.isArchived}, totalLogin: ${_this.totalLogin}, mustChangePassword: ${_this.mustChangePassword}, lastLogin: ${_this.lastLogin}, rememberToken: ${_this.rememberToken})';
}


}

/// @nodoc
abstract mixin class $UserAccountCopyWith<$Res>  {
  factory $UserAccountCopyWith(UserAccount value, $Res Function(UserAccount) _then) = _$UserAccountCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String lastName, String email, String roleId, UserProfile profile, bool isArchived, int totalLogin, bool mustChangePassword, DateTime? lastLogin, String? rememberToken
});


$UserProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$UserAccountCopyWithImpl<$Res>
    implements $UserAccountCopyWith<$Res> {
  _$UserAccountCopyWithImpl(this._self, this._then);

  final UserAccount _self;
  final $Res Function(UserAccount) _then;

/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? roleId = null,Object? profile = null,Object? isArchived = null,Object? totalLogin = null,Object? mustChangePassword = null,Object? lastLogin = freezed,Object? rememberToken = freezed,}) {
  return _then(UserAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,totalLogin: null == totalLogin ? _self.totalLogin : totalLogin // ignore: cast_nullable_to_non_nullable
as int,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,rememberToken: freezed == rememberToken ? _self.rememberToken : rememberToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res> get profile {
  
  return $UserProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserAccount].
extension UserAccountPatterns on UserAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAccount value)  $default,){
final _that = this;
switch (_that) {
case _UserAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAccount value)?  $default,){
final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String email,  String roleId,  UserProfile profile,  bool isArchived,  int totalLogin,  bool mustChangePassword,  DateTime? lastLogin,  String? rememberToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.roleId,_that.profile,_that.isArchived,_that.totalLogin,_that.mustChangePassword,_that.lastLogin,_that.rememberToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String lastName,  String email,  String roleId,  UserProfile profile,  bool isArchived,  int totalLogin,  bool mustChangePassword,  DateTime? lastLogin,  String? rememberToken)  $default,) {final _that = this;
switch (_that) {
case _UserAccount():
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.roleId,_that.profile,_that.isArchived,_that.totalLogin,_that.mustChangePassword,_that.lastLogin,_that.rememberToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String lastName,  String email,  String roleId,  UserProfile profile,  bool isArchived,  int totalLogin,  bool mustChangePassword,  DateTime? lastLogin,  String? rememberToken)?  $default,) {final _that = this;
switch (_that) {
case _UserAccount() when $default != null:
return $default(_that.id,_that.firstName,_that.lastName,_that.email,_that.roleId,_that.profile,_that.isArchived,_that.totalLogin,_that.mustChangePassword,_that.lastLogin,_that.rememberToken);case _:
  return null;

}
}

}

/// @nodoc


class _UserAccount extends UserAccount {
  const _UserAccount({required this.id, required this.firstName, required this.lastName, required this.email, required this.roleId, required this.profile, required this.isArchived, required this.totalLogin, this.mustChangePassword = false, this.lastLogin, this.rememberToken}): super._();
  

@override final  String id;
@override final  String firstName;
@override final  String lastName;
@override final  String email;
@override final  String roleId;
@override final  UserProfile profile;
@override final  bool isArchived;
@override final  int totalLogin;
@override@JsonKey() final  bool mustChangePassword;
@override final  DateTime? lastLogin;
@override final  String? rememberToken;

/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAccountCopyWith<_UserAccount> get copyWith => __$UserAccountCopyWithImpl<_UserAccount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.totalLogin, totalLogin) || other.totalLogin == totalLogin)&&(identical(other.mustChangePassword, mustChangePassword) || other.mustChangePassword == mustChangePassword)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.rememberToken, rememberToken) || other.rememberToken == rememberToken));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,firstName,lastName,email,roleId,profile,isArchived,totalLogin,mustChangePassword,lastLogin,rememberToken);
}

@override
String toString() {
    return 'UserAccount(id: $id, firstName: $firstName, lastName: $lastName, email: $email, roleId: $roleId, profile: $profile, isArchived: $isArchived, totalLogin: $totalLogin, mustChangePassword: $mustChangePassword, lastLogin: $lastLogin, rememberToken: $rememberToken)';
}


}

/// @nodoc
abstract mixin class _$UserAccountCopyWith<$Res> implements $UserAccountCopyWith<$Res> {
  factory _$UserAccountCopyWith(_UserAccount value, $Res Function(_UserAccount) _then) = __$UserAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String lastName, String email, String roleId, UserProfile profile, bool isArchived, int totalLogin, bool mustChangePassword, DateTime? lastLogin, String? rememberToken
});


@override $UserProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$UserAccountCopyWithImpl<$Res>
    implements _$UserAccountCopyWith<$Res> {
  __$UserAccountCopyWithImpl(this._self, this._then);

  final _UserAccount _self;
  final $Res Function(_UserAccount) _then;

/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? roleId = null,Object? profile = null,Object? isArchived = null,Object? totalLogin = null,Object? mustChangePassword = null,Object? lastLogin = freezed,Object? rememberToken = freezed,}) {
  return _then(_UserAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,totalLogin: null == totalLogin ? _self.totalLogin : totalLogin // ignore: cast_nullable_to_non_nullable
as int,mustChangePassword: null == mustChangePassword ? _self.mustChangePassword : mustChangePassword // ignore: cast_nullable_to_non_nullable
as bool,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,rememberToken: freezed == rememberToken ? _self.rememberToken : rememberToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserAccount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res> get profile {
  
  return $UserProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
