// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FormRequestPayload {

 String get teacherId; String get teacherName; String get reason;
/// Create a copy of FormRequestPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormRequestPayloadCopyWith<FormRequestPayload> get copyWith => _$FormRequestPayloadCopyWithImpl<FormRequestPayload>(this as FormRequestPayload, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FormRequestPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormRequestPayload&&(identical(other.teacherId, _this.teacherId) || other.teacherId == _this.teacherId)&&(identical(other.teacherName, _this.teacherName) || other.teacherName == _this.teacherName)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}


@override
int get hashCode {
  final _this = this as FormRequestPayload;
  return Object.hash(runtimeType,_this.teacherId,_this.teacherName,_this.reason);
}

@override
String toString() {
  final _this = this as FormRequestPayload;
  return 'FormRequestPayload(teacherId: ${_this.teacherId}, teacherName: ${_this.teacherName}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $FormRequestPayloadCopyWith<$Res>  {
  factory $FormRequestPayloadCopyWith(FormRequestPayload value, $Res Function(FormRequestPayload) _then) = _$FormRequestPayloadCopyWithImpl;
@useResult
$Res call({
 String teacherId, String teacherName, String reason
});




}
/// @nodoc
class _$FormRequestPayloadCopyWithImpl<$Res>
    implements $FormRequestPayloadCopyWith<$Res> {
  _$FormRequestPayloadCopyWithImpl(this._self, this._then);

  final FormRequestPayload _self;
  final $Res Function(FormRequestPayload) _then;

/// Create a copy of FormRequestPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teacherId = null,Object? teacherName = null,Object? reason = null,}) {
  return _then(_self.copyWith(
teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FormRequestPayload].
extension FormRequestPayloadPatterns on FormRequestPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeVisitationRequestPayload value)?  homeVisitation,TResult Function( ViolationRequestPayload value)?  violation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeVisitationRequestPayload() when homeVisitation != null:
return homeVisitation(_that);case ViolationRequestPayload() when violation != null:
return violation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeVisitationRequestPayload value)  homeVisitation,required TResult Function( ViolationRequestPayload value)  violation,}){
final _that = this;
switch (_that) {
case HomeVisitationRequestPayload():
return homeVisitation(_that);case ViolationRequestPayload():
return violation(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeVisitationRequestPayload value)?  homeVisitation,TResult? Function( ViolationRequestPayload value)?  violation,}){
final _that = this;
switch (_that) {
case HomeVisitationRequestPayload() when homeVisitation != null:
return homeVisitation(_that);case ViolationRequestPayload() when violation != null:
return violation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String teacherId,  String teacherName,  String studentId,  String studentName,  String reason)?  homeVisitation,TResult Function( String teacherId,  String teacherName,  List<String> studentIds,  List<String> studentNames,  String reason)?  violation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeVisitationRequestPayload() when homeVisitation != null:
return homeVisitation(_that.teacherId,_that.teacherName,_that.studentId,_that.studentName,_that.reason);case ViolationRequestPayload() when violation != null:
return violation(_that.teacherId,_that.teacherName,_that.studentIds,_that.studentNames,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String teacherId,  String teacherName,  String studentId,  String studentName,  String reason)  homeVisitation,required TResult Function( String teacherId,  String teacherName,  List<String> studentIds,  List<String> studentNames,  String reason)  violation,}) {final _that = this;
switch (_that) {
case HomeVisitationRequestPayload():
return homeVisitation(_that.teacherId,_that.teacherName,_that.studentId,_that.studentName,_that.reason);case ViolationRequestPayload():
return violation(_that.teacherId,_that.teacherName,_that.studentIds,_that.studentNames,_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String teacherId,  String teacherName,  String studentId,  String studentName,  String reason)?  homeVisitation,TResult? Function( String teacherId,  String teacherName,  List<String> studentIds,  List<String> studentNames,  String reason)?  violation,}) {final _that = this;
switch (_that) {
case HomeVisitationRequestPayload() when homeVisitation != null:
return homeVisitation(_that.teacherId,_that.teacherName,_that.studentId,_that.studentName,_that.reason);case ViolationRequestPayload() when violation != null:
return violation(_that.teacherId,_that.teacherName,_that.studentIds,_that.studentNames,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class HomeVisitationRequestPayload implements FormRequestPayload {
  const HomeVisitationRequestPayload({required this.teacherId, required this.teacherName, required this.studentId, required this.studentName, required this.reason});
  

@override final  String teacherId;
@override final  String teacherName;
 final  String studentId;
 final  String studentName;
@override final  String reason;

/// Create a copy of FormRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeVisitationRequestPayloadCopyWith<HomeVisitationRequestPayload> get copyWith => _$HomeVisitationRequestPayloadCopyWithImpl<HomeVisitationRequestPayload>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeVisitationRequestPayload&&(identical(other.teacherId, teacherId) || other.teacherId == teacherId)&&(identical(other.teacherName, teacherName) || other.teacherName == teacherName)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,teacherId,teacherName,studentId,studentName,reason);
}

@override
String toString() {
    return 'FormRequestPayload.homeVisitation(teacherId: $teacherId, teacherName: $teacherName, studentId: $studentId, studentName: $studentName, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $HomeVisitationRequestPayloadCopyWith<$Res> implements $FormRequestPayloadCopyWith<$Res> {
  factory $HomeVisitationRequestPayloadCopyWith(HomeVisitationRequestPayload value, $Res Function(HomeVisitationRequestPayload) _then) = _$HomeVisitationRequestPayloadCopyWithImpl;
@override @useResult
$Res call({
 String teacherId, String teacherName, String studentId, String studentName, String reason
});




}
/// @nodoc
class _$HomeVisitationRequestPayloadCopyWithImpl<$Res>
    implements $HomeVisitationRequestPayloadCopyWith<$Res> {
  _$HomeVisitationRequestPayloadCopyWithImpl(this._self, this._then);

  final HomeVisitationRequestPayload _self;
  final $Res Function(HomeVisitationRequestPayload) _then;

/// Create a copy of FormRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teacherId = null,Object? teacherName = null,Object? studentId = null,Object? studentName = null,Object? reason = null,}) {
  return _then(HomeVisitationRequestPayload(
teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ViolationRequestPayload implements FormRequestPayload {
  const ViolationRequestPayload({required this.teacherId, required this.teacherName, required  List<String> studentIds, required  List<String> studentNames, required this.reason}): _studentIds = studentIds,_studentNames = studentNames;
  

@override final  String teacherId;
@override final  String teacherName;
 final  List<String> _studentIds;
 List<String> get studentIds {
  if (_studentIds is EqualUnmodifiableListView) return _studentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studentIds);
}

 final  List<String> _studentNames;
 List<String> get studentNames {
  if (_studentNames is EqualUnmodifiableListView) return _studentNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_studentNames);
}

@override final  String reason;

/// Create a copy of FormRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViolationRequestPayloadCopyWith<ViolationRequestPayload> get copyWith => _$ViolationRequestPayloadCopyWithImpl<ViolationRequestPayload>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ViolationRequestPayload&&(identical(other.teacherId, teacherId) || other.teacherId == teacherId)&&(identical(other.teacherName, teacherName) || other.teacherName == teacherName)&&const DeepCollectionEquality().equals(other.studentIds, _studentIds)&&const DeepCollectionEquality().equals(other.studentNames, _studentNames)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,teacherId,teacherName,const DeepCollectionEquality().hash(_studentIds),const DeepCollectionEquality().hash(_studentNames),reason);
}

@override
String toString() {
    return 'FormRequestPayload.violation(teacherId: $teacherId, teacherName: $teacherName, studentIds: $studentIds, studentNames: $studentNames, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ViolationRequestPayloadCopyWith<$Res> implements $FormRequestPayloadCopyWith<$Res> {
  factory $ViolationRequestPayloadCopyWith(ViolationRequestPayload value, $Res Function(ViolationRequestPayload) _then) = _$ViolationRequestPayloadCopyWithImpl;
@override @useResult
$Res call({
 String teacherId, String teacherName, List<String> studentIds, List<String> studentNames, String reason
});




}
/// @nodoc
class _$ViolationRequestPayloadCopyWithImpl<$Res>
    implements $ViolationRequestPayloadCopyWith<$Res> {
  _$ViolationRequestPayloadCopyWithImpl(this._self, this._then);

  final ViolationRequestPayload _self;
  final $Res Function(ViolationRequestPayload) _then;

/// Create a copy of FormRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teacherId = null,Object? teacherName = null,Object? studentIds = null,Object? studentNames = null,Object? reason = null,}) {
  return _then(ViolationRequestPayload(
teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,studentIds: null == studentIds ? _self._studentIds : studentIds // ignore: cast_nullable_to_non_nullable
as List<String>,studentNames: null == studentNames ? _self._studentNames : studentNames // ignore: cast_nullable_to_non_nullable
as List<String>,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FormRequest {

 String get id; FormRequestStatus get status; String get requestedByUserId; DateTime get createdAt; FormRequestPayload get payload;/// When approved, the ID of the spawned [Form].
 String? get resultingFormId;/// When disapproved, the reason given by guidance.
 String? get disapprovalReason;
/// Create a copy of FormRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormRequestCopyWith<FormRequest> get copyWith => _$FormRequestCopyWithImpl<FormRequest>(this as FormRequest, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FormRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormRequest&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.requestedByUserId, _this.requestedByUserId) || other.requestedByUserId == _this.requestedByUserId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.payload, _this.payload) || other.payload == _this.payload)&&(identical(other.resultingFormId, _this.resultingFormId) || other.resultingFormId == _this.resultingFormId)&&(identical(other.disapprovalReason, _this.disapprovalReason) || other.disapprovalReason == _this.disapprovalReason));
}


@override
int get hashCode {
  final _this = this as FormRequest;
  return Object.hash(runtimeType,_this.id,_this.status,_this.requestedByUserId,_this.createdAt,_this.payload,_this.resultingFormId,_this.disapprovalReason);
}

@override
String toString() {
  final _this = this as FormRequest;
  return 'FormRequest(id: ${_this.id}, status: ${_this.status}, requestedByUserId: ${_this.requestedByUserId}, createdAt: ${_this.createdAt}, payload: ${_this.payload}, resultingFormId: ${_this.resultingFormId}, disapprovalReason: ${_this.disapprovalReason})';
}


}

/// @nodoc
abstract mixin class $FormRequestCopyWith<$Res>  {
  factory $FormRequestCopyWith(FormRequest value, $Res Function(FormRequest) _then) = _$FormRequestCopyWithImpl;
@useResult
$Res call({
 String id, FormRequestStatus status, String requestedByUserId, DateTime createdAt, FormRequestPayload payload, String? resultingFormId, String? disapprovalReason
});


$FormRequestPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class _$FormRequestCopyWithImpl<$Res>
    implements $FormRequestCopyWith<$Res> {
  _$FormRequestCopyWithImpl(this._self, this._then);

  final FormRequest _self;
  final $Res Function(FormRequest) _then;

/// Create a copy of FormRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? requestedByUserId = null,Object? createdAt = null,Object? payload = null,Object? resultingFormId = freezed,Object? disapprovalReason = freezed,}) {
  return _then(FormRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormRequestStatus,requestedByUserId: null == requestedByUserId ? _self.requestedByUserId : requestedByUserId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as FormRequestPayload,resultingFormId: freezed == resultingFormId ? _self.resultingFormId : resultingFormId // ignore: cast_nullable_to_non_nullable
as String?,disapprovalReason: freezed == disapprovalReason ? _self.disapprovalReason : disapprovalReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FormRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormRequestPayloadCopyWith<$Res> get payload {
  
  return $FormRequestPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}


/// Adds pattern-matching-related methods to [FormRequest].
extension FormRequestPatterns on FormRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormRequest value)  $default,){
final _that = this;
switch (_that) {
case _FormRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FormRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FormRequestStatus status,  String requestedByUserId,  DateTime createdAt,  FormRequestPayload payload,  String? resultingFormId,  String? disapprovalReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormRequest() when $default != null:
return $default(_that.id,_that.status,_that.requestedByUserId,_that.createdAt,_that.payload,_that.resultingFormId,_that.disapprovalReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FormRequestStatus status,  String requestedByUserId,  DateTime createdAt,  FormRequestPayload payload,  String? resultingFormId,  String? disapprovalReason)  $default,) {final _that = this;
switch (_that) {
case _FormRequest():
return $default(_that.id,_that.status,_that.requestedByUserId,_that.createdAt,_that.payload,_that.resultingFormId,_that.disapprovalReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FormRequestStatus status,  String requestedByUserId,  DateTime createdAt,  FormRequestPayload payload,  String? resultingFormId,  String? disapprovalReason)?  $default,) {final _that = this;
switch (_that) {
case _FormRequest() when $default != null:
return $default(_that.id,_that.status,_that.requestedByUserId,_that.createdAt,_that.payload,_that.resultingFormId,_that.disapprovalReason);case _:
  return null;

}
}

}

/// @nodoc


class _FormRequest extends FormRequest {
  const _FormRequest({required this.id, required this.status, required this.requestedByUserId, required this.createdAt, required this.payload, this.resultingFormId, this.disapprovalReason}): super._();
  

@override final  String id;
@override final  FormRequestStatus status;
@override final  String requestedByUserId;
@override final  DateTime createdAt;
@override final  FormRequestPayload payload;
/// When approved, the ID of the spawned [Form].
@override final  String? resultingFormId;
/// When disapproved, the reason given by guidance.
@override final  String? disapprovalReason;

/// Create a copy of FormRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormRequestCopyWith<_FormRequest> get copyWith => __$FormRequestCopyWithImpl<_FormRequest>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedByUserId, requestedByUserId) || other.requestedByUserId == requestedByUserId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.resultingFormId, resultingFormId) || other.resultingFormId == resultingFormId)&&(identical(other.disapprovalReason, disapprovalReason) || other.disapprovalReason == disapprovalReason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,status,requestedByUserId,createdAt,payload,resultingFormId,disapprovalReason);
}

@override
String toString() {
    return 'FormRequest(id: $id, status: $status, requestedByUserId: $requestedByUserId, createdAt: $createdAt, payload: $payload, resultingFormId: $resultingFormId, disapprovalReason: $disapprovalReason)';
}


}

/// @nodoc
abstract mixin class _$FormRequestCopyWith<$Res> implements $FormRequestCopyWith<$Res> {
  factory _$FormRequestCopyWith(_FormRequest value, $Res Function(_FormRequest) _then) = __$FormRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, FormRequestStatus status, String requestedByUserId, DateTime createdAt, FormRequestPayload payload, String? resultingFormId, String? disapprovalReason
});


@override $FormRequestPayloadCopyWith<$Res> get payload;

}
/// @nodoc
class __$FormRequestCopyWithImpl<$Res>
    implements _$FormRequestCopyWith<$Res> {
  __$FormRequestCopyWithImpl(this._self, this._then);

  final _FormRequest _self;
  final $Res Function(_FormRequest) _then;

/// Create a copy of FormRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? requestedByUserId = null,Object? createdAt = null,Object? payload = null,Object? resultingFormId = freezed,Object? disapprovalReason = freezed,}) {
  return _then(_FormRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormRequestStatus,requestedByUserId: null == requestedByUserId ? _self.requestedByUserId : requestedByUserId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as FormRequestPayload,resultingFormId: freezed == resultingFormId ? _self.resultingFormId : resultingFormId // ignore: cast_nullable_to_non_nullable
as String?,disapprovalReason: freezed == disapprovalReason ? _self.disapprovalReason : disapprovalReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FormRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormRequestPayloadCopyWith<$Res> get payload {
  
  return $FormRequestPayloadCopyWith<$Res>(_self.payload, (value) {
    return _then(_self.copyWith(payload: value));
  });
}
}

// dart format on
