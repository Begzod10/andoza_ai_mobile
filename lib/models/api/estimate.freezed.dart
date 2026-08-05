// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EstimateLine _$EstimateLineFromJson(Map<String, dynamic> json) {
  return _EstimateLine.fromJson(json);
}

/// @nodoc
mixin _$EstimateLine {
  String get label => throw _privateConstructorUsedError;
  String get formula => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_price')
  int get unitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_uzs')
  int get totalUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approximate')
  bool get isApproximate => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_id')
  String? get storeId => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  /// Serializes this EstimateLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EstimateLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimateLineCopyWith<EstimateLine> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimateLineCopyWith<$Res> {
  factory $EstimateLineCopyWith(
    EstimateLine value,
    $Res Function(EstimateLine) then,
  ) = _$EstimateLineCopyWithImpl<$Res, EstimateLine>;
  @useResult
  $Res call({
    String label,
    String formula,
    double quantity,
    String unit,
    @JsonKey(name: 'unit_price') int unitPrice,
    @JsonKey(name: 'total_uzs') int totalUzs,
    @JsonKey(name: 'is_approximate') bool isApproximate,
    @JsonKey(name: 'store_id') String? storeId,
    String category,
  });
}

/// @nodoc
class _$EstimateLineCopyWithImpl<$Res, $Val extends EstimateLine>
    implements $EstimateLineCopyWith<$Res> {
  _$EstimateLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimateLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? formula = null,
    Object? quantity = null,
    Object? unit = null,
    Object? unitPrice = null,
    Object? totalUzs = null,
    Object? isApproximate = null,
    Object? storeId = freezed,
    Object? category = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            formula: null == formula
                ? _value.formula
                : formula // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as double,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as String,
            unitPrice: null == unitPrice
                ? _value.unitPrice
                : unitPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            totalUzs: null == totalUzs
                ? _value.totalUzs
                : totalUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            isApproximate: null == isApproximate
                ? _value.isApproximate
                : isApproximate // ignore: cast_nullable_to_non_nullable
                      as bool,
            storeId: freezed == storeId
                ? _value.storeId
                : storeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EstimateLineImplCopyWith<$Res>
    implements $EstimateLineCopyWith<$Res> {
  factory _$$EstimateLineImplCopyWith(
    _$EstimateLineImpl value,
    $Res Function(_$EstimateLineImpl) then,
  ) = __$$EstimateLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String label,
    String formula,
    double quantity,
    String unit,
    @JsonKey(name: 'unit_price') int unitPrice,
    @JsonKey(name: 'total_uzs') int totalUzs,
    @JsonKey(name: 'is_approximate') bool isApproximate,
    @JsonKey(name: 'store_id') String? storeId,
    String category,
  });
}

/// @nodoc
class __$$EstimateLineImplCopyWithImpl<$Res>
    extends _$EstimateLineCopyWithImpl<$Res, _$EstimateLineImpl>
    implements _$$EstimateLineImplCopyWith<$Res> {
  __$$EstimateLineImplCopyWithImpl(
    _$EstimateLineImpl _value,
    $Res Function(_$EstimateLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EstimateLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? formula = null,
    Object? quantity = null,
    Object? unit = null,
    Object? unitPrice = null,
    Object? totalUzs = null,
    Object? isApproximate = null,
    Object? storeId = freezed,
    Object? category = null,
  }) {
    return _then(
      _$EstimateLineImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        formula: null == formula
            ? _value.formula
            : formula // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as double,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as String,
        unitPrice: null == unitPrice
            ? _value.unitPrice
            : unitPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        totalUzs: null == totalUzs
            ? _value.totalUzs
            : totalUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        isApproximate: null == isApproximate
            ? _value.isApproximate
            : isApproximate // ignore: cast_nullable_to_non_nullable
                  as bool,
        storeId: freezed == storeId
            ? _value.storeId
            : storeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimateLineImpl implements _EstimateLine {
  const _$EstimateLineImpl({
    required this.label,
    required this.formula,
    required this.quantity,
    required this.unit,
    @JsonKey(name: 'unit_price') required this.unitPrice,
    @JsonKey(name: 'total_uzs') required this.totalUzs,
    @JsonKey(name: 'is_approximate') this.isApproximate = false,
    @JsonKey(name: 'store_id') this.storeId,
    this.category = '',
  });

  factory _$EstimateLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimateLineImplFromJson(json);

  @override
  final String label;
  @override
  final String formula;
  @override
  final double quantity;
  @override
  final String unit;
  @override
  @JsonKey(name: 'unit_price')
  final int unitPrice;
  @override
  @JsonKey(name: 'total_uzs')
  final int totalUzs;
  @override
  @JsonKey(name: 'is_approximate')
  final bool isApproximate;
  @override
  @JsonKey(name: 'store_id')
  final String? storeId;
  @override
  @JsonKey()
  final String category;

  @override
  String toString() {
    return 'EstimateLine(label: $label, formula: $formula, quantity: $quantity, unit: $unit, unitPrice: $unitPrice, totalUzs: $totalUzs, isApproximate: $isApproximate, storeId: $storeId, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimateLineImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.formula, formula) || other.formula == formula) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.totalUzs, totalUzs) ||
                other.totalUzs == totalUzs) &&
            (identical(other.isApproximate, isApproximate) ||
                other.isApproximate == isApproximate) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    label,
    formula,
    quantity,
    unit,
    unitPrice,
    totalUzs,
    isApproximate,
    storeId,
    category,
  );

  /// Create a copy of EstimateLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimateLineImplCopyWith<_$EstimateLineImpl> get copyWith =>
      __$$EstimateLineImplCopyWithImpl<_$EstimateLineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimateLineImplToJson(this);
  }
}

abstract class _EstimateLine implements EstimateLine {
  const factory _EstimateLine({
    required final String label,
    required final String formula,
    required final double quantity,
    required final String unit,
    @JsonKey(name: 'unit_price') required final int unitPrice,
    @JsonKey(name: 'total_uzs') required final int totalUzs,
    @JsonKey(name: 'is_approximate') final bool isApproximate,
    @JsonKey(name: 'store_id') final String? storeId,
    final String category,
  }) = _$EstimateLineImpl;

  factory _EstimateLine.fromJson(Map<String, dynamic> json) =
      _$EstimateLineImpl.fromJson;

  @override
  String get label;
  @override
  String get formula;
  @override
  double get quantity;
  @override
  String get unit;
  @override
  @JsonKey(name: 'unit_price')
  int get unitPrice;
  @override
  @JsonKey(name: 'total_uzs')
  int get totalUzs;
  @override
  @JsonKey(name: 'is_approximate')
  bool get isApproximate;
  @override
  @JsonKey(name: 'store_id')
  String? get storeId;
  @override
  String get category;

  /// Create a copy of EstimateLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimateLineImplCopyWith<_$EstimateLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Estimate _$EstimateFromJson(Map<String, dynamic> json) {
  return _Estimate.fromJson(json);
}

/// @nodoc
mixin _$Estimate {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  List<EstimateLine> get lines => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_uzs')
  int get totalUzs => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_min')
  int get totalMin => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_max')
  int get totalMax => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_electrical')
  bool get hasElectrical => throw _privateConstructorUsedError;

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
    @JsonKey(name: 'room_id') String roomId,
    List<EstimateLine> lines,
    @JsonKey(name: 'total_uzs') int totalUzs,
    @JsonKey(name: 'total_min') int totalMin,
    @JsonKey(name: 'total_max') int totalMax,
    String currency,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'has_electrical') bool hasElectrical,
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
    Object? lines = null,
    Object? totalUzs = null,
    Object? totalMin = null,
    Object? totalMax = null,
    Object? currency = null,
    Object? status = null,
    Object? createdAt = null,
    Object? hasElectrical = null,
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
            lines: null == lines
                ? _value.lines
                : lines // ignore: cast_nullable_to_non_nullable
                      as List<EstimateLine>,
            totalUzs: null == totalUzs
                ? _value.totalUzs
                : totalUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMin: null == totalMin
                ? _value.totalMin
                : totalMin // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMax: null == totalMax
                ? _value.totalMax
                : totalMax // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            hasElectrical: null == hasElectrical
                ? _value.hasElectrical
                : hasElectrical // ignore: cast_nullable_to_non_nullable
                      as bool,
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
    @JsonKey(name: 'room_id') String roomId,
    List<EstimateLine> lines,
    @JsonKey(name: 'total_uzs') int totalUzs,
    @JsonKey(name: 'total_min') int totalMin,
    @JsonKey(name: 'total_max') int totalMax,
    String currency,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'has_electrical') bool hasElectrical,
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
    Object? lines = null,
    Object? totalUzs = null,
    Object? totalMin = null,
    Object? totalMax = null,
    Object? currency = null,
    Object? status = null,
    Object? createdAt = null,
    Object? hasElectrical = null,
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
        lines: null == lines
            ? _value._lines
            : lines // ignore: cast_nullable_to_non_nullable
                  as List<EstimateLine>,
        totalUzs: null == totalUzs
            ? _value.totalUzs
            : totalUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMin: null == totalMin
            ? _value.totalMin
            : totalMin // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMax: null == totalMax
            ? _value.totalMax
            : totalMax // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        hasElectrical: null == hasElectrical
            ? _value.hasElectrical
            : hasElectrical // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimateImpl implements _Estimate {
  const _$EstimateImpl({
    required this.id,
    @JsonKey(name: 'room_id') required this.roomId,
    final List<EstimateLine> lines = const <EstimateLine>[],
    @JsonKey(name: 'total_uzs') required this.totalUzs,
    @JsonKey(name: 'total_min') required this.totalMin,
    @JsonKey(name: 'total_max') required this.totalMax,
    this.currency = 'UZS',
    this.status = 'final',
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'has_electrical') this.hasElectrical = false,
  }) : _lines = lines;

  factory _$EstimateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimateImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  final List<EstimateLine> _lines;
  @override
  @JsonKey()
  List<EstimateLine> get lines {
    if (_lines is EqualUnmodifiableListView) return _lines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lines);
  }

  @override
  @JsonKey(name: 'total_uzs')
  final int totalUzs;
  @override
  @JsonKey(name: 'total_min')
  final int totalMin;
  @override
  @JsonKey(name: 'total_max')
  final int totalMax;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'has_electrical')
  final bool hasElectrical;

  @override
  String toString() {
    return 'Estimate(id: $id, roomId: $roomId, lines: $lines, totalUzs: $totalUzs, totalMin: $totalMin, totalMax: $totalMax, currency: $currency, status: $status, createdAt: $createdAt, hasElectrical: $hasElectrical)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            const DeepCollectionEquality().equals(other._lines, _lines) &&
            (identical(other.totalUzs, totalUzs) ||
                other.totalUzs == totalUzs) &&
            (identical(other.totalMin, totalMin) ||
                other.totalMin == totalMin) &&
            (identical(other.totalMax, totalMax) ||
                other.totalMax == totalMax) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.hasElectrical, hasElectrical) ||
                other.hasElectrical == hasElectrical));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    const DeepCollectionEquality().hash(_lines),
    totalUzs,
    totalMin,
    totalMax,
    currency,
    status,
    createdAt,
    hasElectrical,
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
    @JsonKey(name: 'room_id') required final String roomId,
    final List<EstimateLine> lines,
    @JsonKey(name: 'total_uzs') required final int totalUzs,
    @JsonKey(name: 'total_min') required final int totalMin,
    @JsonKey(name: 'total_max') required final int totalMax,
    final String currency,
    final String status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'has_electrical') final bool hasElectrical,
  }) = _$EstimateImpl;

  factory _Estimate.fromJson(Map<String, dynamic> json) =
      _$EstimateImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  List<EstimateLine> get lines;
  @override
  @JsonKey(name: 'total_uzs')
  int get totalUzs;
  @override
  @JsonKey(name: 'total_min')
  int get totalMin;
  @override
  @JsonKey(name: 'total_max')
  int get totalMax;
  @override
  String get currency;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'has_electrical')
  bool get hasElectrical;

  /// Create a copy of Estimate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimateImplCopyWith<_$EstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EstimateSummary _$EstimateSummaryFromJson(Map<String, dynamic> json) {
  return _EstimateSummary.fromJson(json);
}

/// @nodoc
mixin _$EstimateSummary {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_uzs')
  int get totalUzs => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EstimateSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EstimateSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimateSummaryCopyWith<EstimateSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimateSummaryCopyWith<$Res> {
  factory $EstimateSummaryCopyWith(
    EstimateSummary value,
    $Res Function(EstimateSummary) then,
  ) = _$EstimateSummaryCopyWithImpl<$Res, EstimateSummary>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'total_uzs') int totalUzs,
    String currency,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$EstimateSummaryCopyWithImpl<$Res, $Val extends EstimateSummary>
    implements $EstimateSummaryCopyWith<$Res> {
  _$EstimateSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimateSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? totalUzs = null,
    Object? currency = null,
    Object? status = null,
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
            totalUzs: null == totalUzs
                ? _value.totalUzs
                : totalUzs // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
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
abstract class _$$EstimateSummaryImplCopyWith<$Res>
    implements $EstimateSummaryCopyWith<$Res> {
  factory _$$EstimateSummaryImplCopyWith(
    _$EstimateSummaryImpl value,
    $Res Function(_$EstimateSummaryImpl) then,
  ) = __$$EstimateSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'total_uzs') int totalUzs,
    String currency,
    String status,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$EstimateSummaryImplCopyWithImpl<$Res>
    extends _$EstimateSummaryCopyWithImpl<$Res, _$EstimateSummaryImpl>
    implements _$$EstimateSummaryImplCopyWith<$Res> {
  __$$EstimateSummaryImplCopyWithImpl(
    _$EstimateSummaryImpl _value,
    $Res Function(_$EstimateSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EstimateSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? totalUzs = null,
    Object? currency = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$EstimateSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        totalUzs: null == totalUzs
            ? _value.totalUzs
            : totalUzs // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
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
class _$EstimateSummaryImpl implements _EstimateSummary {
  const _$EstimateSummaryImpl({
    required this.id,
    @JsonKey(name: 'room_id') required this.roomId,
    @JsonKey(name: 'total_uzs') required this.totalUzs,
    required this.currency,
    required this.status,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$EstimateSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimateSummaryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  @override
  @JsonKey(name: 'total_uzs')
  final int totalUzs;
  @override
  final String currency;
  @override
  final String status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'EstimateSummary(id: $id, roomId: $roomId, totalUzs: $totalUzs, currency: $currency, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimateSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.totalUzs, totalUzs) ||
                other.totalUzs == totalUzs) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    totalUzs,
    currency,
    status,
    createdAt,
  );

  /// Create a copy of EstimateSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimateSummaryImplCopyWith<_$EstimateSummaryImpl> get copyWith =>
      __$$EstimateSummaryImplCopyWithImpl<_$EstimateSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimateSummaryImplToJson(this);
  }
}

abstract class _EstimateSummary implements EstimateSummary {
  const factory _EstimateSummary({
    required final String id,
    @JsonKey(name: 'room_id') required final String roomId,
    @JsonKey(name: 'total_uzs') required final int totalUzs,
    required final String currency,
    required final String status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$EstimateSummaryImpl;

  factory _EstimateSummary.fromJson(Map<String, dynamic> json) =
      _$EstimateSummaryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  @JsonKey(name: 'total_uzs')
  int get totalUzs;
  @override
  String get currency;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of EstimateSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimateSummaryImplCopyWith<_$EstimateSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginatedEstimates _$PaginatedEstimatesFromJson(Map<String, dynamic> json) {
  return _PaginatedEstimates.fromJson(json);
}

/// @nodoc
mixin _$PaginatedEstimates {
  List<EstimateSummary> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  /// Serializes this PaginatedEstimates to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedEstimates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedEstimatesCopyWith<PaginatedEstimates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedEstimatesCopyWith<$Res> {
  factory $PaginatedEstimatesCopyWith(
    PaginatedEstimates value,
    $Res Function(PaginatedEstimates) then,
  ) = _$PaginatedEstimatesCopyWithImpl<$Res, PaginatedEstimates>;
  @useResult
  $Res call({List<EstimateSummary> items, int total, int limit, int offset});
}

/// @nodoc
class _$PaginatedEstimatesCopyWithImpl<$Res, $Val extends PaginatedEstimates>
    implements $PaginatedEstimatesCopyWith<$Res> {
  _$PaginatedEstimatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedEstimates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<EstimateSummary>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedEstimatesImplCopyWith<$Res>
    implements $PaginatedEstimatesCopyWith<$Res> {
  factory _$$PaginatedEstimatesImplCopyWith(
    _$PaginatedEstimatesImpl value,
    $Res Function(_$PaginatedEstimatesImpl) then,
  ) = __$$PaginatedEstimatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<EstimateSummary> items, int total, int limit, int offset});
}

/// @nodoc
class __$$PaginatedEstimatesImplCopyWithImpl<$Res>
    extends _$PaginatedEstimatesCopyWithImpl<$Res, _$PaginatedEstimatesImpl>
    implements _$$PaginatedEstimatesImplCopyWith<$Res> {
  __$$PaginatedEstimatesImplCopyWithImpl(
    _$PaginatedEstimatesImpl _value,
    $Res Function(_$PaginatedEstimatesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedEstimates
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? total = null,
    Object? limit = null,
    Object? offset = null,
  }) {
    return _then(
      _$PaginatedEstimatesImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<EstimateSummary>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedEstimatesImpl implements _PaginatedEstimates {
  const _$PaginatedEstimatesImpl({
    final List<EstimateSummary> items = const <EstimateSummary>[],
    this.total = 0,
    this.limit = 20,
    this.offset = 0,
  }) : _items = items;

  factory _$PaginatedEstimatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedEstimatesImplFromJson(json);

  final List<EstimateSummary> _items;
  @override
  @JsonKey()
  List<EstimateSummary> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'PaginatedEstimates(items: $items, total: $total, limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedEstimatesImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    total,
    limit,
    offset,
  );

  /// Create a copy of PaginatedEstimates
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedEstimatesImplCopyWith<_$PaginatedEstimatesImpl> get copyWith =>
      __$$PaginatedEstimatesImplCopyWithImpl<_$PaginatedEstimatesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedEstimatesImplToJson(this);
  }
}

abstract class _PaginatedEstimates implements PaginatedEstimates {
  const factory _PaginatedEstimates({
    final List<EstimateSummary> items,
    final int total,
    final int limit,
    final int offset,
  }) = _$PaginatedEstimatesImpl;

  factory _PaginatedEstimates.fromJson(Map<String, dynamic> json) =
      _$PaginatedEstimatesImpl.fromJson;

  @override
  List<EstimateSummary> get items;
  @override
  int get total;
  @override
  int get limit;
  @override
  int get offset;

  /// Create a copy of PaginatedEstimates
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedEstimatesImplCopyWith<_$PaginatedEstimatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
