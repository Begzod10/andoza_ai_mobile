// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apartment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Apartment {

 String get id;@JsonKey(name: 'user_id') String get userId; String get name; String? get address; String? get developer;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'renovation_stage') int get renovationStage; List<RoomOut> get rooms;
/// Create a copy of Apartment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApartmentCopyWith<Apartment> get copyWith => _$ApartmentCopyWithImpl<Apartment>(this as Apartment, _$identity);

  /// Serializes this Apartment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Apartment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Apartment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.developer, _this.developer) || other.developer == _this.developer)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.renovationStage, _this.renovationStage) || other.renovationStage == _this.renovationStage)&&const DeepCollectionEquality().equals(other.rooms, _this.rooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Apartment;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.name,_this.address,_this.developer,_this.createdAt,_this.renovationStage,const DeepCollectionEquality().hash(_this.rooms));
}

@override
String toString() {
  final _this = this as Apartment;
  return 'Apartment(id: ${_this.id}, userId: ${_this.userId}, name: ${_this.name}, address: ${_this.address}, developer: ${_this.developer}, createdAt: ${_this.createdAt}, renovationStage: ${_this.renovationStage}, rooms: ${_this.rooms})';
}


}

/// @nodoc
abstract mixin class $ApartmentCopyWith<$Res>  {
  factory $ApartmentCopyWith(Apartment value, $Res Function(Apartment) _then) = _$ApartmentCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String name, String? address, String? developer,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'renovation_stage') int renovationStage, List<RoomOut> rooms
});




}
/// @nodoc
class _$ApartmentCopyWithImpl<$Res>
    implements $ApartmentCopyWith<$Res> {
  _$ApartmentCopyWithImpl(this._self, this._then);

  final Apartment _self;
  final $Res Function(Apartment) _then;

/// Create a copy of Apartment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? address = freezed,Object? developer = freezed,Object? createdAt = null,Object? renovationStage = null,Object? rooms = null,}) {
  return _then(Apartment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,developer: freezed == developer ? _self.developer : developer // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,renovationStage: null == renovationStage ? _self.renovationStage : renovationStage // ignore: cast_nullable_to_non_nullable
as int,rooms: null == rooms ? _self.rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<RoomOut>,
  ));
}

}


/// Adds pattern-matching-related methods to [Apartment].
extension ApartmentPatterns on Apartment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Apartment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Apartment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Apartment value)  $default,){
final _that = this;
switch (_that) {
case _Apartment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Apartment value)?  $default,){
final _that = this;
switch (_that) {
case _Apartment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String name,  String? address,  String? developer, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'renovation_stage')  int renovationStage,  List<RoomOut> rooms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Apartment() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.address,_that.developer,_that.createdAt,_that.renovationStage,_that.rooms);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String name,  String? address,  String? developer, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'renovation_stage')  int renovationStage,  List<RoomOut> rooms)  $default,) {final _that = this;
switch (_that) {
case _Apartment():
return $default(_that.id,_that.userId,_that.name,_that.address,_that.developer,_that.createdAt,_that.renovationStage,_that.rooms);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String name,  String? address,  String? developer, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'renovation_stage')  int renovationStage,  List<RoomOut> rooms)?  $default,) {final _that = this;
switch (_that) {
case _Apartment() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.address,_that.developer,_that.createdAt,_that.renovationStage,_that.rooms);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Apartment implements Apartment {
  const _Apartment({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.name, this.address, this.developer, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'renovation_stage') this.renovationStage = 1,  List<RoomOut> rooms = const <RoomOut>[]}): _rooms = rooms;
  factory _Apartment.fromJson(Map<String, dynamic> json) => _$ApartmentFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String name;
@override final  String? address;
@override final  String? developer;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'renovation_stage') final  int renovationStage;
 final  List<RoomOut> _rooms;
@override@JsonKey() List<RoomOut> get rooms {
  if (_rooms is EqualUnmodifiableListView) return _rooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rooms);
}


/// Create a copy of Apartment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApartmentCopyWith<_Apartment> get copyWith => __$ApartmentCopyWithImpl<_Apartment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApartmentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Apartment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.developer, developer) || other.developer == developer)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.renovationStage, renovationStage) || other.renovationStage == renovationStage)&&const DeepCollectionEquality().equals(other.rooms, _rooms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,name,address,developer,createdAt,renovationStage,const DeepCollectionEquality().hash(_rooms));
}

@override
String toString() {
    return 'Apartment(id: $id, userId: $userId, name: $name, address: $address, developer: $developer, createdAt: $createdAt, renovationStage: $renovationStage, rooms: $rooms)';
}


}

/// @nodoc
abstract mixin class _$ApartmentCopyWith<$Res> implements $ApartmentCopyWith<$Res> {
  factory _$ApartmentCopyWith(_Apartment value, $Res Function(_Apartment) _then) = __$ApartmentCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String name, String? address, String? developer,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'renovation_stage') int renovationStage, List<RoomOut> rooms
});




}
/// @nodoc
class __$ApartmentCopyWithImpl<$Res>
    implements _$ApartmentCopyWith<$Res> {
  __$ApartmentCopyWithImpl(this._self, this._then);

  final _Apartment _self;
  final $Res Function(_Apartment) _then;

/// Create a copy of Apartment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? address = freezed,Object? developer = freezed,Object? createdAt = null,Object? renovationStage = null,Object? rooms = null,}) {
  return _then(_Apartment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,developer: freezed == developer ? _self.developer : developer // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,renovationStage: null == renovationStage ? _self.renovationStage : renovationStage // ignore: cast_nullable_to_non_nullable
as int,rooms: null == rooms ? _self._rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<RoomOut>,
  ));
}


}

// dart format on
