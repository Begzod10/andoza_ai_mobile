// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Material _$MaterialFromJson(Map<String, dynamic> json) {
  return _Material.fromJson(json);
}

/// @nodoc
mixin _$Material {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  String get storeId => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_uz')
  String get nameUz => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_uzs')
  int get priceUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'color_hex')
  String? get colorHex => throw _privateConstructorUsedError;
  @JsonKey(name: 'texture_key')
  String? get textureKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'pbr_roughness')
  double get pbrRoughness => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this Material to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MaterialCopyWith<Material> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialCopyWith<$Res> {
  factory $MaterialCopyWith(Material value, $Res Function(Material) then) =
      _$MaterialCopyWithImpl<$Res, Material>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'store_id') String storeId,
    String category,
    @JsonKey(name: 'name_uz') String nameUz,
    String unit,
    @JsonKey(name: 'price_uzs') int priceUzs,
    @JsonKey(name: 'color_hex') String? colorHex,
    @JsonKey(name: 'texture_key') String? textureKey,
    @JsonKey(name: 'pbr_roughness') double pbrRoughness,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class _$MaterialCopyWithImpl<$Res, $Val extends Material>
    implements $MaterialCopyWith<$Res> {
  _$MaterialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? category = null,
    Object? nameUz = null,
    Object? unit = null,
    Object? priceUzs = null,
    Object? colorHex = freezed,
    Object? textureKey = freezed,
    Object? pbrRoughness = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            storeId: null == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            nameUz: null == nameUz
                ? _value.nameUz
                : nameUz // ignore: cast_nullable_to_non_nullable
                      as String,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            priceUzs: null == priceUzs
                ? _value.priceUzs
                : priceUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            colorHex: freezed == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String?,
            textureKey: freezed == textureKey
                ? _value.textureKey
                : textureKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            pbrRoughness: null == pbrRoughness
                ? _value.pbrRoughness
                : pbrRoughness // ignore: cast_nullable_to_non_nullable
                      as double,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MaterialImplCopyWith<$Res>
    implements $MaterialCopyWith<$Res> {
  factory _$$MaterialImplCopyWith(
    _$MaterialImpl value,
    $Res Function(_$MaterialImpl) then,
  ) = __$$MaterialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'store_id') String storeId,
    String category,
    @JsonKey(name: 'name_uz') String nameUz,
    String unit,
    @JsonKey(name: 'price_uzs') int priceUzs,
    @JsonKey(name: 'color_hex') String? colorHex,
    @JsonKey(name: 'texture_key') String? textureKey,
    @JsonKey(name: 'pbr_roughness') double pbrRoughness,
    @JsonKey(name: 'image_url') String? imageUrl,
  });
}

/// @nodoc
class __$$MaterialImplCopyWithImpl<$Res>
    extends _$MaterialCopyWithImpl<$Res, _$MaterialImpl>
    implements _$$MaterialImplCopyWith<$Res> {
  __$$MaterialImplCopyWithImpl(
    _$MaterialImpl _value,
    $Res Function(_$MaterialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? category = null,
    Object? nameUz = null,
    Object? unit = null,
    Object? priceUzs = null,
    Object? colorHex = freezed,
    Object? textureKey = freezed,
    Object? pbrRoughness = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$MaterialImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        storeId: null == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        nameUz: null == nameUz
            ? _value.nameUz
            : nameUz // ignore: cast_nullable_to_non_nullable
                  as String,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        priceUzs: null == priceUzs
            ? _value.priceUzs
            : priceUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        colorHex: freezed == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String?,
        textureKey: freezed == textureKey
            ? _value.textureKey
            : textureKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        pbrRoughness: null == pbrRoughness
            ? _value.pbrRoughness
            : pbrRoughness // ignore: cast_nullable_to_non_nullable
                  as double,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MaterialImpl implements _Material {
  const _$MaterialImpl({
    required this.id,
    @JsonKey(name: 'store_id') required this.storeId,
    required this.category,
    @JsonKey(name: 'name_uz') required this.nameUz,
    required this.unit,
    @JsonKey(name: 'price_uzs') required this.priceUzs,
    @JsonKey(name: 'color_hex') this.colorHex,
    @JsonKey(name: 'texture_key') this.textureKey,
    @JsonKey(name: 'pbr_roughness') this.pbrRoughness = 1.0,
    @JsonKey(name: 'image_url') this.imageUrl,
  });

  factory _$MaterialImpl.fromJson(Map<String, dynamic> json) =>
      _$$MaterialImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'store_id')
  final String storeId;
  @override
  final String category;
  @override
  @JsonKey(name: 'name_uz')
  final String nameUz;
  @override
  final String unit;
  @override
  @JsonKey(name: 'price_uzs')
  final int priceUzs;
  @override
  @JsonKey(name: 'color_hex')
  final String? colorHex;
  @override
  @JsonKey(name: 'texture_key')
  final String? textureKey;
  @override
  @JsonKey(name: 'pbr_roughness')
  final double pbrRoughness;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'Material(id: $id, storeId: $storeId, category: $category, nameUz: $nameUz, unit: $unit, priceUzs: $priceUzs, colorHex: $colorHex, textureKey: $textureKey, pbrRoughness: $pbrRoughness, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MaterialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.nameUz, nameUz) || other.nameUz == nameUz) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.priceUzs, priceUzs) ||
                other.priceUzs == priceUzs) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.textureKey, textureKey) ||
                other.textureKey == textureKey) &&
            (identical(other.pbrRoughness, pbrRoughness) ||
                other.pbrRoughness == pbrRoughness) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    storeId,
    category,
    nameUz,
    unit,
    priceUzs,
    colorHex,
    textureKey,
    pbrRoughness,
    imageUrl,
  );

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MaterialImplCopyWith<_$MaterialImpl> get copyWith =>
      __$$MaterialImplCopyWithImpl<_$MaterialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MaterialImplToJson(this);
  }
}

abstract class _Material implements Material {
  const factory _Material({
    required final String id,
    @JsonKey(name: 'store_id') required final String storeId,
    required final String category,
    @JsonKey(name: 'name_uz') required final String nameUz,
    required final String unit,
    @JsonKey(name: 'price_uzs') required final int priceUzs,
    @JsonKey(name: 'color_hex') final String? colorHex,
    @JsonKey(name: 'texture_key') final String? textureKey,
    @JsonKey(name: 'pbr_roughness') final double pbrRoughness,
    @JsonKey(name: 'image_url') final String? imageUrl,
  }) = _$MaterialImpl;

  factory _Material.fromJson(Map<String, dynamic> json) =
      _$MaterialImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'store_id')
  String get storeId;
  @override
  String get category;
  @override
  @JsonKey(name: 'name_uz')
  String get nameUz;
  @override
  String get unit;
  @override
  @JsonKey(name: 'price_uzs')
  int get priceUzs;
  @override
  @JsonKey(name: 'color_hex')
  String? get colorHex;
  @override
  @JsonKey(name: 'texture_key')
  String? get textureKey;
  @override
  @JsonKey(name: 'pbr_roughness')
  double get pbrRoughness;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of Material
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MaterialImplCopyWith<_$MaterialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedMaterials _$PaginatedMaterialsFromJson(Map<String, dynamic> json) {
  return _PaginatedMaterials.fromJson(json);
}

/// @nodoc
mixin _$PaginatedMaterials {
  List<Material> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this PaginatedMaterials to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedMaterials
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedMaterialsCopyWith<PaginatedMaterials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedMaterialsCopyWith<$Res> {
  factory $PaginatedMaterialsCopyWith(
    PaginatedMaterials value,
    $Res Function(PaginatedMaterials) then,
  ) = _$PaginatedMaterialsCopyWithImpl<$Res, PaginatedMaterials>;
  @useResult
  $Res call({
    List<Material> items,
    int total,
    int page,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$PaginatedMaterialsCopyWithImpl<$Res, $Val extends PaginatedMaterials>
    implements $PaginatedMaterialsCopyWith<$Res> {
  _$PaginatedMaterialsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedMaterials
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<Material>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedMaterialsImplCopyWith<$Res>
    implements $PaginatedMaterialsCopyWith<$Res> {
  factory _$$PaginatedMaterialsImplCopyWith(
    _$PaginatedMaterialsImpl value,
    $Res Function(_$PaginatedMaterialsImpl) then,
  ) = __$$PaginatedMaterialsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Material> items,
    int total,
    int page,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$PaginatedMaterialsImplCopyWithImpl<$Res>
    extends _$PaginatedMaterialsCopyWithImpl<$Res, _$PaginatedMaterialsImpl>
    implements _$$PaginatedMaterialsImplCopyWith<$Res> {
  __$$PaginatedMaterialsImplCopyWithImpl(
    _$PaginatedMaterialsImpl _value,
    $Res Function(_$PaginatedMaterialsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedMaterials
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(
      _$PaginatedMaterialsImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<Material>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedMaterialsImpl implements _PaginatedMaterials {
  const _$PaginatedMaterialsImpl({
    final List<Material> items = const <Material>[],
    this.total = 0,
    this.page = 1,
    @JsonKey(name: 'per_page') this.perPage = 20,
  }) : _items = items;

  factory _$PaginatedMaterialsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedMaterialsImplFromJson(json);

  final List<Material> _items;
  @override
  @JsonKey()
  List<Material> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;

  @override
  String toString() {
    return 'PaginatedMaterials(items: $items, total: $total, page: $page, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedMaterialsImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    total,
    page,
    perPage,
  );

  /// Create a copy of PaginatedMaterials
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedMaterialsImplCopyWith<_$PaginatedMaterialsImpl> get copyWith =>
      __$$PaginatedMaterialsImplCopyWithImpl<_$PaginatedMaterialsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedMaterialsImplToJson(this);
  }
}

abstract class _PaginatedMaterials implements PaginatedMaterials {
  const factory _PaginatedMaterials({
    final List<Material> items,
    final int total,
    final int page,
    @JsonKey(name: 'per_page') final int perPage,
  }) = _$PaginatedMaterialsImpl;

  factory _PaginatedMaterials.fromJson(Map<String, dynamic> json) =
      _$PaginatedMaterialsImpl.fromJson;

  @override
  List<Material> get items;
  @override
  int get total;
  @override
  int get page;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;

  /// Create a copy of PaginatedMaterials
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedMaterialsImplCopyWith<_$PaginatedMaterialsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Furniture _$FurnitureFromJson(Map<String, dynamic> json) {
  return _Furniture.fromJson(json);
}

/// @nodoc
mixin _$Furniture {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  String? get storeId => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'name_uz')
  String get nameUz => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_uzs')
  int? get priceUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'glb_key')
  String? get glbKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'footprint_w')
  double? get footprintW => throw _privateConstructorUsedError;
  @JsonKey(name: 'footprint_d')
  double? get footprintD => throw _privateConstructorUsedError;

  /// Serializes this Furniture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Furniture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FurnitureCopyWith<Furniture> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FurnitureCopyWith<$Res> {
  factory $FurnitureCopyWith(Furniture value, $Res Function(Furniture) then) =
      _$FurnitureCopyWithImpl<$Res, Furniture>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'store_id') String? storeId,
    String category,
    @JsonKey(name: 'name_uz') String nameUz,
    @JsonKey(name: 'price_uzs') int? priceUzs,
    @JsonKey(name: 'glb_key') String? glbKey,
    @JsonKey(name: 'footprint_w') double? footprintW,
    @JsonKey(name: 'footprint_d') double? footprintD,
  });
}

/// @nodoc
class _$FurnitureCopyWithImpl<$Res, $Val extends Furniture>
    implements $FurnitureCopyWith<$Res> {
  _$FurnitureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Furniture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = freezed,
    Object? category = null,
    Object? nameUz = null,
    Object? priceUzs = freezed,
    Object? glbKey = freezed,
    Object? footprintW = freezed,
    Object? footprintD = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            storeId: freezed == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            nameUz: null == nameUz
                ? _value.nameUz
                : nameUz // ignore: cast_nullable_to_non_nullable
                      as String,
            priceUzs: freezed == priceUzs
                ? _value.priceUzs
                : priceUzs // ignore: cast_nullable_to_non_nullable
                      as int?,
            glbKey: freezed == glbKey
                ? _value.glbKey
                : glbKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            footprintW: freezed == footprintW
                ? _value.footprintW
                : footprintW // ignore: cast_nullable_to_non_nullable
                      as double?,
            footprintD: freezed == footprintD
                ? _value.footprintD
                : footprintD // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FurnitureImplCopyWith<$Res>
    implements $FurnitureCopyWith<$Res> {
  factory _$$FurnitureImplCopyWith(
    _$FurnitureImpl value,
    $Res Function(_$FurnitureImpl) then,
  ) = __$$FurnitureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'store_id') String? storeId,
    String category,
    @JsonKey(name: 'name_uz') String nameUz,
    @JsonKey(name: 'price_uzs') int? priceUzs,
    @JsonKey(name: 'glb_key') String? glbKey,
    @JsonKey(name: 'footprint_w') double? footprintW,
    @JsonKey(name: 'footprint_d') double? footprintD,
  });
}

/// @nodoc
class __$$FurnitureImplCopyWithImpl<$Res>
    extends _$FurnitureCopyWithImpl<$Res, _$FurnitureImpl>
    implements _$$FurnitureImplCopyWith<$Res> {
  __$$FurnitureImplCopyWithImpl(
    _$FurnitureImpl _value,
    $Res Function(_$FurnitureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Furniture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = freezed,
    Object? category = null,
    Object? nameUz = null,
    Object? priceUzs = freezed,
    Object? glbKey = freezed,
    Object? footprintW = freezed,
    Object? footprintD = freezed,
  }) {
    return _then(
      _$FurnitureImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        storeId: freezed == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        nameUz: null == nameUz
            ? _value.nameUz
            : nameUz // ignore: cast_nullable_to_non_nullable
                  as String,
        priceUzs: freezed == priceUzs
            ? _value.priceUzs
            : priceUzs // ignore: cast_nullable_to_non_nullable
                  as int?,
        glbKey: freezed == glbKey
            ? _value.glbKey
            : glbKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        footprintW: freezed == footprintW
            ? _value.footprintW
            : footprintW // ignore: cast_nullable_to_non_nullable
                  as double?,
        footprintD: freezed == footprintD
            ? _value.footprintD
            : footprintD // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FurnitureImpl implements _Furniture {
  const _$FurnitureImpl({
    required this.id,
    @JsonKey(name: 'store_id') this.storeId,
    required this.category,
    @JsonKey(name: 'name_uz') required this.nameUz,
    @JsonKey(name: 'price_uzs') this.priceUzs,
    @JsonKey(name: 'glb_key') this.glbKey,
    @JsonKey(name: 'footprint_w') this.footprintW,
    @JsonKey(name: 'footprint_d') this.footprintD,
  });

  factory _$FurnitureImpl.fromJson(Map<String, dynamic> json) =>
      _$$FurnitureImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'store_id')
  final String? storeId;
  @override
  final String category;
  @override
  @JsonKey(name: 'name_uz')
  final String nameUz;
  @override
  @JsonKey(name: 'price_uzs')
  final int? priceUzs;
  @override
  @JsonKey(name: 'glb_key')
  final String? glbKey;
  @override
  @JsonKey(name: 'footprint_w')
  final double? footprintW;
  @override
  @JsonKey(name: 'footprint_d')
  final double? footprintD;

  @override
  String toString() {
    return 'Furniture(id: $id, storeId: $storeId, category: $category, nameUz: $nameUz, priceUzs: $priceUzs, glbKey: $glbKey, footprintW: $footprintW, footprintD: $footprintD)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FurnitureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.nameUz, nameUz) || other.nameUz == nameUz) &&
            (identical(other.priceUzs, priceUzs) ||
                other.priceUzs == priceUzs) &&
            (identical(other.glbKey, glbKey) || other.glbKey == glbKey) &&
            (identical(other.footprintW, footprintW) ||
                other.footprintW == footprintW) &&
            (identical(other.footprintD, footprintD) ||
                other.footprintD == footprintD));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    storeId,
    category,
    nameUz,
    priceUzs,
    glbKey,
    footprintW,
    footprintD,
  );

  /// Create a copy of Furniture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FurnitureImplCopyWith<_$FurnitureImpl> get copyWith =>
      __$$FurnitureImplCopyWithImpl<_$FurnitureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FurnitureImplToJson(this);
  }
}

abstract class _Furniture implements Furniture {
  const factory _Furniture({
    required final String id,
    @JsonKey(name: 'store_id') final String? storeId,
    required final String category,
    @JsonKey(name: 'name_uz') required final String nameUz,
    @JsonKey(name: 'price_uzs') final int? priceUzs,
    @JsonKey(name: 'glb_key') final String? glbKey,
    @JsonKey(name: 'footprint_w') final double? footprintW,
    @JsonKey(name: 'footprint_d') final double? footprintD,
  }) = _$FurnitureImpl;

  factory _Furniture.fromJson(Map<String, dynamic> json) =
      _$FurnitureImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'store_id')
  String? get storeId;
  @override
  String get category;
  @override
  @JsonKey(name: 'name_uz')
  String get nameUz;
  @override
  @JsonKey(name: 'price_uzs')
  int? get priceUzs;
  @override
  @JsonKey(name: 'glb_key')
  String? get glbKey;
  @override
  @JsonKey(name: 'footprint_w')
  double? get footprintW;
  @override
  @JsonKey(name: 'footprint_d')
  double? get footprintD;

  /// Create a copy of Furniture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FurnitureImplCopyWith<_$FurnitureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedFurniture _$PaginatedFurnitureFromJson(Map<String, dynamic> json) {
  return _PaginatedFurniture.fromJson(json);
}

/// @nodoc
mixin _$PaginatedFurniture {
  List<Furniture> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;

  /// Serializes this PaginatedFurniture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedFurniture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedFurnitureCopyWith<PaginatedFurniture> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedFurnitureCopyWith<$Res> {
  factory $PaginatedFurnitureCopyWith(
    PaginatedFurniture value,
    $Res Function(PaginatedFurniture) then,
  ) = _$PaginatedFurnitureCopyWithImpl<$Res, PaginatedFurniture>;
  @useResult
  $Res call({
    List<Furniture> items,
    int total,
    int page,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class _$PaginatedFurnitureCopyWithImpl<$Res, $Val extends PaginatedFurniture>
    implements $PaginatedFurnitureCopyWith<$Res> {
  _$PaginatedFurnitureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedFurniture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<Furniture>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedFurnitureImplCopyWith<$Res>
    implements $PaginatedFurnitureCopyWith<$Res> {
  factory _$$PaginatedFurnitureImplCopyWith(
    _$PaginatedFurnitureImpl value,
    $Res Function(_$PaginatedFurnitureImpl) then,
  ) = __$$PaginatedFurnitureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Furniture> items,
    int total,
    int page,
    @JsonKey(name: 'per_page') int perPage,
  });
}

/// @nodoc
class __$$PaginatedFurnitureImplCopyWithImpl<$Res>
    extends _$PaginatedFurnitureCopyWithImpl<$Res, _$PaginatedFurnitureImpl>
    implements _$$PaginatedFurnitureImplCopyWith<$Res> {
  __$$PaginatedFurnitureImplCopyWithImpl(
    _$PaginatedFurnitureImpl _value,
    $Res Function(_$PaginatedFurnitureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedFurniture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? page = null,
    Object? perPage = null,
  }) {
    return _then(
      _$PaginatedFurnitureImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<Furniture>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedFurnitureImpl implements _PaginatedFurniture {
  const _$PaginatedFurnitureImpl({
    final List<Furniture> items = const <Furniture>[],
    this.total = 0,
    this.page = 1,
    @JsonKey(name: 'per_page') this.perPage = 20,
  }) : _items = items;

  factory _$PaginatedFurnitureImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedFurnitureImplFromJson(json);

  final List<Furniture> _items;
  @override
  @JsonKey()
  List<Furniture> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;

  @override
  String toString() {
    return 'PaginatedFurniture(items: $items, total: $total, page: $page, perPage: $perPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedFurnitureImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    total,
    page,
    perPage,
  );

  /// Create a copy of PaginatedFurniture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedFurnitureImplCopyWith<_$PaginatedFurnitureImpl> get copyWith =>
      __$$PaginatedFurnitureImplCopyWithImpl<_$PaginatedFurnitureImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedFurnitureImplToJson(this);
  }
}

abstract class _PaginatedFurniture implements PaginatedFurniture {
  const factory _PaginatedFurniture({
    final List<Furniture> items,
    final int total,
    final int page,
    @JsonKey(name: 'per_page') final int perPage,
  }) = _$PaginatedFurnitureImpl;

  factory _PaginatedFurniture.fromJson(Map<String, dynamic> json) =
      _$PaginatedFurnitureImpl.fromJson;

  @override
  List<Furniture> get items;
  @override
  int get total;
  @override
  int get page;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;

  /// Create a copy of PaginatedFurniture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedFurnitureImplCopyWith<_$PaginatedFurnitureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Store _$StoreFromJson(Map<String, dynamic> json) {
  return _Store.fromJson(json);
}

/// @nodoc
mixin _$Store {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get telegram => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_color')
  String? get logoColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'partner_tier')
  String get partnerTier => throw _privateConstructorUsedError;

  /// Serializes this Store to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Store
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreCopyWith<Store> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreCopyWith<$Res> {
  factory $StoreCopyWith(Store value, $Res Function(Store) then) =
      _$StoreCopyWithImpl<$Res, Store>;
  @useResult
  $Res call({
    String id,
    String name,
    String? district,
    String? phone,
    String? telegram,
    @JsonKey(name: 'logo_color') String? logoColor,
    @JsonKey(name: 'partner_tier') String partnerTier,
  });
}

/// @nodoc
class _$StoreCopyWithImpl<$Res, $Val extends Store>
    implements $StoreCopyWith<$Res> {
  _$StoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Store
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? district = freezed,
    Object? phone = freezed,
    Object? telegram = freezed,
    Object? logoColor = freezed,
    Object? partnerTier = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            district: freezed == district
                ? _value.district
                : district // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            telegram: freezed == telegram
                ? _value.telegram
                : telegram // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoColor: freezed == logoColor
                ? _value.logoColor
                : logoColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            partnerTier: null == partnerTier
                ? _value.partnerTier
                : partnerTier // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoreImplCopyWith<$Res> implements $StoreCopyWith<$Res> {
  factory _$$StoreImplCopyWith(
    _$StoreImpl value,
    $Res Function(_$StoreImpl) then,
  ) = __$$StoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? district,
    String? phone,
    String? telegram,
    @JsonKey(name: 'logo_color') String? logoColor,
    @JsonKey(name: 'partner_tier') String partnerTier,
  });
}

/// @nodoc
class __$$StoreImplCopyWithImpl<$Res>
    extends _$StoreCopyWithImpl<$Res, _$StoreImpl>
    implements _$$StoreImplCopyWith<$Res> {
  __$$StoreImplCopyWithImpl(
    _$StoreImpl _value,
    $Res Function(_$StoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Store
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? district = freezed,
    Object? phone = freezed,
    Object? telegram = freezed,
    Object? logoColor = freezed,
    Object? partnerTier = null,
  }) {
    return _then(
      _$StoreImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        district: freezed == district
            ? _value.district
            : district // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        telegram: freezed == telegram
            ? _value.telegram
            : telegram // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoColor: freezed == logoColor
            ? _value.logoColor
            : logoColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        partnerTier: null == partnerTier
            ? _value.partnerTier
            : partnerTier // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoreImpl implements _Store {
  const _$StoreImpl({
    required this.id,
    required this.name,
    this.district,
    this.phone,
    this.telegram,
    @JsonKey(name: 'logo_color') this.logoColor,
    @JsonKey(name: 'partner_tier') required this.partnerTier,
  });

  factory _$StoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoreImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? district;
  @override
  final String? phone;
  @override
  final String? telegram;
  @override
  @JsonKey(name: 'logo_color')
  final String? logoColor;
  @override
  @JsonKey(name: 'partner_tier')
  final String partnerTier;

  @override
  String toString() {
    return 'Store(id: $id, name: $name, district: $district, phone: $phone, telegram: $telegram, logoColor: $logoColor, partnerTier: $partnerTier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.telegram, telegram) ||
                other.telegram == telegram) &&
            (identical(other.logoColor, logoColor) ||
                other.logoColor == logoColor) &&
            (identical(other.partnerTier, partnerTier) ||
                other.partnerTier == partnerTier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    district,
    phone,
    telegram,
    logoColor,
    partnerTier,
  );

  /// Create a copy of Store
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreImplCopyWith<_$StoreImpl> get copyWith =>
      __$$StoreImplCopyWithImpl<_$StoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoreImplToJson(this);
  }
}

abstract class _Store implements Store {
  const factory _Store({
    required final String id,
    required final String name,
    final String? district,
    final String? phone,
    final String? telegram,
    @JsonKey(name: 'logo_color') final String? logoColor,
    @JsonKey(name: 'partner_tier') required final String partnerTier,
  }) = _$StoreImpl;

  factory _Store.fromJson(Map<String, dynamic> json) = _$StoreImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get district;
  @override
  String? get phone;
  @override
  String? get telegram;
  @override
  @JsonKey(name: 'logo_color')
  String? get logoColor;
  @override
  @JsonKey(name: 'partner_tier')
  String get partnerTier;

  /// Create a copy of Store
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreImplCopyWith<_$StoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
