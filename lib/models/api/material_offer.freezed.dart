// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaterialOffer {

 String get id;@JsonKey(name: 'material_id') String get materialId;@JsonKey(name: 'store_id') String get storeId;@JsonKey(name: 'store_name') String get storeName;@JsonKey(name: 'store_district') String? get storeDistrict;@JsonKey(name: 'store_partner_tier') String get storePartnerTier;@JsonKey(name: 'price_uzs') int get priceUzs;@JsonKey(name: 'in_stock') bool get inStock;@JsonKey(name: 'delivery_days') int get deliveryDays;
/// Create a copy of MaterialOffer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaterialOfferCopyWith<MaterialOffer> get copyWith => _$MaterialOfferCopyWithImpl<MaterialOffer>(this as MaterialOffer, _$identity);

  /// Serializes this MaterialOffer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MaterialOffer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaterialOffer&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.materialId, _this.materialId) || other.materialId == _this.materialId)&&(identical(other.storeId, _this.storeId) || other.storeId == _this.storeId)&&(identical(other.storeName, _this.storeName) || other.storeName == _this.storeName)&&(identical(other.storeDistrict, _this.storeDistrict) || other.storeDistrict == _this.storeDistrict)&&(identical(other.storePartnerTier, _this.storePartnerTier) || other.storePartnerTier == _this.storePartnerTier)&&(identical(other.priceUzs, _this.priceUzs) || other.priceUzs == _this.priceUzs)&&(identical(other.inStock, _this.inStock) || other.inStock == _this.inStock)&&(identical(other.deliveryDays, _this.deliveryDays) || other.deliveryDays == _this.deliveryDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MaterialOffer;
  return Object.hash(runtimeType,_this.id,_this.materialId,_this.storeId,_this.storeName,_this.storeDistrict,_this.storePartnerTier,_this.priceUzs,_this.inStock,_this.deliveryDays);
}

@override
String toString() {
  final _this = this as MaterialOffer;
  return 'MaterialOffer(id: ${_this.id}, materialId: ${_this.materialId}, storeId: ${_this.storeId}, storeName: ${_this.storeName}, storeDistrict: ${_this.storeDistrict}, storePartnerTier: ${_this.storePartnerTier}, priceUzs: ${_this.priceUzs}, inStock: ${_this.inStock}, deliveryDays: ${_this.deliveryDays})';
}


}

/// @nodoc
abstract mixin class $MaterialOfferCopyWith<$Res>  {
  factory $MaterialOfferCopyWith(MaterialOffer value, $Res Function(MaterialOffer) _then) = _$MaterialOfferCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'material_id') String materialId,@JsonKey(name: 'store_id') String storeId,@JsonKey(name: 'store_name') String storeName,@JsonKey(name: 'store_district') String? storeDistrict,@JsonKey(name: 'store_partner_tier') String storePartnerTier,@JsonKey(name: 'price_uzs') int priceUzs,@JsonKey(name: 'in_stock') bool inStock,@JsonKey(name: 'delivery_days') int deliveryDays
});




}
/// @nodoc
class _$MaterialOfferCopyWithImpl<$Res>
    implements $MaterialOfferCopyWith<$Res> {
  _$MaterialOfferCopyWithImpl(this._self, this._then);

  final MaterialOffer _self;
  final $Res Function(MaterialOffer) _then;

/// Create a copy of MaterialOffer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? materialId = null,Object? storeId = null,Object? storeName = null,Object? storeDistrict = freezed,Object? storePartnerTier = null,Object? priceUzs = null,Object? inStock = null,Object? deliveryDays = null,}) {
  return _then(MaterialOffer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,materialId: null == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,storeDistrict: freezed == storeDistrict ? _self.storeDistrict : storeDistrict // ignore: cast_nullable_to_non_nullable
as String?,storePartnerTier: null == storePartnerTier ? _self.storePartnerTier : storePartnerTier // ignore: cast_nullable_to_non_nullable
as String,priceUzs: null == priceUzs ? _self.priceUzs : priceUzs // ignore: cast_nullable_to_non_nullable
as int,inStock: null == inStock ? _self.inStock : inStock // ignore: cast_nullable_to_non_nullable
as bool,deliveryDays: null == deliveryDays ? _self.deliveryDays : deliveryDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MaterialOffer].
extension MaterialOfferPatterns on MaterialOffer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaterialOffer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaterialOffer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaterialOffer value)  $default,){
final _that = this;
switch (_that) {
case _MaterialOffer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaterialOffer value)?  $default,){
final _that = this;
switch (_that) {
case _MaterialOffer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'material_id')  String materialId, @JsonKey(name: 'store_id')  String storeId, @JsonKey(name: 'store_name')  String storeName, @JsonKey(name: 'store_district')  String? storeDistrict, @JsonKey(name: 'store_partner_tier')  String storePartnerTier, @JsonKey(name: 'price_uzs')  int priceUzs, @JsonKey(name: 'in_stock')  bool inStock, @JsonKey(name: 'delivery_days')  int deliveryDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaterialOffer() when $default != null:
return $default(_that.id,_that.materialId,_that.storeId,_that.storeName,_that.storeDistrict,_that.storePartnerTier,_that.priceUzs,_that.inStock,_that.deliveryDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'material_id')  String materialId, @JsonKey(name: 'store_id')  String storeId, @JsonKey(name: 'store_name')  String storeName, @JsonKey(name: 'store_district')  String? storeDistrict, @JsonKey(name: 'store_partner_tier')  String storePartnerTier, @JsonKey(name: 'price_uzs')  int priceUzs, @JsonKey(name: 'in_stock')  bool inStock, @JsonKey(name: 'delivery_days')  int deliveryDays)  $default,) {final _that = this;
switch (_that) {
case _MaterialOffer():
return $default(_that.id,_that.materialId,_that.storeId,_that.storeName,_that.storeDistrict,_that.storePartnerTier,_that.priceUzs,_that.inStock,_that.deliveryDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'material_id')  String materialId, @JsonKey(name: 'store_id')  String storeId, @JsonKey(name: 'store_name')  String storeName, @JsonKey(name: 'store_district')  String? storeDistrict, @JsonKey(name: 'store_partner_tier')  String storePartnerTier, @JsonKey(name: 'price_uzs')  int priceUzs, @JsonKey(name: 'in_stock')  bool inStock, @JsonKey(name: 'delivery_days')  int deliveryDays)?  $default,) {final _that = this;
switch (_that) {
case _MaterialOffer() when $default != null:
return $default(_that.id,_that.materialId,_that.storeId,_that.storeName,_that.storeDistrict,_that.storePartnerTier,_that.priceUzs,_that.inStock,_that.deliveryDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaterialOffer implements MaterialOffer {
  const _MaterialOffer({required this.id, @JsonKey(name: 'material_id') required this.materialId, @JsonKey(name: 'store_id') required this.storeId, @JsonKey(name: 'store_name') required this.storeName, @JsonKey(name: 'store_district') this.storeDistrict, @JsonKey(name: 'store_partner_tier') required this.storePartnerTier, @JsonKey(name: 'price_uzs') required this.priceUzs, @JsonKey(name: 'in_stock') required this.inStock, @JsonKey(name: 'delivery_days') required this.deliveryDays});
  factory _MaterialOffer.fromJson(Map<String, dynamic> json) => _$MaterialOfferFromJson(json);

@override final  String id;
@override@JsonKey(name: 'material_id') final  String materialId;
@override@JsonKey(name: 'store_id') final  String storeId;
@override@JsonKey(name: 'store_name') final  String storeName;
@override@JsonKey(name: 'store_district') final  String? storeDistrict;
@override@JsonKey(name: 'store_partner_tier') final  String storePartnerTier;
@override@JsonKey(name: 'price_uzs') final  int priceUzs;
@override@JsonKey(name: 'in_stock') final  bool inStock;
@override@JsonKey(name: 'delivery_days') final  int deliveryDays;

/// Create a copy of MaterialOffer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaterialOfferCopyWith<_MaterialOffer> get copyWith => __$MaterialOfferCopyWithImpl<_MaterialOffer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaterialOfferToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaterialOffer&&(identical(other.id, id) || other.id == id)&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.storeId, storeId) || other.storeId == storeId)&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.storeDistrict, storeDistrict) || other.storeDistrict == storeDistrict)&&(identical(other.storePartnerTier, storePartnerTier) || other.storePartnerTier == storePartnerTier)&&(identical(other.priceUzs, priceUzs) || other.priceUzs == priceUzs)&&(identical(other.inStock, inStock) || other.inStock == inStock)&&(identical(other.deliveryDays, deliveryDays) || other.deliveryDays == deliveryDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,materialId,storeId,storeName,storeDistrict,storePartnerTier,priceUzs,inStock,deliveryDays);
}

@override
String toString() {
    return 'MaterialOffer(id: $id, materialId: $materialId, storeId: $storeId, storeName: $storeName, storeDistrict: $storeDistrict, storePartnerTier: $storePartnerTier, priceUzs: $priceUzs, inStock: $inStock, deliveryDays: $deliveryDays)';
}


}

/// @nodoc
abstract mixin class _$MaterialOfferCopyWith<$Res> implements $MaterialOfferCopyWith<$Res> {
  factory _$MaterialOfferCopyWith(_MaterialOffer value, $Res Function(_MaterialOffer) _then) = __$MaterialOfferCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'material_id') String materialId,@JsonKey(name: 'store_id') String storeId,@JsonKey(name: 'store_name') String storeName,@JsonKey(name: 'store_district') String? storeDistrict,@JsonKey(name: 'store_partner_tier') String storePartnerTier,@JsonKey(name: 'price_uzs') int priceUzs,@JsonKey(name: 'in_stock') bool inStock,@JsonKey(name: 'delivery_days') int deliveryDays
});




}
/// @nodoc
class __$MaterialOfferCopyWithImpl<$Res>
    implements _$MaterialOfferCopyWith<$Res> {
  __$MaterialOfferCopyWithImpl(this._self, this._then);

  final _MaterialOffer _self;
  final $Res Function(_MaterialOffer) _then;

/// Create a copy of MaterialOffer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? materialId = null,Object? storeId = null,Object? storeName = null,Object? storeDistrict = freezed,Object? storePartnerTier = null,Object? priceUzs = null,Object? inStock = null,Object? deliveryDays = null,}) {
  return _then(_MaterialOffer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,materialId: null == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String,storeId: null == storeId ? _self.storeId : storeId // ignore: cast_nullable_to_non_nullable
as String,storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,storeDistrict: freezed == storeDistrict ? _self.storeDistrict : storeDistrict // ignore: cast_nullable_to_non_nullable
as String?,storePartnerTier: null == storePartnerTier ? _self.storePartnerTier : storePartnerTier // ignore: cast_nullable_to_non_nullable
as String,priceUzs: null == priceUzs ? _self.priceUzs : priceUzs // ignore: cast_nullable_to_non_nullable
as int,inStock: null == inStock ? _self.inStock : inStock // ignore: cast_nullable_to_non_nullable
as bool,deliveryDays: null == deliveryDays ? _self.deliveryDays : deliveryDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
