// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FormData {

 String get teacherId; String get teacherName; String get guidanceId; String get guidanceName; Map<String, String> get fields; Map<SignerRole, String> get signatures;
/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormDataCopyWith<FormData> get copyWith => _$FormDataCopyWithImpl<FormData>(this as FormData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FormData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormData&&(identical(other.teacherId, _this.teacherId) || other.teacherId == _this.teacherId)&&(identical(other.teacherName, _this.teacherName) || other.teacherName == _this.teacherName)&&(identical(other.guidanceId, _this.guidanceId) || other.guidanceId == _this.guidanceId)&&(identical(other.guidanceName, _this.guidanceName) || other.guidanceName == _this.guidanceName)&&const DeepCollectionEquality().equals(other.fields, _this.fields)&&const DeepCollectionEquality().equals(other.signatures, _this.signatures));
}


@override
int get hashCode {
  final _this = this as FormData;
  return Object.hash(runtimeType,_this.teacherId,_this.teacherName,_this.guidanceId,_this.guidanceName,const DeepCollectionEquality().hash(_this.fields),const DeepCollectionEquality().hash(_this.signatures));
}

@override
String toString() {
  final _this = this as FormData;
  return 'FormData(teacherId: ${_this.teacherId}, teacherName: ${_this.teacherName}, guidanceId: ${_this.guidanceId}, guidanceName: ${_this.guidanceName}, fields: ${_this.fields}, signatures: ${_this.signatures})';
}


}

/// @nodoc
abstract mixin class $FormDataCopyWith<$Res>  {
  factory $FormDataCopyWith(FormData value, $Res Function(FormData) _then) = _$FormDataCopyWithImpl;
@useResult
$Res call({
 String teacherId, String teacherName, String guidanceId, String guidanceName, Map<String, String> fields, Map<SignerRole, String> signatures
});




}
/// @nodoc
class _$FormDataCopyWithImpl<$Res>
    implements $FormDataCopyWith<$Res> {
  _$FormDataCopyWithImpl(this._self, this._then);

  final FormData _self;
  final $Res Function(FormData) _then;

/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teacherId = null,Object? teacherName = null,Object? guidanceId = null,Object? guidanceName = null,Object? fields = null,Object? signatures = null,}) {
  return _then(_self.copyWith(
teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,guidanceId: null == guidanceId ? _self.guidanceId : guidanceId // ignore: cast_nullable_to_non_nullable
as String,guidanceName: null == guidanceName ? _self.guidanceName : guidanceName // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, String>,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as Map<SignerRole, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FormData].
extension FormDataPatterns on FormData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeVisitationFormData value)?  homeVisitation,TResult Function( ViolationFormData value)?  violation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeVisitationFormData() when homeVisitation != null:
return homeVisitation(_that);case ViolationFormData() when violation != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeVisitationFormData value)  homeVisitation,required TResult Function( ViolationFormData value)  violation,}){
final _that = this;
switch (_that) {
case HomeVisitationFormData():
return homeVisitation(_that);case ViolationFormData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeVisitationFormData value)?  homeVisitation,TResult? Function( ViolationFormData value)?  violation,}){
final _that = this;
switch (_that) {
case HomeVisitationFormData() when homeVisitation != null:
return homeVisitation(_that);case ViolationFormData() when violation != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String studentId,  String studentName,  String teacherId,  String teacherName,  String guidanceId,  String guidanceName,  String parentId,  String parentName,  String juniorPrincipalId,  String juniorPrincipalName,  String seniorPrincipalId,  String seniorPrincipalName,  Map<String, String> fields,  Map<SignerRole, String> signatures)?  homeVisitation,TResult Function( String teacherId,  String teacherName,  List<String> studentIds,  List<String> studentNames,  String guidanceId,  String guidanceName,  Map<String, String> fields,  Map<SignerRole, String> signatures)?  violation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeVisitationFormData() when homeVisitation != null:
return homeVisitation(_that.studentId,_that.studentName,_that.teacherId,_that.teacherName,_that.guidanceId,_that.guidanceName,_that.parentId,_that.parentName,_that.juniorPrincipalId,_that.juniorPrincipalName,_that.seniorPrincipalId,_that.seniorPrincipalName,_that.fields,_that.signatures);case ViolationFormData() when violation != null:
return violation(_that.teacherId,_that.teacherName,_that.studentIds,_that.studentNames,_that.guidanceId,_that.guidanceName,_that.fields,_that.signatures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String studentId,  String studentName,  String teacherId,  String teacherName,  String guidanceId,  String guidanceName,  String parentId,  String parentName,  String juniorPrincipalId,  String juniorPrincipalName,  String seniorPrincipalId,  String seniorPrincipalName,  Map<String, String> fields,  Map<SignerRole, String> signatures)  homeVisitation,required TResult Function( String teacherId,  String teacherName,  List<String> studentIds,  List<String> studentNames,  String guidanceId,  String guidanceName,  Map<String, String> fields,  Map<SignerRole, String> signatures)  violation,}) {final _that = this;
switch (_that) {
case HomeVisitationFormData():
return homeVisitation(_that.studentId,_that.studentName,_that.teacherId,_that.teacherName,_that.guidanceId,_that.guidanceName,_that.parentId,_that.parentName,_that.juniorPrincipalId,_that.juniorPrincipalName,_that.seniorPrincipalId,_that.seniorPrincipalName,_that.fields,_that.signatures);case ViolationFormData():
return violation(_that.teacherId,_that.teacherName,_that.studentIds,_that.studentNames,_that.guidanceId,_that.guidanceName,_that.fields,_that.signatures);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String studentId,  String studentName,  String teacherId,  String teacherName,  String guidanceId,  String guidanceName,  String parentId,  String parentName,  String juniorPrincipalId,  String juniorPrincipalName,  String seniorPrincipalId,  String seniorPrincipalName,  Map<String, String> fields,  Map<SignerRole, String> signatures)?  homeVisitation,TResult? Function( String teacherId,  String teacherName,  List<String> studentIds,  List<String> studentNames,  String guidanceId,  String guidanceName,  Map<String, String> fields,  Map<SignerRole, String> signatures)?  violation,}) {final _that = this;
switch (_that) {
case HomeVisitationFormData() when homeVisitation != null:
return homeVisitation(_that.studentId,_that.studentName,_that.teacherId,_that.teacherName,_that.guidanceId,_that.guidanceName,_that.parentId,_that.parentName,_that.juniorPrincipalId,_that.juniorPrincipalName,_that.seniorPrincipalId,_that.seniorPrincipalName,_that.fields,_that.signatures);case ViolationFormData() when violation != null:
return violation(_that.teacherId,_that.teacherName,_that.studentIds,_that.studentNames,_that.guidanceId,_that.guidanceName,_that.fields,_that.signatures);case _:
  return null;

}
}

}

/// @nodoc


class HomeVisitationFormData implements FormData {
  const HomeVisitationFormData({required this.studentId, required this.studentName, required this.teacherId, required this.teacherName, required this.guidanceId, required this.guidanceName, required this.parentId, required this.parentName, required this.juniorPrincipalId, required this.juniorPrincipalName, required this.seniorPrincipalId, required this.seniorPrincipalName,  Map<String, String> fields = const <String, String>{},  Map<SignerRole, String> signatures = const <SignerRole, String>{}}): _fields = fields,_signatures = signatures;
  

 final  String studentId;
 final  String studentName;
@override final  String teacherId;
@override final  String teacherName;
@override final  String guidanceId;
@override final  String guidanceName;
 final  String parentId;
 final  String parentName;
 final  String juniorPrincipalId;
 final  String juniorPrincipalName;
 final  String seniorPrincipalId;
 final  String seniorPrincipalName;
 final  Map<String, String> _fields;
@override@JsonKey() Map<String, String> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}

 final  Map<SignerRole, String> _signatures;
@override@JsonKey() Map<SignerRole, String> get signatures {
  if (_signatures is EqualUnmodifiableMapView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_signatures);
}


/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeVisitationFormDataCopyWith<HomeVisitationFormData> get copyWith => _$HomeVisitationFormDataCopyWithImpl<HomeVisitationFormData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeVisitationFormData&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.teacherId, teacherId) || other.teacherId == teacherId)&&(identical(other.teacherName, teacherName) || other.teacherName == teacherName)&&(identical(other.guidanceId, guidanceId) || other.guidanceId == guidanceId)&&(identical(other.guidanceName, guidanceName) || other.guidanceName == guidanceName)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.parentName, parentName) || other.parentName == parentName)&&(identical(other.juniorPrincipalId, juniorPrincipalId) || other.juniorPrincipalId == juniorPrincipalId)&&(identical(other.juniorPrincipalName, juniorPrincipalName) || other.juniorPrincipalName == juniorPrincipalName)&&(identical(other.seniorPrincipalId, seniorPrincipalId) || other.seniorPrincipalId == seniorPrincipalId)&&(identical(other.seniorPrincipalName, seniorPrincipalName) || other.seniorPrincipalName == seniorPrincipalName)&&const DeepCollectionEquality().equals(other.fields, _fields)&&const DeepCollectionEquality().equals(other.signatures, _signatures));
}


@override
int get hashCode {
    return Object.hash(runtimeType,studentId,studentName,teacherId,teacherName,guidanceId,guidanceName,parentId,parentName,juniorPrincipalId,juniorPrincipalName,seniorPrincipalId,seniorPrincipalName,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_signatures));
}

@override
String toString() {
    return 'FormData.homeVisitation(studentId: $studentId, studentName: $studentName, teacherId: $teacherId, teacherName: $teacherName, guidanceId: $guidanceId, guidanceName: $guidanceName, parentId: $parentId, parentName: $parentName, juniorPrincipalId: $juniorPrincipalId, juniorPrincipalName: $juniorPrincipalName, seniorPrincipalId: $seniorPrincipalId, seniorPrincipalName: $seniorPrincipalName, fields: $fields, signatures: $signatures)';
}


}

/// @nodoc
abstract mixin class $HomeVisitationFormDataCopyWith<$Res> implements $FormDataCopyWith<$Res> {
  factory $HomeVisitationFormDataCopyWith(HomeVisitationFormData value, $Res Function(HomeVisitationFormData) _then) = _$HomeVisitationFormDataCopyWithImpl;
@override @useResult
$Res call({
 String studentId, String studentName, String teacherId, String teacherName, String guidanceId, String guidanceName, String parentId, String parentName, String juniorPrincipalId, String juniorPrincipalName, String seniorPrincipalId, String seniorPrincipalName, Map<String, String> fields, Map<SignerRole, String> signatures
});




}
/// @nodoc
class _$HomeVisitationFormDataCopyWithImpl<$Res>
    implements $HomeVisitationFormDataCopyWith<$Res> {
  _$HomeVisitationFormDataCopyWithImpl(this._self, this._then);

  final HomeVisitationFormData _self;
  final $Res Function(HomeVisitationFormData) _then;

/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? studentName = null,Object? teacherId = null,Object? teacherName = null,Object? guidanceId = null,Object? guidanceName = null,Object? parentId = null,Object? parentName = null,Object? juniorPrincipalId = null,Object? juniorPrincipalName = null,Object? seniorPrincipalId = null,Object? seniorPrincipalName = null,Object? fields = null,Object? signatures = null,}) {
  return _then(HomeVisitationFormData(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,guidanceId: null == guidanceId ? _self.guidanceId : guidanceId // ignore: cast_nullable_to_non_nullable
as String,guidanceName: null == guidanceName ? _self.guidanceName : guidanceName // ignore: cast_nullable_to_non_nullable
as String,parentId: null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String,parentName: null == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String,juniorPrincipalId: null == juniorPrincipalId ? _self.juniorPrincipalId : juniorPrincipalId // ignore: cast_nullable_to_non_nullable
as String,juniorPrincipalName: null == juniorPrincipalName ? _self.juniorPrincipalName : juniorPrincipalName // ignore: cast_nullable_to_non_nullable
as String,seniorPrincipalId: null == seniorPrincipalId ? _self.seniorPrincipalId : seniorPrincipalId // ignore: cast_nullable_to_non_nullable
as String,seniorPrincipalName: null == seniorPrincipalName ? _self.seniorPrincipalName : seniorPrincipalName // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, String>,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as Map<SignerRole, String>,
  ));
}


}

/// @nodoc


class ViolationFormData implements FormData {
  const ViolationFormData({required this.teacherId, required this.teacherName, required  List<String> studentIds, required  List<String> studentNames, required this.guidanceId, required this.guidanceName,  Map<String, String> fields = const <String, String>{},  Map<SignerRole, String> signatures = const <SignerRole, String>{}}): _studentIds = studentIds,_studentNames = studentNames,_fields = fields,_signatures = signatures;
  

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

@override final  String guidanceId;
@override final  String guidanceName;
 final  Map<String, String> _fields;
@override@JsonKey() Map<String, String> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}

 final  Map<SignerRole, String> _signatures;
@override@JsonKey() Map<SignerRole, String> get signatures {
  if (_signatures is EqualUnmodifiableMapView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_signatures);
}


/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViolationFormDataCopyWith<ViolationFormData> get copyWith => _$ViolationFormDataCopyWithImpl<ViolationFormData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ViolationFormData&&(identical(other.teacherId, teacherId) || other.teacherId == teacherId)&&(identical(other.teacherName, teacherName) || other.teacherName == teacherName)&&const DeepCollectionEquality().equals(other.studentIds, _studentIds)&&const DeepCollectionEquality().equals(other.studentNames, _studentNames)&&(identical(other.guidanceId, guidanceId) || other.guidanceId == guidanceId)&&(identical(other.guidanceName, guidanceName) || other.guidanceName == guidanceName)&&const DeepCollectionEquality().equals(other.fields, _fields)&&const DeepCollectionEquality().equals(other.signatures, _signatures));
}


@override
int get hashCode {
    return Object.hash(runtimeType,teacherId,teacherName,const DeepCollectionEquality().hash(_studentIds),const DeepCollectionEquality().hash(_studentNames),guidanceId,guidanceName,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_signatures));
}

@override
String toString() {
    return 'FormData.violation(teacherId: $teacherId, teacherName: $teacherName, studentIds: $studentIds, studentNames: $studentNames, guidanceId: $guidanceId, guidanceName: $guidanceName, fields: $fields, signatures: $signatures)';
}


}

/// @nodoc
abstract mixin class $ViolationFormDataCopyWith<$Res> implements $FormDataCopyWith<$Res> {
  factory $ViolationFormDataCopyWith(ViolationFormData value, $Res Function(ViolationFormData) _then) = _$ViolationFormDataCopyWithImpl;
@override @useResult
$Res call({
 String teacherId, String teacherName, List<String> studentIds, List<String> studentNames, String guidanceId, String guidanceName, Map<String, String> fields, Map<SignerRole, String> signatures
});




}
/// @nodoc
class _$ViolationFormDataCopyWithImpl<$Res>
    implements $ViolationFormDataCopyWith<$Res> {
  _$ViolationFormDataCopyWithImpl(this._self, this._then);

  final ViolationFormData _self;
  final $Res Function(ViolationFormData) _then;

/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teacherId = null,Object? teacherName = null,Object? studentIds = null,Object? studentNames = null,Object? guidanceId = null,Object? guidanceName = null,Object? fields = null,Object? signatures = null,}) {
  return _then(ViolationFormData(
teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,studentIds: null == studentIds ? _self._studentIds : studentIds // ignore: cast_nullable_to_non_nullable
as List<String>,studentNames: null == studentNames ? _self._studentNames : studentNames // ignore: cast_nullable_to_non_nullable
as List<String>,guidanceId: null == guidanceId ? _self.guidanceId : guidanceId // ignore: cast_nullable_to_non_nullable
as String,guidanceName: null == guidanceName ? _self.guidanceName : guidanceName // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, String>,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as Map<SignerRole, String>,
  ));
}


}

/// @nodoc
mixin _$Form {

 String get id; FormType get formType; FormStatus get status; String get createdByUserId; DateTime get createdAt; FormData get data;
/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormCopyWith<Form> get copyWith => _$FormCopyWithImpl<Form>(this as Form, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Form;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Form&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.formType, _this.formType) || other.formType == _this.formType)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdByUserId, _this.createdByUserId) || other.createdByUserId == _this.createdByUserId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.data, _this.data) || other.data == _this.data));
}


@override
int get hashCode {
  final _this = this as Form;
  return Object.hash(runtimeType,_this.id,_this.formType,_this.status,_this.createdByUserId,_this.createdAt,_this.data);
}

@override
String toString() {
  final _this = this as Form;
  return 'Form(id: ${_this.id}, formType: ${_this.formType}, status: ${_this.status}, createdByUserId: ${_this.createdByUserId}, createdAt: ${_this.createdAt}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $FormCopyWith<$Res>  {
  factory $FormCopyWith(Form value, $Res Function(Form) _then) = _$FormCopyWithImpl;
@useResult
$Res call({
 String id, FormType formType, FormStatus status, String createdByUserId, DateTime createdAt, FormData data
});


$FormDataCopyWith<$Res> get data;

}
/// @nodoc
class _$FormCopyWithImpl<$Res>
    implements $FormCopyWith<$Res> {
  _$FormCopyWithImpl(this._self, this._then);

  final Form _self;
  final $Res Function(Form) _then;

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? formType = null,Object? status = null,Object? createdByUserId = null,Object? createdAt = null,Object? data = null,}) {
  return _then(Form(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as FormType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FormData,
  ));
}
/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormDataCopyWith<$Res> get data {
  
  return $FormDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [Form].
extension FormPatterns on Form {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Form value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Form() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Form value)  $default,){
final _that = this;
switch (_that) {
case _Form():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Form value)?  $default,){
final _that = this;
switch (_that) {
case _Form() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FormType formType,  FormStatus status,  String createdByUserId,  DateTime createdAt,  FormData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Form() when $default != null:
return $default(_that.id,_that.formType,_that.status,_that.createdByUserId,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FormType formType,  FormStatus status,  String createdByUserId,  DateTime createdAt,  FormData data)  $default,) {final _that = this;
switch (_that) {
case _Form():
return $default(_that.id,_that.formType,_that.status,_that.createdByUserId,_that.createdAt,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FormType formType,  FormStatus status,  String createdByUserId,  DateTime createdAt,  FormData data)?  $default,) {final _that = this;
switch (_that) {
case _Form() when $default != null:
return $default(_that.id,_that.formType,_that.status,_that.createdByUserId,_that.createdAt,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Form extends Form {
  const _Form({required this.id, required this.formType, required this.status, required this.createdByUserId, required this.createdAt, required this.data}): super._();
  

@override final  String id;
@override final  FormType formType;
@override final  FormStatus status;
@override final  String createdByUserId;
@override final  DateTime createdAt;
@override final  FormData data;

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormCopyWith<_Form> get copyWith => __$FormCopyWithImpl<_Form>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Form&&(identical(other.id, id) || other.id == id)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdByUserId, createdByUserId) || other.createdByUserId == createdByUserId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,formType,status,createdByUserId,createdAt,data);
}

@override
String toString() {
    return 'Form(id: $id, formType: $formType, status: $status, createdByUserId: $createdByUserId, createdAt: $createdAt, data: $data)';
}


}

/// @nodoc
abstract mixin class _$FormCopyWith<$Res> implements $FormCopyWith<$Res> {
  factory _$FormCopyWith(_Form value, $Res Function(_Form) _then) = __$FormCopyWithImpl;
@override @useResult
$Res call({
 String id, FormType formType, FormStatus status, String createdByUserId, DateTime createdAt, FormData data
});


@override $FormDataCopyWith<$Res> get data;

}
/// @nodoc
class __$FormCopyWithImpl<$Res>
    implements _$FormCopyWith<$Res> {
  __$FormCopyWithImpl(this._self, this._then);

  final _Form _self;
  final $Res Function(_Form) _then;

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? formType = null,Object? status = null,Object? createdByUserId = null,Object? createdAt = null,Object? data = null,}) {
  return _then(_Form(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as FormType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,createdByUserId: null == createdByUserId ? _self.createdByUserId : createdByUserId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FormData,
  ));
}

/// Create a copy of Form
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormDataCopyWith<$Res> get data {
  
  return $FormDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
