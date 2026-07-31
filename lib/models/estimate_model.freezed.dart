// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EstimateLineItem _$EstimateLineItemFromJson(Map<String, dynamic> json) {
  return _EstimateLineItem.fromJson(json);
}

/// @nodoc
mixin _$EstimateLineItem {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get lineTotal => throw _privateConstructorUsedError;

  /// Serializes this EstimateLineItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EstimateLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimateLineItemCopyWith<EstimateLineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimateLineItemCopyWith<$Res> {
  factory $EstimateLineItemCopyWith(
    EstimateLineItem value,
    $Res Function(EstimateLineItem) then,
  ) = _$EstimateLineItemCopyWithImpl<$Res, EstimateLineItem>;
  @useResult
  $Res call({
    String id,
    String description,
    double quantity,
    double unitPrice,
    double lineTotal,
  });
}

/// @nodoc
class _$EstimateLineItemCopyWithImpl<$Res, $Val extends EstimateLineItem>
    implements $EstimateLineItemCopyWith<$Res> {
  _$EstimateLineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimateLineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            lineTotal: null == lineTotal
                ? _value.lineTotal
                : lineTotal // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EstimateLineItemImplCopyWith<$Res>
    implements $EstimateLineItemCopyWith<$Res> {
  factory _$$EstimateLineItemImplCopyWith(
    _$EstimateLineItemImpl value,
    $Res Function(_$EstimateLineItemImpl) then,
  ) = __$$EstimateLineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String description,
    double quantity,
    double unitPrice,
    double lineTotal,
  });
}

/// @nodoc
class __$$EstimateLineItemImplCopyWithImpl<$Res>
    extends _$EstimateLineItemCopyWithImpl<$Res, _$EstimateLineItemImpl>
    implements _$$EstimateLineItemImplCopyWith<$Res> {
  __$$EstimateLineItemImplCopyWithImpl(
    _$EstimateLineItemImpl _value,
    $Res Function(_$EstimateLineItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EstimateLineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? lineTotal = null,
  }) {
    return _then(
      _$EstimateLineItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        lineTotal: null == lineTotal
            ? _value.lineTotal
            : lineTotal // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimateLineItemImpl implements _EstimateLineItem {
  const _$EstimateLineItemImpl({
    required this.id,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });

  factory _$EstimateLineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimateLineItemImplFromJson(json);

  @override
  final String id;
  @override
  final String description;
  @override
  final double quantity;
  @override
  final double unitPrice;
  @override
  final double lineTotal;

  @override
  String toString() {
    return 'EstimateLineItem(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice, lineTotal: $lineTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimateLineItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.lineTotal, lineTotal) ||
                other.lineTotal == lineTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, description, quantity, unitPrice, lineTotal);

  /// Create a copy of EstimateLineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimateLineItemImplCopyWith<_$EstimateLineItemImpl> get copyWith =>
      __$$EstimateLineItemImplCopyWithImpl<_$EstimateLineItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimateLineItemImplToJson(this);
  }
}

abstract class _EstimateLineItem implements EstimateLineItem {
  const factory _EstimateLineItem({
    required final String id,
    required final String description,
    required final double quantity,
    required final double unitPrice,
    required final double lineTotal,
  }) = _$EstimateLineItemImpl;

  factory _EstimateLineItem.fromJson(Map<String, dynamic> json) =
      _$EstimateLineItemImpl.fromJson;

  @override
  String get id;
  @override
  String get description;
  @override
  double get quantity;
  @override
  double get unitPrice;
  @override
  double get lineTotal;

  /// Create a copy of EstimateLineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimateLineItemImplCopyWith<_$EstimateLineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EstimateStage _$EstimateStageFromJson(Map<String, dynamic> json) {
  return _EstimateStage.fromJson(json);
}

/// @nodoc
mixin _$EstimateStage {
  EstimateStageName get name => throw _privateConstructorUsedError;
  List<EstimateLineItem> get lineItems => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;

  /// Serializes this EstimateStage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EstimateStage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimateStageCopyWith<EstimateStage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimateStageCopyWith<$Res> {
  factory $EstimateStageCopyWith(
    EstimateStage value,
    $Res Function(EstimateStage) then,
  ) = _$EstimateStageCopyWithImpl<$Res, EstimateStage>;
  @useResult
  $Res call({
    EstimateStageName name,
    List<EstimateLineItem> lineItems,
    double subtotal,
  });
}

/// @nodoc
class _$EstimateStageCopyWithImpl<$Res, $Val extends EstimateStage>
    implements $EstimateStageCopyWith<$Res> {
  _$EstimateStageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimateStage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lineItems = null,
    Object? subtotal = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as EstimateStageName,
            lineItems: null == lineItems
                ? _value.lineItems
                : lineItems // ignore: cast_nullable_to_non_nullable
                      as List<EstimateLineItem>,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EstimateStageImplCopyWith<$Res>
    implements $EstimateStageCopyWith<$Res> {
  factory _$$EstimateStageImplCopyWith(
    _$EstimateStageImpl value,
    $Res Function(_$EstimateStageImpl) then,
  ) = __$$EstimateStageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EstimateStageName name,
    List<EstimateLineItem> lineItems,
    double subtotal,
  });
}

/// @nodoc
class __$$EstimateStageImplCopyWithImpl<$Res>
    extends _$EstimateStageCopyWithImpl<$Res, _$EstimateStageImpl>
    implements _$$EstimateStageImplCopyWith<$Res> {
  __$$EstimateStageImplCopyWithImpl(
    _$EstimateStageImpl _value,
    $Res Function(_$EstimateStageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EstimateStage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? lineItems = null,
    Object? subtotal = null,
  }) {
    return _then(
      _$EstimateStageImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as EstimateStageName,
        lineItems: null == lineItems
            ? _value._lineItems
            : lineItems // ignore: cast_nullable_to_non_nullable
                  as List<EstimateLineItem>,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimateStageImpl implements _EstimateStage {
  const _$EstimateStageImpl({
    required this.name,
    final List<EstimateLineItem> lineItems = const <EstimateLineItem>[],
    required this.subtotal,
  }) : _lineItems = lineItems;

  factory _$EstimateStageImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimateStageImplFromJson(json);

  @override
  final EstimateStageName name;
  final List<EstimateLineItem> _lineItems;
  @override
  @JsonKey()
  List<EstimateLineItem> get lineItems {
    if (_lineItems is EqualUnmodifiableListView) return _lineItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lineItems);
  }

  @override
  final double subtotal;

  @override
  String toString() {
    return 'EstimateStage(name: $name, lineItems: $lineItems, subtotal: $subtotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimateStageImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._lineItems,
              _lineItems,
            ) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    const DeepCollectionEquality().hash(_lineItems),
    subtotal,
  );

  /// Create a copy of EstimateStage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimateStageImplCopyWith<_$EstimateStageImpl> get copyWith =>
      __$$EstimateStageImplCopyWithImpl<_$EstimateStageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimateStageImplToJson(this);
  }
}

abstract class _EstimateStage implements EstimateStage {
  const factory _EstimateStage({
    required final EstimateStageName name,
    final List<EstimateLineItem> lineItems,
    required final double subtotal,
  }) = _$EstimateStageImpl;

  factory _EstimateStage.fromJson(Map<String, dynamic> json) =
      _$EstimateStageImpl.fromJson;

  @override
  EstimateStageName get name;
  @override
  List<EstimateLineItem> get lineItems;
  @override
  double get subtotal;

  /// Create a copy of EstimateStage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimateStageImplCopyWith<_$EstimateStageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Estimate _$EstimateFromJson(Map<String, dynamic> json) {
  return _Estimate.fromJson(json);
}

/// @nodoc
mixin _$Estimate {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  double get roomArea => throw _privateConstructorUsedError;
  List<EstimateStage> get stages => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Estimate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Estimate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimateCopyWith<Estimate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimateCopyWith<$Res> {
  factory $EstimateCopyWith(Estimate value, $Res Function(Estimate) then) =
      _$EstimateCopyWithImpl<$Res, Estimate>;
  @useResult
  $Res call({
    String id,
    String roomId,
    double roomArea,
    List<EstimateStage> stages,
    double totalPrice,
    String currency,
    DateTime createdAt,
  });
}

/// @nodoc
class _$EstimateCopyWithImpl<$Res, $Val extends Estimate>
    implements $EstimateCopyWith<$Res> {
  _$EstimateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Estimate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? roomArea = null,
    Object? stages = null,
    Object? totalPrice = null,
    Object? currency = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            roomArea: null == roomArea
                ? _value.roomArea
                : roomArea // ignore: cast_nullable_to_non_nullable
                      as double,
            stages: null == stages
                ? _value.stages
                : stages // ignore: cast_nullable_to_non_nullable
                      as List<EstimateStage>,
            totalPrice: null == totalPrice
                ? _value.totalPrice
                : totalPrice // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EstimateImplCopyWith<$Res>
    implements $EstimateCopyWith<$Res> {
  factory _$$EstimateImplCopyWith(
    _$EstimateImpl value,
    $Res Function(_$EstimateImpl) then,
  ) = __$$EstimateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String roomId,
    double roomArea,
    List<EstimateStage> stages,
    double totalPrice,
    String currency,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$EstimateImplCopyWithImpl<$Res>
    extends _$EstimateCopyWithImpl<$Res, _$EstimateImpl>
    implements _$$EstimateImplCopyWith<$Res> {
  __$$EstimateImplCopyWithImpl(
    _$EstimateImpl _value,
    $Res Function(_$EstimateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Estimate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? roomArea = null,
    Object? stages = null,
    Object? totalPrice = null,
    Object? currency = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$EstimateImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        roomArea: null == roomArea
            ? _value.roomArea
            : roomArea // ignore: cast_nullable_to_non_nullable
                  as double,
        stages: null == stages
            ? _value._stages
            : stages // ignore: cast_nullable_to_non_nullable
                  as List<EstimateStage>,
        totalPrice: null == totalPrice
            ? _value.totalPrice
            : totalPrice // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimateImpl implements _Estimate {
  const _$EstimateImpl({
    required this.id,
    required this.roomId,
    required this.roomArea,
    final List<EstimateStage> stages = const <EstimateStage>[],
    required this.totalPrice,
    required this.currency,
    required this.createdAt,
  }) : _stages = stages;

  factory _$EstimateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimateImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  @override
  final double roomArea;
  final List<EstimateStage> _stages;
  @override
  @JsonKey()
  List<EstimateStage> get stages {
    if (_stages is EqualUnmodifiableListView) return _stages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stages);
  }

  @override
  final double totalPrice;
  @override
  final String currency;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Estimate(id: $id, roomId: $roomId, roomArea: $roomArea, stages: $stages, totalPrice: $totalPrice, currency: $currency, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomArea, roomArea) ||
                other.roomArea == roomArea) &&
            const DeepCollectionEquality().equals(other._stages, _stages) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    roomArea,
    const DeepCollectionEquality().hash(_stages),
    totalPrice,
    currency,
    createdAt,
  );

  /// Create a copy of Estimate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimateImplCopyWith<_$EstimateImpl> get copyWith =>
      __$$EstimateImplCopyWithImpl<_$EstimateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimateImplToJson(this);
  }
}

abstract class _Estimate implements Estimate {
  const factory _Estimate({
    required final String id,
    required final String roomId,
    required final double roomArea,
    final List<EstimateStage> stages,
    required final double totalPrice,
    required final String currency,
    required final DateTime createdAt,
  }) = _$EstimateImpl;

  factory _Estimate.fromJson(Map<String, dynamic> json) =
      _$EstimateImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  double get roomArea;
  @override
  List<EstimateStage> get stages;
  @override
  double get totalPrice;
  @override
  String get currency;
  @override
  DateTime get createdAt;

  /// Create a copy of Estimate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimateImplCopyWith<_$EstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
