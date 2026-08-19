// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderLineCreate _$OrderLineCreateFromJson(Map<String, dynamic> json) {
  return _OrderLineCreate.fromJson(json);
}

/// @nodoc
mixin _$OrderLineCreate {
  @JsonKey(name: 'material_id')
  String? get materialId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price_uzs')
  int get unitPriceUzs => throw _privateConstructorUsedError;
  num get quantity => throw _privateConstructorUsedError;

  /// Serializes this OrderLineCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderLineCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderLineCreateCopyWith<OrderLineCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderLineCreateCopyWith<$Res> {
  factory $OrderLineCreateCopyWith(
    OrderLineCreate value,
    $Res Function(OrderLineCreate) then,
  ) = _$OrderLineCreateCopyWithImpl<$Res, OrderLineCreate>;
  @useResult
  $Res call({
    @JsonKey(name: 'material_id') String? materialId,
    @JsonKey(name: 'product_name') String productName,
    String unit,
    @JsonKey(name: 'unit_price_uzs') int unitPriceUzs,
    num quantity,
  });
}

/// @nodoc
class _$OrderLineCreateCopyWithImpl<$Res, $Val extends OrderLineCreate>
    implements $OrderLineCreateCopyWith<$Res> {
  _$OrderLineCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderLineCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialId = freezed,
    Object? productName = null,
    Object? unit = null,
    Object? unitPriceUzs = null,
    Object? quantity = null,
  }) {
    return _then(
      _value.copyWith(
            materialId: freezed == materialId
                ? _value.materialId
                : materialId // ignore: cast_nullable_to_non_nullable
                      as String?,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            unitPriceUzs: null == unitPriceUzs
                ? _value.unitPriceUzs
                : unitPriceUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderLineCreateImplCopyWith<$Res>
    implements $OrderLineCreateCopyWith<$Res> {
  factory _$$OrderLineCreateImplCopyWith(
    _$OrderLineCreateImpl value,
    $Res Function(_$OrderLineCreateImpl) then,
  ) = __$$OrderLineCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'material_id') String? materialId,
    @JsonKey(name: 'product_name') String productName,
    String unit,
    @JsonKey(name: 'unit_price_uzs') int unitPriceUzs,
    num quantity,
  });
}

/// @nodoc
class __$$OrderLineCreateImplCopyWithImpl<$Res>
    extends _$OrderLineCreateCopyWithImpl<$Res, _$OrderLineCreateImpl>
    implements _$$OrderLineCreateImplCopyWith<$Res> {
  __$$OrderLineCreateImplCopyWithImpl(
    _$OrderLineCreateImpl _value,
    $Res Function(_$OrderLineCreateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderLineCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? materialId = freezed,
    Object? productName = null,
    Object? unit = null,
    Object? unitPriceUzs = null,
    Object? quantity = null,
  }) {
    return _then(
      _$OrderLineCreateImpl(
        materialId: freezed == materialId
            ? _value.materialId
            : materialId // ignore: cast_nullable_to_non_nullable
                  as String?,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        unitPriceUzs: null == unitPriceUzs
            ? _value.unitPriceUzs
            : unitPriceUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderLineCreateImpl implements _OrderLineCreate {
  const _$OrderLineCreateImpl({
    @JsonKey(name: 'material_id') this.materialId,
    @JsonKey(name: 'product_name') required this.productName,
    required this.unit,
    @JsonKey(name: 'unit_price_uzs') required this.unitPriceUzs,
    required this.quantity,
  });

  factory _$OrderLineCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderLineCreateImplFromJson(json);

  @override
  @JsonKey(name: 'material_id')
  final String? materialId;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  final String unit;
  @override
  @JsonKey(name: 'unit_price_uzs')
  final int unitPriceUzs;
  @override
  final num quantity;

  @override
  String toString() {
    return 'OrderLineCreate(materialId: $materialId, productName: $productName, unit: $unit, unitPriceUzs: $unitPriceUzs, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderLineCreateImpl &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitPriceUzs, unitPriceUzs) ||
                other.unitPriceUzs == unitPriceUzs) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    materialId,
    productName,
    unit,
    unitPriceUzs,
    quantity,
  );

  /// Create a copy of OrderLineCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderLineCreateImplCopyWith<_$OrderLineCreateImpl> get copyWith =>
      __$$OrderLineCreateImplCopyWithImpl<_$OrderLineCreateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderLineCreateImplToJson(this);
  }
}

abstract class _OrderLineCreate implements OrderLineCreate {
  const factory _OrderLineCreate({
    @JsonKey(name: 'material_id') final String? materialId,
    @JsonKey(name: 'product_name') required final String productName,
    required final String unit,
    @JsonKey(name: 'unit_price_uzs') required final int unitPriceUzs,
    required final num quantity,
  }) = _$OrderLineCreateImpl;

  factory _OrderLineCreate.fromJson(Map<String, dynamic> json) =
      _$OrderLineCreateImpl.fromJson;

  @override
  @JsonKey(name: 'material_id')
  String? get materialId;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  String get unit;
  @override
  @JsonKey(name: 'unit_price_uzs')
  int get unitPriceUzs;
  @override
  num get quantity;

  /// Create a copy of OrderLineCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderLineCreateImplCopyWith<_$OrderLineCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServerOrderLine _$ServerOrderLineFromJson(Map<String, dynamic> json) {
  return _ServerOrderLine.fromJson(json);
}

/// @nodoc
mixin _$ServerOrderLine {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'material_id')
  String? get materialId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price_uzs')
  int get unitPriceUzs => throw _privateConstructorUsedError;
  num get quantity => throw _privateConstructorUsedError;

  /// Serializes this ServerOrderLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerOrderLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerOrderLineCopyWith<ServerOrderLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerOrderLineCopyWith<$Res> {
  factory $ServerOrderLineCopyWith(
    ServerOrderLine value,
    $Res Function(ServerOrderLine) then,
  ) = _$ServerOrderLineCopyWithImpl<$Res, ServerOrderLine>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'material_id') String? materialId,
    @JsonKey(name: 'product_name') String productName,
    String unit,
    @JsonKey(name: 'unit_price_uzs') int unitPriceUzs,
    num quantity,
  });
}

/// @nodoc
class _$ServerOrderLineCopyWithImpl<$Res, $Val extends ServerOrderLine>
    implements $ServerOrderLineCopyWith<$Res> {
  _$ServerOrderLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerOrderLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? materialId = freezed,
    Object? productName = null,
    Object? unit = null,
    Object? unitPriceUzs = null,
    Object? quantity = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            materialId: freezed == materialId
                ? _value.materialId
                : materialId // ignore: cast_nullable_to_non_nullable
                      as String?,
            productName: null == productName
                ? _value.productName
                : productName // ignore: cast_nullable_to_non_nullable
                      as String,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            unitPriceUzs: null == unitPriceUzs
                ? _value.unitPriceUzs
                : unitPriceUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as num,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServerOrderLineImplCopyWith<$Res>
    implements $ServerOrderLineCopyWith<$Res> {
  factory _$$ServerOrderLineImplCopyWith(
    _$ServerOrderLineImpl value,
    $Res Function(_$ServerOrderLineImpl) then,
  ) = __$$ServerOrderLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'material_id') String? materialId,
    @JsonKey(name: 'product_name') String productName,
    String unit,
    @JsonKey(name: 'unit_price_uzs') int unitPriceUzs,
    num quantity,
  });
}

/// @nodoc
class __$$ServerOrderLineImplCopyWithImpl<$Res>
    extends _$ServerOrderLineCopyWithImpl<$Res, _$ServerOrderLineImpl>
    implements _$$ServerOrderLineImplCopyWith<$Res> {
  __$$ServerOrderLineImplCopyWithImpl(
    _$ServerOrderLineImpl _value,
    $Res Function(_$ServerOrderLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServerOrderLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? materialId = freezed,
    Object? productName = null,
    Object? unit = null,
    Object? unitPriceUzs = null,
    Object? quantity = null,
  }) {
    return _then(
      _$ServerOrderLineImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        materialId: freezed == materialId
            ? _value.materialId
            : materialId // ignore: cast_nullable_to_non_nullable
                  as String?,
        productName: null == productName
            ? _value.productName
            : productName // ignore: cast_nullable_to_non_nullable
                  as String,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        unitPriceUzs: null == unitPriceUzs
            ? _value.unitPriceUzs
            : unitPriceUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as num,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerOrderLineImpl implements _ServerOrderLine {
  const _$ServerOrderLineImpl({
    required this.id,
    @JsonKey(name: 'material_id') this.materialId,
    @JsonKey(name: 'product_name') required this.productName,
    required this.unit,
    @JsonKey(name: 'unit_price_uzs') required this.unitPriceUzs,
    required this.quantity,
  });

  factory _$ServerOrderLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerOrderLineImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'material_id')
  final String? materialId;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  final String unit;
  @override
  @JsonKey(name: 'unit_price_uzs')
  final int unitPriceUzs;
  @override
  final num quantity;

  @override
  String toString() {
    return 'ServerOrderLine(id: $id, materialId: $materialId, productName: $productName, unit: $unit, unitPriceUzs: $unitPriceUzs, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerOrderLineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.materialId, materialId) ||
                other.materialId == materialId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitPriceUzs, unitPriceUzs) ||
                other.unitPriceUzs == unitPriceUzs) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    materialId,
    productName,
    unit,
    unitPriceUzs,
    quantity,
  );

  /// Create a copy of ServerOrderLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerOrderLineImplCopyWith<_$ServerOrderLineImpl> get copyWith =>
      __$$ServerOrderLineImplCopyWithImpl<_$ServerOrderLineImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerOrderLineImplToJson(this);
  }
}

abstract class _ServerOrderLine implements ServerOrderLine {
  const factory _ServerOrderLine({
    required final String id,
    @JsonKey(name: 'material_id') final String? materialId,
    @JsonKey(name: 'product_name') required final String productName,
    required final String unit,
    @JsonKey(name: 'unit_price_uzs') required final int unitPriceUzs,
    required final num quantity,
  }) = _$ServerOrderLineImpl;

  factory _ServerOrderLine.fromJson(Map<String, dynamic> json) =
      _$ServerOrderLineImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'material_id')
  String? get materialId;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  String get unit;
  @override
  @JsonKey(name: 'unit_price_uzs')
  int get unitPriceUzs;
  @override
  num get quantity;

  /// Create a copy of ServerOrderLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerOrderLineImplCopyWith<_$ServerOrderLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServerOrder _$ServerOrderFromJson(Map<String, dynamic> json) {
  return _ServerOrder.fromJson(json);
}

/// @nodoc
mixin _$ServerOrder {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'dealer_name')
  String get dealerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_uzs')
  int get totalUzs => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<ServerOrderLine> get lines => throw _privateConstructorUsedError;

  /// Serializes this ServerOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerOrderCopyWith<ServerOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerOrderCopyWith<$Res> {
  factory $ServerOrderCopyWith(
    ServerOrder value,
    $Res Function(ServerOrder) then,
  ) = _$ServerOrderCopyWithImpl<$Res, ServerOrder>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'dealer_name') String dealerName,
    @JsonKey(name: 'total_uzs') int totalUzs,
    OrderStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    List<ServerOrderLine> lines,
  });
}

/// @nodoc
class _$ServerOrderCopyWithImpl<$Res, $Val extends ServerOrder>
    implements $ServerOrderCopyWith<$Res> {
  _$ServerOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? dealerName = null,
    Object? totalUzs = null,
    Object? status = null,
    Object? createdAt = null,
    Object? lines = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            dealerName: null == dealerName
                ? _value.dealerName
                : dealerName // ignore: cast_nullable_to_non_nullable
                      as String,
            totalUzs: null == totalUzs
                ? _value.totalUzs
                : totalUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OrderStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<ServerOrderLine>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServerOrderImplCopyWith<$Res>
    implements $ServerOrderCopyWith<$Res> {
  factory _$$ServerOrderImplCopyWith(
    _$ServerOrderImpl value,
    $Res Function(_$ServerOrderImpl) then,
  ) = __$$ServerOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'dealer_name') String dealerName,
    @JsonKey(name: 'total_uzs') int totalUzs,
    OrderStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    List<ServerOrderLine> lines,
  });
}

/// @nodoc
class __$$ServerOrderImplCopyWithImpl<$Res>
    extends _$ServerOrderCopyWithImpl<$Res, _$ServerOrderImpl>
    implements _$$ServerOrderImplCopyWith<$Res> {
  __$$ServerOrderImplCopyWithImpl(
    _$ServerOrderImpl _value,
    $Res Function(_$ServerOrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ServerOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? dealerName = null,
    Object? totalUzs = null,
    Object? status = null,
    Object? createdAt = null,
    Object? lines = null,
  }) {
    return _then(
      _$ServerOrderImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        dealerName: null == dealerName
            ? _value.dealerName
            : dealerName // ignore: cast_nullable_to_non_nullable
                  as String,
        totalUzs: null == totalUzs
            ? _value.totalUzs
            : totalUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OrderStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<ServerOrderLine>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerOrderImpl implements _ServerOrder {
  const _$ServerOrderImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'dealer_name') required this.dealerName,
    @JsonKey(name: 'total_uzs') required this.totalUzs,
    required this.status,
    @JsonKey(name: 'created_at') required this.createdAt,
    final List<ServerOrderLine> lines = const <ServerOrderLine>[],
  }) : _lines = lines;

  factory _$ServerOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerOrderImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'dealer_name')
  final String dealerName;
  @override
  @JsonKey(name: 'total_uzs')
  final int totalUzs;
  @override
  final OrderStatus status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<ServerOrderLine> _lines;
  @override
  @JsonKey()
  List<ServerOrderLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  String toString() {
    return 'ServerOrder(id: $id, userId: $userId, dealerName: $dealerName, totalUzs: $totalUzs, status: $status, createdAt: $createdAt, lines: $lines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.dealerName, dealerName) ||
                other.dealerName == dealerName) &&
            (identical(other.totalUzs, totalUzs) ||
                other.totalUzs == totalUzs) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._lines, _lines));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    dealerName,
    totalUzs,
    status,
    createdAt,
    const DeepCollectionEquality().hash(_lines),
  );

  /// Create a copy of ServerOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerOrderImplCopyWith<_$ServerOrderImpl> get copyWith =>
      __$$ServerOrderImplCopyWithImpl<_$ServerOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerOrderImplToJson(this);
  }
}

abstract class _ServerOrder implements ServerOrder {
  const factory _ServerOrder({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'dealer_name') required final String dealerName,
    @JsonKey(name: 'total_uzs') required final int totalUzs,
    required final OrderStatus status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    final List<ServerOrderLine> lines,
  }) = _$ServerOrderImpl;

  factory _ServerOrder.fromJson(Map<String, dynamic> json) =
      _$ServerOrderImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'dealer_name')
  String get dealerName;
  @override
  @JsonKey(name: 'total_uzs')
  int get totalUzs;
  @override
  OrderStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  List<ServerOrderLine> get lines;

  /// Create a copy of ServerOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerOrderImplCopyWith<_$ServerOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
