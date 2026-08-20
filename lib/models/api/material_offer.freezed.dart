// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MaterialOffer _$MaterialOfferFromJson(Map<String, dynamic> json) {
  return _MaterialOffer.fromJson(json);
}

/// @nodoc
mixin _$MaterialOffer {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'material_id')
  String get materialId => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  String get storeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_name')
  String get storeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_district')
  String? get storeDistrict => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_partner_tier')
  String get storePartnerTier => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_uzs')
  int get priceUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_stock')
  bool get inStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_days')
  int get deliveryDays => throw _privateConstructorUsedError;

  /// Serializes this MaterialOffer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MaterialOffer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MaterialOfferCopyWith<MaterialOffer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialOfferCopyWith<$Res> {
  factory $MaterialOfferCopyWith(
    MaterialOffer value,
    $Res Function(MaterialOffer) then,
  ) = _$MaterialOfferCopyWithImpl<$Res, MaterialOffer>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'material_id') String materialId,
    @JsonKey(name: 'store_id') String storeId,
    @JsonKey(name: 'store_name') String storeName,
    @JsonKey(name: 'store_district') String? storeDistrict,
    @JsonKey(name: 'store_partner_tier') String storePartnerTier,
    @JsonKey(name: 'price_uzs') int priceUzs,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'delivery_days') int deliveryDays,
  });
}

/// @nodoc
class _$MaterialOfferCopyWithImpl<$Res, $Val extends MaterialOffer>
    implements $MaterialOfferCopyWith<$Res> {
  _$MaterialOfferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MaterialOffer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? materialId = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? storeDistrict = freezed,
    Object? storePartnerTier = null,
    Object? priceUzs = null,
    Object? inStock = null,
    Object? deliveryDays = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            materialId: null == materialId
                ? _value.materialId
                : materialId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            storeName: null == storeName
                ? _value.storeName
                : storeName // ignore: cast_nullable_to_non_nullable
                      as String,
            storeDistrict: freezed == storeDistrict
                ? _value.storeDistrict
                : storeDistrict // ignore: cast_nullable_to_non_nullable
                      as String?,
            storePartnerTier: null == storePartnerTier
                ? _value.storePartnerTier
                : storePartnerTier // ignore: cast_nullable_to_non_nullable
                      as String,
            priceUzs: null == priceUzs
                ? _value.priceUzs
                : priceUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            inStock: null == inStock
                ? _value.inStock
                : inStock // ignore: cast_nullable_to_non_nullable
                      as bool,
            deliveryDays: null == deliveryDays
                ? _value.deliveryDays
                : deliveryDays // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MaterialOfferImplCopyWith<$Res>
    implements $MaterialOfferCopyWith<$Res> {
  factory _$$MaterialOfferImplCopyWith(
    _$MaterialOfferImpl value,
    $Res Function(_$MaterialOfferImpl) then,
  ) = __$$MaterialOfferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'material_id') String materialId,
    @JsonKey(name: 'store_id') String storeId,
    @JsonKey(name: 'store_name') String storeName,
    @JsonKey(name: 'store_district') String? storeDistrict,
    @JsonKey(name: 'store_partner_tier') String storePartnerTier,
    @JsonKey(name: 'price_uzs') int priceUzs,
    @JsonKey(name: 'in_stock') bool inStock,
    @JsonKey(name: 'delivery_days') int deliveryDays,
  });
}

/// @nodoc
class __$$MaterialOfferImplCopyWithImpl<$Res>
    extends _$MaterialOfferCopyWithImpl<$Res, _$MaterialOfferImpl>
    implements _$$MaterialOfferImplCopyWith<$Res> {
  __$$MaterialOfferImplCopyWithImpl(
    _$MaterialOfferImpl _value,
    $Res Function(_$MaterialOfferImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MaterialOffer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? materialId = null,
    Object? storeId = null,
    Object? storeName = null,
    Object? storeDistrict = freezed,
    Object? storePartnerTier = null,
    Object? priceUzs = null,
    Object? inStock = null,
    Object? deliveryDays = null,
  }) {
    return _then(
      _$MaterialOfferImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        materialId: null == materialId
            ? _value.materialId
            : materialId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        storeName: null == storeName
            ? _value.storeName
            : storeName // ignore: cast_nullable_to_non_nullable
                  as String,
        storeDistrict: freezed == storeDistrict
            ? _value.storeDistrict
            : storeDistrict // ignore: cast_nullable_to_non_nullable
                  as String?,
        storePartnerTier: null == storePartnerTier
            ? _value.storePartnerTier
            : storePartnerTier // ignore: cast_nullable_to_non_nullable
                  as String,
        priceUzs: null == priceUzs
            ? _value.priceUzs
            : priceUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        inStock: null == inStock
            ? _value.inStock
            : inStock // ignore: cast_nullable_to_non_nullable
                  as bool,
        deliveryDays: null == deliveryDays
            ? _value.deliveryDays
            : deliveryDays // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialOfferImpl implements _MaterialOffer {
  const _$MaterialOfferImpl({
    required this.id,
    @JsonKey(name: 'material_id') required this.materialId,
    @JsonKey(name: 'store_id') required this.storeId,
    @JsonKey(name: 'store_name') required this.storeName,
    @JsonKey(name: 'store_district') this.storeDistrict,
    @JsonKey(name: 'store_partner_tier') required this.storePartnerTier,
    @JsonKey(name: 'price_uzs') required this.priceUzs,
    @JsonKey(name: 'in_stock') required this.inStock,
    @JsonKey(name: 'delivery_days') required this.deliveryDays,
  });

  factory _$MaterialOfferImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialOfferImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'material_id')
  final String materialId;
  @override
  @JsonKey(name: 'store_id')
  final String storeId;
  @override
  @JsonKey(name: 'store_name')
  final String storeName;
  @override
  @JsonKey(name: 'store_district')
  final String? storeDistrict;
  @override
  @JsonKey(name: 'store_partner_tier')
  final String storePartnerTier;
  @override
  @JsonKey(name: 'price_uzs')
  final int priceUzs;
  @override
  @JsonKey(name: 'in_stock')
  final bool inStock;
  @override
  @JsonKey(name: 'delivery_days')
  final int deliveryDays;

  @override
  String toString() {
    return 'MaterialOffer(id: $id, materialId: $materialId, storeId: $storeId, storeName: $storeName, storeDistrict: $storeDistrict, storePartnerTier: $storePartnerTier, priceUzs: $priceUzs, inStock: $inStock, deliveryDays: $deliveryDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialOfferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.storeName, storeName) ||
                other.storeName == storeName) &&
            (identical(other.storeDistrict, storeDistrict) ||
                other.storeDistrict == storeDistrict) &&
            (identical(other.storePartnerTier, storePartnerTier) ||
                other.storePartnerTier == storePartnerTier) &&
            (identical(other.priceUzs, priceUzs) ||
                other.priceUzs == priceUzs) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.deliveryDays, deliveryDays) ||
                other.deliveryDays == deliveryDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    materialId,
    storeId,
    storeName,
    storeDistrict,
    storePartnerTier,
    priceUzs,
    inStock,
    deliveryDays,
  );

  /// Create a copy of MaterialOffer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialOfferImplCopyWith<_$MaterialOfferImpl> get copyWith =>
      __$$MaterialOfferImplCopyWithImpl<_$MaterialOfferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialOfferImplToJson(this);
  }
}

abstract class _MaterialOffer implements MaterialOffer {
  const factory _MaterialOffer({
    required final String id,
    @JsonKey(name: 'material_id') required final String materialId,
    @JsonKey(name: 'store_id') required final String storeId,
    @JsonKey(name: 'store_name') required final String storeName,
    @JsonKey(name: 'store_district') final String? storeDistrict,
    @JsonKey(name: 'store_partner_tier') required final String storePartnerTier,
    @JsonKey(name: 'price_uzs') required final int priceUzs,
    @JsonKey(name: 'in_stock') required final bool inStock,
    @JsonKey(name: 'delivery_days') required final int deliveryDays,
  }) = _$MaterialOfferImpl;

  factory _MaterialOffer.fromJson(Map<String, dynamic> json) =
      _$MaterialOfferImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'material_id')
  String get materialId;
  @override
  @JsonKey(name: 'store_id')
  String get storeId;
  @override
  @JsonKey(name: 'store_name')
  String get storeName;
  @override
  @JsonKey(name: 'store_district')
  String? get storeDistrict;
  @override
  @JsonKey(name: 'store_partner_tier')
  String get storePartnerTier;
  @override
  @JsonKey(name: 'price_uzs')
  int get priceUzs;
  @override
  @JsonKey(name: 'in_stock')
  bool get inStock;
  @override
  @JsonKey(name: 'delivery_days')
  int get deliveryDays;

  /// Create a copy of MaterialOffer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MaterialOfferImplCopyWith<_$MaterialOfferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
