// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderLineCreate {

@JsonKey(name: 'material_id') String? get materialId;@JsonKey(name: 'product_name') String get productName; String get unit;@JsonKey(name: 'unit_price_uzs') int get unitPriceUzs; num get quantity;
/// Create a copy of OrderLineCreate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderLineCreateCopyWith<OrderLineCreate> get copyWith => _$OrderLineCreateCopyWithImpl<OrderLineCreate>(this as OrderLineCreate, _$identity);

  /// Serializes this OrderLineCreate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderLineCreate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderLineCreate&&(identical(other.materialId, _this.materialId) || other.materialId == _this.materialId)&&(identical(other.productName, _this.productName) || other.productName == _this.productName)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.unitPriceUzs, _this.unitPriceUzs) || other.unitPriceUzs == _this.unitPriceUzs)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderLineCreate;
  return Object.hash(runtimeType,_this.materialId,_this.productName,_this.unit,_this.unitPriceUzs,_this.quantity);
}

@override
String toString() {
  final _this = this as OrderLineCreate;
  return 'OrderLineCreate(materialId: ${_this.materialId}, productName: ${_this.productName}, unit: ${_this.unit}, unitPriceUzs: ${_this.unitPriceUzs}, quantity: ${_this.quantity})';
}


}

/// @nodoc
abstract mixin class $OrderLineCreateCopyWith<$Res>  {
  factory $OrderLineCreateCopyWith(OrderLineCreate value, $Res Function(OrderLineCreate) _then) = _$OrderLineCreateCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId,@JsonKey(name: 'product_name') String productName, String unit,@JsonKey(name: 'unit_price_uzs') int unitPriceUzs, num quantity
});




}
/// @nodoc
class _$OrderLineCreateCopyWithImpl<$Res>
    implements $OrderLineCreateCopyWith<$Res> {
  _$OrderLineCreateCopyWithImpl(this._self, this._then);

  final OrderLineCreate _self;
  final $Res Function(OrderLineCreate) _then;

/// Create a copy of OrderLineCreate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialId = freezed,Object? productName = null,Object? unit = null,Object? unitPriceUzs = null,Object? quantity = null,}) {
  return _then(OrderLineCreate(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitPriceUzs: null == unitPriceUzs ? _self.unitPriceUzs : unitPriceUzs // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderLineCreate].
extension OrderLineCreatePatterns on OrderLineCreate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderLineCreate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderLineCreate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderLineCreate value)  $default,){
final _that = this;
switch (_that) {
case _OrderLineCreate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderLineCreate value)?  $default,){
final _that = this;
switch (_that) {
case _OrderLineCreate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId, @JsonKey(name: 'product_name')  String productName,  String unit, @JsonKey(name: 'unit_price_uzs')  int unitPriceUzs,  num quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderLineCreate() when $default != null:
return $default(_that.materialId,_that.productName,_that.unit,_that.unitPriceUzs,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'material_id')  String? materialId, @JsonKey(name: 'product_name')  String productName,  String unit, @JsonKey(name: 'unit_price_uzs')  int unitPriceUzs,  num quantity)  $default,) {final _that = this;
switch (_that) {
case _OrderLineCreate():
return $default(_that.materialId,_that.productName,_that.unit,_that.unitPriceUzs,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'material_id')  String? materialId, @JsonKey(name: 'product_name')  String productName,  String unit, @JsonKey(name: 'unit_price_uzs')  int unitPriceUzs,  num quantity)?  $default,) {final _that = this;
switch (_that) {
case _OrderLineCreate() when $default != null:
return $default(_that.materialId,_that.productName,_that.unit,_that.unitPriceUzs,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderLineCreate implements OrderLineCreate {
  const _OrderLineCreate({@JsonKey(name: 'material_id') this.materialId, @JsonKey(name: 'product_name') required this.productName, required this.unit, @JsonKey(name: 'unit_price_uzs') required this.unitPriceUzs, required this.quantity});
  factory _OrderLineCreate.fromJson(Map<String, dynamic> json) => _$OrderLineCreateFromJson(json);

@override@JsonKey(name: 'material_id') final  String? materialId;
@override@JsonKey(name: 'product_name') final  String productName;
@override final  String unit;
@override@JsonKey(name: 'unit_price_uzs') final  int unitPriceUzs;
@override final  num quantity;

/// Create a copy of OrderLineCreate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderLineCreateCopyWith<_OrderLineCreate> get copyWith => __$OrderLineCreateCopyWithImpl<_OrderLineCreate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderLineCreateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderLineCreate&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.unitPriceUzs, unitPriceUzs) || other.unitPriceUzs == unitPriceUzs)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,materialId,productName,unit,unitPriceUzs,quantity);
}

@override
String toString() {
    return 'OrderLineCreate(materialId: $materialId, productName: $productName, unit: $unit, unitPriceUzs: $unitPriceUzs, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$OrderLineCreateCopyWith<$Res> implements $OrderLineCreateCopyWith<$Res> {
  factory _$OrderLineCreateCopyWith(_OrderLineCreate value, $Res Function(_OrderLineCreate) _then) = __$OrderLineCreateCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'material_id') String? materialId,@JsonKey(name: 'product_name') String productName, String unit,@JsonKey(name: 'unit_price_uzs') int unitPriceUzs, num quantity
});




}
/// @nodoc
class __$OrderLineCreateCopyWithImpl<$Res>
    implements _$OrderLineCreateCopyWith<$Res> {
  __$OrderLineCreateCopyWithImpl(this._self, this._then);

  final _OrderLineCreate _self;
  final $Res Function(_OrderLineCreate) _then;

/// Create a copy of OrderLineCreate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialId = freezed,Object? productName = null,Object? unit = null,Object? unitPriceUzs = null,Object? quantity = null,}) {
  return _then(_OrderLineCreate(
materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitPriceUzs: null == unitPriceUzs ? _self.unitPriceUzs : unitPriceUzs // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$ServerOrderLine {

 String get id;@JsonKey(name: 'material_id') String? get materialId;@JsonKey(name: 'product_name') String get productName; String get unit;@JsonKey(name: 'unit_price_uzs') int get unitPriceUzs; num get quantity;
/// Create a copy of ServerOrderLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerOrderLineCopyWith<ServerOrderLine> get copyWith => _$ServerOrderLineCopyWithImpl<ServerOrderLine>(this as ServerOrderLine, _$identity);

  /// Serializes this ServerOrderLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServerOrderLine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerOrderLine&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.materialId, _this.materialId) || other.materialId == _this.materialId)&&(identical(other.productName, _this.productName) || other.productName == _this.productName)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.unitPriceUzs, _this.unitPriceUzs) || other.unitPriceUzs == _this.unitPriceUzs)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServerOrderLine;
  return Object.hash(runtimeType,_this.id,_this.materialId,_this.productName,_this.unit,_this.unitPriceUzs,_this.quantity);
}

@override
String toString() {
  final _this = this as ServerOrderLine;
  return 'ServerOrderLine(id: ${_this.id}, materialId: ${_this.materialId}, productName: ${_this.productName}, unit: ${_this.unit}, unitPriceUzs: ${_this.unitPriceUzs}, quantity: ${_this.quantity})';
}


}

/// @nodoc
abstract mixin class $ServerOrderLineCopyWith<$Res>  {
  factory $ServerOrderLineCopyWith(ServerOrderLine value, $Res Function(ServerOrderLine) _then) = _$ServerOrderLineCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'material_id') String? materialId,@JsonKey(name: 'product_name') String productName, String unit,@JsonKey(name: 'unit_price_uzs') int unitPriceUzs, num quantity
});




}
/// @nodoc
class _$ServerOrderLineCopyWithImpl<$Res>
    implements $ServerOrderLineCopyWith<$Res> {
  _$ServerOrderLineCopyWithImpl(this._self, this._then);

  final ServerOrderLine _self;
  final $Res Function(ServerOrderLine) _then;

/// Create a copy of ServerOrderLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? materialId = freezed,Object? productName = null,Object? unit = null,Object? unitPriceUzs = null,Object? quantity = null,}) {
  return _then(ServerOrderLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitPriceUzs: null == unitPriceUzs ? _self.unitPriceUzs : unitPriceUzs // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerOrderLine].
extension ServerOrderLinePatterns on ServerOrderLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerOrderLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerOrderLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerOrderLine value)  $default,){
final _that = this;
switch (_that) {
case _ServerOrderLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerOrderLine value)?  $default,){
final _that = this;
switch (_that) {
case _ServerOrderLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'material_id')  String? materialId, @JsonKey(name: 'product_name')  String productName,  String unit, @JsonKey(name: 'unit_price_uzs')  int unitPriceUzs,  num quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerOrderLine() when $default != null:
return $default(_that.id,_that.materialId,_that.productName,_that.unit,_that.unitPriceUzs,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'material_id')  String? materialId, @JsonKey(name: 'product_name')  String productName,  String unit, @JsonKey(name: 'unit_price_uzs')  int unitPriceUzs,  num quantity)  $default,) {final _that = this;
switch (_that) {
case _ServerOrderLine():
return $default(_that.id,_that.materialId,_that.productName,_that.unit,_that.unitPriceUzs,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'material_id')  String? materialId, @JsonKey(name: 'product_name')  String productName,  String unit, @JsonKey(name: 'unit_price_uzs')  int unitPriceUzs,  num quantity)?  $default,) {final _that = this;
switch (_that) {
case _ServerOrderLine() when $default != null:
return $default(_that.id,_that.materialId,_that.productName,_that.unit,_that.unitPriceUzs,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerOrderLine implements ServerOrderLine {
  const _ServerOrderLine({required this.id, @JsonKey(name: 'material_id') this.materialId, @JsonKey(name: 'product_name') required this.productName, required this.unit, @JsonKey(name: 'unit_price_uzs') required this.unitPriceUzs, required this.quantity});
  factory _ServerOrderLine.fromJson(Map<String, dynamic> json) => _$ServerOrderLineFromJson(json);

@override final  String id;
@override@JsonKey(name: 'material_id') final  String? materialId;
@override@JsonKey(name: 'product_name') final  String productName;
@override final  String unit;
@override@JsonKey(name: 'unit_price_uzs') final  int unitPriceUzs;
@override final  num quantity;

/// Create a copy of ServerOrderLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerOrderLineCopyWith<_ServerOrderLine> get copyWith => __$ServerOrderLineCopyWithImpl<_ServerOrderLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerOrderLineToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerOrderLine&&(identical(other.id, id) || other.id == id)&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.unitPriceUzs, unitPriceUzs) || other.unitPriceUzs == unitPriceUzs)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,materialId,productName,unit,unitPriceUzs,quantity);
}

@override
String toString() {
    return 'ServerOrderLine(id: $id, materialId: $materialId, productName: $productName, unit: $unit, unitPriceUzs: $unitPriceUzs, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$ServerOrderLineCopyWith<$Res> implements $ServerOrderLineCopyWith<$Res> {
  factory _$ServerOrderLineCopyWith(_ServerOrderLine value, $Res Function(_ServerOrderLine) _then) = __$ServerOrderLineCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'material_id') String? materialId,@JsonKey(name: 'product_name') String productName, String unit,@JsonKey(name: 'unit_price_uzs') int unitPriceUzs, num quantity
});




}
/// @nodoc
class __$ServerOrderLineCopyWithImpl<$Res>
    implements _$ServerOrderLineCopyWith<$Res> {
  __$ServerOrderLineCopyWithImpl(this._self, this._then);

  final _ServerOrderLine _self;
  final $Res Function(_ServerOrderLine) _then;

/// Create a copy of ServerOrderLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? materialId = freezed,Object? productName = null,Object? unit = null,Object? unitPriceUzs = null,Object? quantity = null,}) {
  return _then(_ServerOrderLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,materialId: freezed == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String?,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitPriceUzs: null == unitPriceUzs ? _self.unitPriceUzs : unitPriceUzs // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$ServerOrder {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'dealer_name') String get dealerName;@JsonKey(name: 'total_uzs') int get totalUzs;@JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus get status;@JsonKey(name: 'created_at') DateTime get createdAt; List<ServerOrderLine> get lines;
/// Create a copy of ServerOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerOrderCopyWith<ServerOrder> get copyWith => _$ServerOrderCopyWithImpl<ServerOrder>(this as ServerOrder, _$identity);

  /// Serializes this ServerOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServerOrder;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerOrder&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.dealerName, _this.dealerName) || other.dealerName == _this.dealerName)&&(identical(other.totalUzs, _this.totalUzs) || other.totalUzs == _this.totalUzs)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&const DeepCollectionEquality().equals(other.lines, _this.lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServerOrder;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.dealerName,_this.totalUzs,_this.status,_this.createdAt,const DeepCollectionEquality().hash(_this.lines));
}

@override
String toString() {
  final _this = this as ServerOrder;
  return 'ServerOrder(id: ${_this.id}, userId: ${_this.userId}, dealerName: ${_this.dealerName}, totalUzs: ${_this.totalUzs}, status: ${_this.status}, createdAt: ${_this.createdAt}, lines: ${_this.lines})';
}


}

/// @nodoc
abstract mixin class $ServerOrderCopyWith<$Res>  {
  factory $ServerOrderCopyWith(ServerOrder value, $Res Function(ServerOrder) _then) = _$ServerOrderCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'dealer_name') String dealerName,@JsonKey(name: 'total_uzs') int totalUzs,@JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus status,@JsonKey(name: 'created_at') DateTime createdAt, List<ServerOrderLine> lines
});




}
/// @nodoc
class _$ServerOrderCopyWithImpl<$Res>
    implements $ServerOrderCopyWith<$Res> {
  _$ServerOrderCopyWithImpl(this._self, this._then);

  final ServerOrder _self;
  final $Res Function(ServerOrder) _then;

/// Create a copy of ServerOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? dealerName = null,Object? totalUzs = null,Object? status = null,Object? createdAt = null,Object? lines = null,}) {
  return _then(ServerOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,dealerName: null == dealerName ? _self.dealerName : dealerName // ignore: cast_nullable_to_non_nullable
as String,totalUzs: null == totalUzs ? _self.totalUzs : totalUzs // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<ServerOrderLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerOrder].
extension ServerOrderPatterns on ServerOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerOrder value)  $default,){
final _that = this;
switch (_that) {
case _ServerOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerOrder value)?  $default,){
final _that = this;
switch (_that) {
case _ServerOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'dealer_name')  String dealerName, @JsonKey(name: 'total_uzs')  int totalUzs, @JsonKey(unknownEnumValue: OrderStatus.unknown)  OrderStatus status, @JsonKey(name: 'created_at')  DateTime createdAt,  List<ServerOrderLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerOrder() when $default != null:
return $default(_that.id,_that.userId,_that.dealerName,_that.totalUzs,_that.status,_that.createdAt,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'dealer_name')  String dealerName, @JsonKey(name: 'total_uzs')  int totalUzs, @JsonKey(unknownEnumValue: OrderStatus.unknown)  OrderStatus status, @JsonKey(name: 'created_at')  DateTime createdAt,  List<ServerOrderLine> lines)  $default,) {final _that = this;
switch (_that) {
case _ServerOrder():
return $default(_that.id,_that.userId,_that.dealerName,_that.totalUzs,_that.status,_that.createdAt,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'dealer_name')  String dealerName, @JsonKey(name: 'total_uzs')  int totalUzs, @JsonKey(unknownEnumValue: OrderStatus.unknown)  OrderStatus status, @JsonKey(name: 'created_at')  DateTime createdAt,  List<ServerOrderLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _ServerOrder() when $default != null:
return $default(_that.id,_that.userId,_that.dealerName,_that.totalUzs,_that.status,_that.createdAt,_that.lines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerOrder implements ServerOrder {
  const _ServerOrder({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'dealer_name') required this.dealerName, @JsonKey(name: 'total_uzs') required this.totalUzs, @JsonKey(unknownEnumValue: OrderStatus.unknown) required this.status, @JsonKey(name: 'created_at') required this.createdAt,  List<ServerOrderLine> lines = const <ServerOrderLine>[]}): _lines = lines;
  factory _ServerOrder.fromJson(Map<String, dynamic> json) => _$ServerOrderFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'dealer_name') final  String dealerName;
@override@JsonKey(name: 'total_uzs') final  int totalUzs;
@override@JsonKey(unknownEnumValue: OrderStatus.unknown) final  OrderStatus status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
 final  List<ServerOrderLine> _lines;
@override@JsonKey() List<ServerOrderLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of ServerOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerOrderCopyWith<_ServerOrder> get copyWith => __$ServerOrderCopyWithImpl<_ServerOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerOrderToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.dealerName, dealerName) || other.dealerName == dealerName)&&(identical(other.totalUzs, totalUzs) || other.totalUzs == totalUzs)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,dealerName,totalUzs,status,createdAt,const DeepCollectionEquality().hash(_lines));
}

@override
String toString() {
    return 'ServerOrder(id: $id, userId: $userId, dealerName: $dealerName, totalUzs: $totalUzs, status: $status, createdAt: $createdAt, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$ServerOrderCopyWith<$Res> implements $ServerOrderCopyWith<$Res> {
  factory _$ServerOrderCopyWith(_ServerOrder value, $Res Function(_ServerOrder) _then) = __$ServerOrderCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'dealer_name') String dealerName,@JsonKey(name: 'total_uzs') int totalUzs,@JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus status,@JsonKey(name: 'created_at') DateTime createdAt, List<ServerOrderLine> lines
});




}
/// @nodoc
class __$ServerOrderCopyWithImpl<$Res>
    implements _$ServerOrderCopyWith<$Res> {
  __$ServerOrderCopyWithImpl(this._self, this._then);

  final _ServerOrder _self;
  final $Res Function(_ServerOrder) _then;

/// Create a copy of ServerOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? dealerName = null,Object? totalUzs = null,Object? status = null,Object? createdAt = null,Object? lines = null,}) {
  return _then(_ServerOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,dealerName: null == dealerName ? _self.dealerName : dealerName // ignore: cast_nullable_to_non_nullable
as String,totalUzs: null == totalUzs ? _self.totalUzs : totalUzs // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<ServerOrderLine>,
  ));
}


}

// dart format on
