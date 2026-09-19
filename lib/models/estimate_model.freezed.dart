// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EstimateLineItem {

 String get id; String get description; double get quantity; double get unitPrice; double get lineTotal;
/// Create a copy of EstimateLineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimateLineItemCopyWith<EstimateLineItem> get copyWith => _$EstimateLineItemCopyWithImpl<EstimateLineItem>(this as EstimateLineItem, _$identity);

  /// Serializes this EstimateLineItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstimateLineItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimateLineItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice)&&(identical(other.lineTotal, _this.lineTotal) || other.lineTotal == _this.lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstimateLineItem;
  return Object.hash(runtimeType,_this.id,_this.description,_this.quantity,_this.unitPrice,_this.lineTotal);
}

@override
String toString() {
  final _this = this as EstimateLineItem;
  return 'EstimateLineItem(id: ${_this.id}, description: ${_this.description}, quantity: ${_this.quantity}, unitPrice: ${_this.unitPrice}, lineTotal: ${_this.lineTotal})';
}


}

/// @nodoc
abstract mixin class $EstimateLineItemCopyWith<$Res>  {
  factory $EstimateLineItemCopyWith(EstimateLineItem value, $Res Function(EstimateLineItem) _then) = _$EstimateLineItemCopyWithImpl;
@useResult
$Res call({
 String id, String description, double quantity, double unitPrice, double lineTotal
});




}
/// @nodoc
class _$EstimateLineItemCopyWithImpl<$Res>
    implements $EstimateLineItemCopyWith<$Res> {
  _$EstimateLineItemCopyWithImpl(this._self, this._then);

  final EstimateLineItem _self;
  final $Res Function(EstimateLineItem) _then;

/// Create a copy of EstimateLineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? lineTotal = null,}) {
  return _then(EstimateLineItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimateLineItem].
extension EstimateLineItemPatterns on EstimateLineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimateLineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimateLineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimateLineItem value)  $default,){
final _that = this;
switch (_that) {
case _EstimateLineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimateLineItem value)?  $default,){
final _that = this;
switch (_that) {
case _EstimateLineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  double quantity,  double unitPrice,  double lineTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimateLineItem() when $default != null:
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice,_that.lineTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  double quantity,  double unitPrice,  double lineTotal)  $default,) {final _that = this;
switch (_that) {
case _EstimateLineItem():
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice,_that.lineTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  double quantity,  double unitPrice,  double lineTotal)?  $default,) {final _that = this;
switch (_that) {
case _EstimateLineItem() when $default != null:
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice,_that.lineTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimateLineItem implements EstimateLineItem {
  const _EstimateLineItem({required this.id, required this.description, required this.quantity, required this.unitPrice, required this.lineTotal});
  factory _EstimateLineItem.fromJson(Map<String, dynamic> json) => _$EstimateLineItemFromJson(json);

@override final  String id;
@override final  String description;
@override final  double quantity;
@override final  double unitPrice;
@override final  double lineTotal;

/// Create a copy of EstimateLineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimateLineItemCopyWith<_EstimateLineItem> get copyWith => __$EstimateLineItemCopyWithImpl<_EstimateLineItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimateLineItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimateLineItem&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,description,quantity,unitPrice,lineTotal);
}

@override
String toString() {
    return 'EstimateLineItem(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice, lineTotal: $lineTotal)';
}


}

/// @nodoc
abstract mixin class _$EstimateLineItemCopyWith<$Res> implements $EstimateLineItemCopyWith<$Res> {
  factory _$EstimateLineItemCopyWith(_EstimateLineItem value, $Res Function(_EstimateLineItem) _then) = __$EstimateLineItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, double quantity, double unitPrice, double lineTotal
});




}
/// @nodoc
class __$EstimateLineItemCopyWithImpl<$Res>
    implements _$EstimateLineItemCopyWith<$Res> {
  __$EstimateLineItemCopyWithImpl(this._self, this._then);

  final _EstimateLineItem _self;
  final $Res Function(_EstimateLineItem) _then;

/// Create a copy of EstimateLineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? quantity = null,Object? unitPrice = null,Object? lineTotal = null,}) {
  return _then(_EstimateLineItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,lineTotal: null == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EstimateStage {

@JsonKey(unknownEnumValue: RenovationStage.unknown) RenovationStage get name; List<EstimateLineItem> get lineItems; double get subtotal; bool get isExcluded; double get counterfactualSubtotal;
/// Create a copy of EstimateStage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimateStageCopyWith<EstimateStage> get copyWith => _$EstimateStageCopyWithImpl<EstimateStage>(this as EstimateStage, _$identity);

  /// Serializes this EstimateStage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EstimateStage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimateStage&&(identical(other.name, _this.name) || other.name == _this.name)&&const DeepCollectionEquality().equals(other.lineItems, _this.lineItems)&&(identical(other.subtotal, _this.subtotal) || other.subtotal == _this.subtotal)&&(identical(other.isExcluded, _this.isExcluded) || other.isExcluded == _this.isExcluded)&&(identical(other.counterfactualSubtotal, _this.counterfactualSubtotal) || other.counterfactualSubtotal == _this.counterfactualSubtotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EstimateStage;
  return Object.hash(runtimeType,_this.name,const DeepCollectionEquality().hash(_this.lineItems),_this.subtotal,_this.isExcluded,_this.counterfactualSubtotal);
}

@override
String toString() {
  final _this = this as EstimateStage;
  return 'EstimateStage(name: ${_this.name}, lineItems: ${_this.lineItems}, subtotal: ${_this.subtotal}, isExcluded: ${_this.isExcluded}, counterfactualSubtotal: ${_this.counterfactualSubtotal})';
}


}

/// @nodoc
abstract mixin class $EstimateStageCopyWith<$Res>  {
  factory $EstimateStageCopyWith(EstimateStage value, $Res Function(EstimateStage) _then) = _$EstimateStageCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: RenovationStage.unknown) RenovationStage name, List<EstimateLineItem> lineItems, double subtotal, bool isExcluded, double counterfactualSubtotal
});




}
/// @nodoc
class _$EstimateStageCopyWithImpl<$Res>
    implements $EstimateStageCopyWith<$Res> {
  _$EstimateStageCopyWithImpl(this._self, this._then);

  final EstimateStage _self;
  final $Res Function(EstimateStage) _then;

/// Create a copy of EstimateStage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? lineItems = null,Object? subtotal = null,Object? isExcluded = null,Object? counterfactualSubtotal = null,}) {
  return _then(EstimateStage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as RenovationStage,lineItems: null == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<EstimateLineItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,isExcluded: null == isExcluded ? _self.isExcluded : isExcluded // ignore: cast_nullable_to_non_nullable
as bool,counterfactualSubtotal: null == counterfactualSubtotal ? _self.counterfactualSubtotal : counterfactualSubtotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimateStage].
extension EstimateStagePatterns on EstimateStage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimateStage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimateStage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimateStage value)  $default,){
final _that = this;
switch (_that) {
case _EstimateStage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimateStage value)?  $default,){
final _that = this;
switch (_that) {
case _EstimateStage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RenovationStage.unknown)  RenovationStage name,  List<EstimateLineItem> lineItems,  double subtotal,  bool isExcluded,  double counterfactualSubtotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimateStage() when $default != null:
return $default(_that.name,_that.lineItems,_that.subtotal,_that.isExcluded,_that.counterfactualSubtotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RenovationStage.unknown)  RenovationStage name,  List<EstimateLineItem> lineItems,  double subtotal,  bool isExcluded,  double counterfactualSubtotal)  $default,) {final _that = this;
switch (_that) {
case _EstimateStage():
return $default(_that.name,_that.lineItems,_that.subtotal,_that.isExcluded,_that.counterfactualSubtotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: RenovationStage.unknown)  RenovationStage name,  List<EstimateLineItem> lineItems,  double subtotal,  bool isExcluded,  double counterfactualSubtotal)?  $default,) {final _that = this;
switch (_that) {
case _EstimateStage() when $default != null:
return $default(_that.name,_that.lineItems,_that.subtotal,_that.isExcluded,_that.counterfactualSubtotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimateStage implements EstimateStage {
  const _EstimateStage({@JsonKey(unknownEnumValue: RenovationStage.unknown) required this.name,  List<EstimateLineItem> lineItems = const <EstimateLineItem>[], required this.subtotal, this.isExcluded = false, this.counterfactualSubtotal = 0}): _lineItems = lineItems;
  factory _EstimateStage.fromJson(Map<String, dynamic> json) => _$EstimateStageFromJson(json);

@override@JsonKey(unknownEnumValue: RenovationStage.unknown) final  RenovationStage name;
 final  List<EstimateLineItem> _lineItems;
@override@JsonKey() List<EstimateLineItem> get lineItems {
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineItems);
}

@override final  double subtotal;
@override@JsonKey() final  bool isExcluded;
@override@JsonKey() final  double counterfactualSubtotal;

/// Create a copy of EstimateStage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimateStageCopyWith<_EstimateStage> get copyWith => __$EstimateStageCopyWithImpl<_EstimateStage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimateStageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimateStage&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.lineItems, _lineItems)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.isExcluded, isExcluded) || other.isExcluded == isExcluded)&&(identical(other.counterfactualSubtotal, counterfactualSubtotal) || other.counterfactualSubtotal == counterfactualSubtotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_lineItems),subtotal,isExcluded,counterfactualSubtotal);
}

@override
String toString() {
    return 'EstimateStage(name: $name, lineItems: $lineItems, subtotal: $subtotal, isExcluded: $isExcluded, counterfactualSubtotal: $counterfactualSubtotal)';
}


}

/// @nodoc
abstract mixin class _$EstimateStageCopyWith<$Res> implements $EstimateStageCopyWith<$Res> {
  factory _$EstimateStageCopyWith(_EstimateStage value, $Res Function(_EstimateStage) _then) = __$EstimateStageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: RenovationStage.unknown) RenovationStage name, List<EstimateLineItem> lineItems, double subtotal, bool isExcluded, double counterfactualSubtotal
});




}
/// @nodoc
class __$EstimateStageCopyWithImpl<$Res>
    implements _$EstimateStageCopyWith<$Res> {
  __$EstimateStageCopyWithImpl(this._self, this._then);

  final _EstimateStage _self;
  final $Res Function(_EstimateStage) _then;

/// Create a copy of EstimateStage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? lineItems = null,Object? subtotal = null,Object? isExcluded = null,Object? counterfactualSubtotal = null,}) {
  return _then(_EstimateStage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as RenovationStage,lineItems: null == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<EstimateLineItem>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,isExcluded: null == isExcluded ? _self.isExcluded : isExcluded // ignore: cast_nullable_to_non_nullable
as bool,counterfactualSubtotal: null == counterfactualSubtotal ? _self.counterfactualSubtotal : counterfactualSubtotal // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Estimate {

 String get id; String get roomId; double get roomArea; List<EstimateStage> get stages; double get totalPrice; String get currency; DateTime get createdAt;
/// Create a copy of Estimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimateCopyWith<Estimate> get copyWith => _$EstimateCopyWithImpl<Estimate>(this as Estimate, _$identity);

  /// Serializes this Estimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Estimate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Estimate&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.roomArea, _this.roomArea) || other.roomArea == _this.roomArea)&&const DeepCollectionEquality().equals(other.stages, _this.stages)&&(identical(other.totalPrice, _this.totalPrice) || other.totalPrice == _this.totalPrice)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Estimate;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.roomArea,const DeepCollectionEquality().hash(_this.stages),_this.totalPrice,_this.currency,_this.createdAt);
}

@override
String toString() {
  final _this = this as Estimate;
  return 'Estimate(id: ${_this.id}, roomId: ${_this.roomId}, roomArea: ${_this.roomArea}, stages: ${_this.stages}, totalPrice: ${_this.totalPrice}, currency: ${_this.currency}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $EstimateCopyWith<$Res>  {
  factory $EstimateCopyWith(Estimate value, $Res Function(Estimate) _then) = _$EstimateCopyWithImpl;
@useResult
$Res call({
 String id, String roomId, double roomArea, List<EstimateStage> stages, double totalPrice, String currency, DateTime createdAt
});




}
/// @nodoc
class _$EstimateCopyWithImpl<$Res>
    implements $EstimateCopyWith<$Res> {
  _$EstimateCopyWithImpl(this._self, this._then);

  final Estimate _self;
  final $Res Function(Estimate) _then;

/// Create a copy of Estimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? roomArea = null,Object? stages = null,Object? totalPrice = null,Object? currency = null,Object? createdAt = null,}) {
  return _then(Estimate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,roomArea: null == roomArea ? _self.roomArea : roomArea // ignore: cast_nullable_to_non_nullable
as double,stages: null == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<EstimateStage>,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Estimate].
extension EstimatePatterns on Estimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Estimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Estimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Estimate value)  $default,){
final _that = this;
switch (_that) {
case _Estimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Estimate value)?  $default,){
final _that = this;
switch (_that) {
case _Estimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId,  double roomArea,  List<EstimateStage> stages,  double totalPrice,  String currency,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Estimate() when $default != null:
return $default(_that.id,_that.roomId,_that.roomArea,_that.stages,_that.totalPrice,_that.currency,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId,  double roomArea,  List<EstimateStage> stages,  double totalPrice,  String currency,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Estimate():
return $default(_that.id,_that.roomId,_that.roomArea,_that.stages,_that.totalPrice,_that.currency,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId,  double roomArea,  List<EstimateStage> stages,  double totalPrice,  String currency,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Estimate() when $default != null:
return $default(_that.id,_that.roomId,_that.roomArea,_that.stages,_that.totalPrice,_that.currency,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Estimate implements Estimate {
  const _Estimate({required this.id, required this.roomId, required this.roomArea,  List<EstimateStage> stages = const <EstimateStage>[], required this.totalPrice, required this.currency, required this.createdAt}): _stages = stages;
  factory _Estimate.fromJson(Map<String, dynamic> json) => _$EstimateFromJson(json);

@override final  String id;
@override final  String roomId;
@override final  double roomArea;
 final  List<EstimateStage> _stages;
@override@JsonKey() List<EstimateStage> get stages {
  if (_stages is EqualUnmodifiableListView) return _stages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stages);
}

@override final  double totalPrice;
@override final  String currency;
@override final  DateTime createdAt;

/// Create a copy of Estimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimateCopyWith<_Estimate> get copyWith => __$EstimateCopyWithImpl<_Estimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimateToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Estimate&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.roomArea, roomArea) || other.roomArea == roomArea)&&const DeepCollectionEquality().equals(other.stages, _stages)&&(identical(other.totalPrice, totalPrice) || other.totalPrice == totalPrice)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,roomArea,const DeepCollectionEquality().hash(_stages),totalPrice,currency,createdAt);
}

@override
String toString() {
    return 'Estimate(id: $id, roomId: $roomId, roomArea: $roomArea, stages: $stages, totalPrice: $totalPrice, currency: $currency, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EstimateCopyWith<$Res> implements $EstimateCopyWith<$Res> {
  factory _$EstimateCopyWith(_Estimate value, $Res Function(_Estimate) _then) = __$EstimateCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId, double roomArea, List<EstimateStage> stages, double totalPrice, String currency, DateTime createdAt
});




}
/// @nodoc
class __$EstimateCopyWithImpl<$Res>
    implements _$EstimateCopyWith<$Res> {
  __$EstimateCopyWithImpl(this._self, this._then);

  final _Estimate _self;
  final $Res Function(_Estimate) _then;

/// Create a copy of Estimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? roomArea = null,Object? stages = null,Object? totalPrice = null,Object? currency = null,Object? createdAt = null,}) {
  return _then(_Estimate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,roomArea: null == roomArea ? _self.roomArea : roomArea // ignore: cast_nullable_to_non_nullable
as double,stages: null == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<EstimateStage>,totalPrice: null == totalPrice ? _self.totalPrice : totalPrice // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
