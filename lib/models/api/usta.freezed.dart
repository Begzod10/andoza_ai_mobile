// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Usta {

 String get id; String get name; String get category; String? get district; String get phone; String? get telegram; double get rating;@JsonKey(name: 'jobs_count') int get jobsCount;@JsonKey(name: 'price_min') int? get priceMin;@JsonKey(name: 'price_max') int? get priceMax; bool get verified;@JsonKey(name: 'lat') double? get lat;@JsonKey(name: 'lng') double? get lng;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of Usta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UstaCopyWith<Usta> get copyWith => _$UstaCopyWithImpl<Usta>(this as Usta, _$identity);

  /// Serializes this Usta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Usta;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Usta&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.district, _this.district) || other.district == _this.district)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.telegram, _this.telegram) || other.telegram == _this.telegram)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.jobsCount, _this.jobsCount) || other.jobsCount == _this.jobsCount)&&(identical(other.priceMin, _this.priceMin) || other.priceMin == _this.priceMin)&&(identical(other.priceMax, _this.priceMax) || other.priceMax == _this.priceMax)&&(identical(other.verified, _this.verified) || other.verified == _this.verified)&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Usta;
  return Object.hash(runtimeType,_this.id,_this.name,_this.category,_this.district,_this.phone,_this.telegram,_this.rating,_this.jobsCount,_this.priceMin,_this.priceMax,_this.verified,_this.lat,_this.lng,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as Usta;
  return 'Usta(id: ${_this.id}, name: ${_this.name}, category: ${_this.category}, district: ${_this.district}, phone: ${_this.phone}, telegram: ${_this.telegram}, rating: ${_this.rating}, jobsCount: ${_this.jobsCount}, priceMin: ${_this.priceMin}, priceMax: ${_this.priceMax}, verified: ${_this.verified}, lat: ${_this.lat}, lng: ${_this.lng}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $UstaCopyWith<$Res>  {
  factory $UstaCopyWith(Usta value, $Res Function(Usta) _then) = _$UstaCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String? district, String phone, String? telegram, double rating,@JsonKey(name: 'jobs_count') int jobsCount,@JsonKey(name: 'price_min') int? priceMin,@JsonKey(name: 'price_max') int? priceMax, bool verified,@JsonKey(name: 'lat') double? lat,@JsonKey(name: 'lng') double? lng,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$UstaCopyWithImpl<$Res>
    implements $UstaCopyWith<$Res> {
  _$UstaCopyWithImpl(this._self, this._then);

  final Usta _self;
  final $Res Function(Usta) _then;

/// Create a copy of Usta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? district = freezed,Object? phone = null,Object? telegram = freezed,Object? rating = null,Object? jobsCount = null,Object? priceMin = freezed,Object? priceMax = freezed,Object? verified = null,Object? lat = freezed,Object? lng = freezed,Object? avatarUrl = freezed,}) {
  return _then(Usta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,telegram: freezed == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,jobsCount: null == jobsCount ? _self.jobsCount : jobsCount // ignore: cast_nullable_to_non_nullable
as int,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as int?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as int?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Usta].
extension UstaPatterns on Usta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Usta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Usta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Usta value)  $default,){
final _that = this;
switch (_that) {
case _Usta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Usta value)?  $default,){
final _that = this;
switch (_that) {
case _Usta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String? district,  String phone,  String? telegram,  double rating, @JsonKey(name: 'jobs_count')  int jobsCount, @JsonKey(name: 'price_min')  int? priceMin, @JsonKey(name: 'price_max')  int? priceMax,  bool verified, @JsonKey(name: 'lat')  double? lat, @JsonKey(name: 'lng')  double? lng, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Usta() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.district,_that.phone,_that.telegram,_that.rating,_that.jobsCount,_that.priceMin,_that.priceMax,_that.verified,_that.lat,_that.lng,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String? district,  String phone,  String? telegram,  double rating, @JsonKey(name: 'jobs_count')  int jobsCount, @JsonKey(name: 'price_min')  int? priceMin, @JsonKey(name: 'price_max')  int? priceMax,  bool verified, @JsonKey(name: 'lat')  double? lat, @JsonKey(name: 'lng')  double? lng, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _Usta():
return $default(_that.id,_that.name,_that.category,_that.district,_that.phone,_that.telegram,_that.rating,_that.jobsCount,_that.priceMin,_that.priceMax,_that.verified,_that.lat,_that.lng,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String? district,  String phone,  String? telegram,  double rating, @JsonKey(name: 'jobs_count')  int jobsCount, @JsonKey(name: 'price_min')  int? priceMin, @JsonKey(name: 'price_max')  int? priceMax,  bool verified, @JsonKey(name: 'lat')  double? lat, @JsonKey(name: 'lng')  double? lng, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _Usta() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.district,_that.phone,_that.telegram,_that.rating,_that.jobsCount,_that.priceMin,_that.priceMax,_that.verified,_that.lat,_that.lng,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Usta implements Usta {
  const _Usta({required this.id, required this.name, required this.category, this.district, required this.phone, this.telegram, this.rating = 0.0, @JsonKey(name: 'jobs_count') this.jobsCount = 0, @JsonKey(name: 'price_min') this.priceMin, @JsonKey(name: 'price_max') this.priceMax, this.verified = false, @JsonKey(name: 'lat') this.lat, @JsonKey(name: 'lng') this.lng, @JsonKey(name: 'avatar_url') this.avatarUrl});
  factory _Usta.fromJson(Map<String, dynamic> json) => _$UstaFromJson(json);

@override final  String id;
@override final  String name;
@override final  String category;
@override final  String? district;
@override final  String phone;
@override final  String? telegram;
@override@JsonKey() final  double rating;
@override@JsonKey(name: 'jobs_count') final  int jobsCount;
@override@JsonKey(name: 'price_min') final  int? priceMin;
@override@JsonKey(name: 'price_max') final  int? priceMax;
@override@JsonKey() final  bool verified;
@override@JsonKey(name: 'lat') final  double? lat;
@override@JsonKey(name: 'lng') final  double? lng;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of Usta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UstaCopyWith<_Usta> get copyWith => __$UstaCopyWithImpl<_Usta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UstaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Usta&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.district, district) || other.district == district)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.jobsCount, jobsCount) || other.jobsCount == jobsCount)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,category,district,phone,telegram,rating,jobsCount,priceMin,priceMax,verified,lat,lng,avatarUrl);
}

@override
String toString() {
    return 'Usta(id: $id, name: $name, category: $category, district: $district, phone: $phone, telegram: $telegram, rating: $rating, jobsCount: $jobsCount, priceMin: $priceMin, priceMax: $priceMax, verified: $verified, lat: $lat, lng: $lng, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$UstaCopyWith<$Res> implements $UstaCopyWith<$Res> {
  factory _$UstaCopyWith(_Usta value, $Res Function(_Usta) _then) = __$UstaCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String? district, String phone, String? telegram, double rating,@JsonKey(name: 'jobs_count') int jobsCount,@JsonKey(name: 'price_min') int? priceMin,@JsonKey(name: 'price_max') int? priceMax, bool verified,@JsonKey(name: 'lat') double? lat,@JsonKey(name: 'lng') double? lng,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$UstaCopyWithImpl<$Res>
    implements _$UstaCopyWith<$Res> {
  __$UstaCopyWithImpl(this._self, this._then);

  final _Usta _self;
  final $Res Function(_Usta) _then;

/// Create a copy of Usta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? district = freezed,Object? phone = null,Object? telegram = freezed,Object? rating = null,Object? jobsCount = null,Object? priceMin = freezed,Object? priceMax = freezed,Object? verified = null,Object? lat = freezed,Object? lng = freezed,Object? avatarUrl = freezed,}) {
  return _then(_Usta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,telegram: freezed == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,jobsCount: null == jobsCount ? _self.jobsCount : jobsCount // ignore: cast_nullable_to_non_nullable
as int,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as int?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as int?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
