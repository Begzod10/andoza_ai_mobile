// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'design_selection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomCondition {

@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition get wall;@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition? get floor;@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition? get ceiling;
/// Create a copy of RoomCondition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomConditionCopyWith<RoomCondition> get copyWith => _$RoomConditionCopyWithImpl<RoomCondition>(this as RoomCondition, _$identity);

  /// Serializes this RoomCondition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomCondition;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomCondition&&(identical(other.wall, _this.wall) || other.wall == _this.wall)&&(identical(other.floor, _this.floor) || other.floor == _this.floor)&&(identical(other.ceiling, _this.ceiling) || other.ceiling == _this.ceiling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomCondition;
  return Object.hash(runtimeType,_this.wall,_this.floor,_this.ceiling);
}

@override
String toString() {
  final _this = this as RoomCondition;
  return 'RoomCondition(wall: ${_this.wall}, floor: ${_this.floor}, ceiling: ${_this.ceiling})';
}


}

/// @nodoc
abstract mixin class $RoomConditionCopyWith<$Res>  {
  factory $RoomConditionCopyWith(RoomCondition value, $Res Function(RoomCondition) _then) = _$RoomConditionCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition wall,@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition? floor,@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition? ceiling
});




}
/// @nodoc
class _$RoomConditionCopyWithImpl<$Res>
    implements $RoomConditionCopyWith<$Res> {
  _$RoomConditionCopyWithImpl(this._self, this._then);

  final RoomCondition _self;
  final $Res Function(RoomCondition) _then;

/// Create a copy of RoomCondition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wall = null,Object? floor = freezed,Object? ceiling = freezed,}) {
  return _then(RoomCondition(
wall: null == wall ? _self.wall : wall // ignore: cast_nullable_to_non_nullable
as SurfaceCondition,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as SurfaceCondition?,ceiling: freezed == ceiling ? _self.ceiling : ceiling // ignore: cast_nullable_to_non_nullable
as SurfaceCondition?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomCondition].
extension RoomConditionPatterns on RoomCondition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomCondition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomCondition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomCondition value)  $default,){
final _that = this;
switch (_that) {
case _RoomCondition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomCondition value)?  $default,){
final _that = this;
switch (_that) {
case _RoomCondition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition wall, @JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition? floor, @JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition? ceiling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomCondition() when $default != null:
return $default(_that.wall,_that.floor,_that.ceiling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition wall, @JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition? floor, @JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition? ceiling)  $default,) {final _that = this;
switch (_that) {
case _RoomCondition():
return $default(_that.wall,_that.floor,_that.ceiling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition wall, @JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition? floor, @JsonKey(unknownEnumValue: SurfaceCondition.unknown)  SurfaceCondition? ceiling)?  $default,) {final _that = this;
switch (_that) {
case _RoomCondition() when $default != null:
return $default(_that.wall,_that.floor,_that.ceiling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomCondition implements RoomCondition {
  const _RoomCondition({@JsonKey(unknownEnumValue: SurfaceCondition.unknown) required this.wall, @JsonKey(unknownEnumValue: SurfaceCondition.unknown) this.floor, @JsonKey(unknownEnumValue: SurfaceCondition.unknown) this.ceiling});
  factory _RoomCondition.fromJson(Map<String, dynamic> json) => _$RoomConditionFromJson(json);

@override@JsonKey(unknownEnumValue: SurfaceCondition.unknown) final  SurfaceCondition wall;
@override@JsonKey(unknownEnumValue: SurfaceCondition.unknown) final  SurfaceCondition? floor;
@override@JsonKey(unknownEnumValue: SurfaceCondition.unknown) final  SurfaceCondition? ceiling;

/// Create a copy of RoomCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomConditionCopyWith<_RoomCondition> get copyWith => __$RoomConditionCopyWithImpl<_RoomCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomConditionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomCondition&&(identical(other.wall, wall) || other.wall == wall)&&(identical(other.floor, floor) || other.floor == floor)&&(identical(other.ceiling, ceiling) || other.ceiling == ceiling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,wall,floor,ceiling);
}

@override
String toString() {
    return 'RoomCondition(wall: $wall, floor: $floor, ceiling: $ceiling)';
}


}

/// @nodoc
abstract mixin class _$RoomConditionCopyWith<$Res> implements $RoomConditionCopyWith<$Res> {
  factory _$RoomConditionCopyWith(_RoomCondition value, $Res Function(_RoomCondition) _then) = __$RoomConditionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition wall,@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition? floor,@JsonKey(unknownEnumValue: SurfaceCondition.unknown) SurfaceCondition? ceiling
});




}
/// @nodoc
class __$RoomConditionCopyWithImpl<$Res>
    implements _$RoomConditionCopyWith<$Res> {
  __$RoomConditionCopyWithImpl(this._self, this._then);

  final _RoomCondition _self;
  final $Res Function(_RoomCondition) _then;

/// Create a copy of RoomCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wall = null,Object? floor = freezed,Object? ceiling = freezed,}) {
  return _then(_RoomCondition(
wall: null == wall ? _self.wall : wall // ignore: cast_nullable_to_non_nullable
as SurfaceCondition,floor: freezed == floor ? _self.floor : floor // ignore: cast_nullable_to_non_nullable
as SurfaceCondition?,ceiling: freezed == ceiling ? _self.ceiling : ceiling // ignore: cast_nullable_to_non_nullable
as SurfaceCondition?,
  ));
}


}


/// @nodoc
mixin _$FurniturePlacement {

 String get id; String get itemId; String get name;@OffsetConverter() Offset get position; double get rotationDegrees; String get selectedColor;
/// Create a copy of FurniturePlacement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FurniturePlacementCopyWith<FurniturePlacement> get copyWith => _$FurniturePlacementCopyWithImpl<FurniturePlacement>(this as FurniturePlacement, _$identity);

  /// Serializes this FurniturePlacement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FurniturePlacement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FurniturePlacement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.itemId, _this.itemId) || other.itemId == _this.itemId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.rotationDegrees, _this.rotationDegrees) || other.rotationDegrees == _this.rotationDegrees)&&(identical(other.selectedColor, _this.selectedColor) || other.selectedColor == _this.selectedColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FurniturePlacement;
  return Object.hash(runtimeType,_this.id,_this.itemId,_this.name,_this.position,_this.rotationDegrees,_this.selectedColor);
}

@override
String toString() {
  final _this = this as FurniturePlacement;
  return 'FurniturePlacement(id: ${_this.id}, itemId: ${_this.itemId}, name: ${_this.name}, position: ${_this.position}, rotationDegrees: ${_this.rotationDegrees}, selectedColor: ${_this.selectedColor})';
}


}

/// @nodoc
abstract mixin class $FurniturePlacementCopyWith<$Res>  {
  factory $FurniturePlacementCopyWith(FurniturePlacement value, $Res Function(FurniturePlacement) _then) = _$FurniturePlacementCopyWithImpl;
@useResult
$Res call({
 String id, String itemId, String name,@OffsetConverter() Offset position, double rotationDegrees, String selectedColor
});




}
/// @nodoc
class _$FurniturePlacementCopyWithImpl<$Res>
    implements $FurniturePlacementCopyWith<$Res> {
  _$FurniturePlacementCopyWithImpl(this._self, this._then);

  final FurniturePlacement _self;
  final $Res Function(FurniturePlacement) _then;

/// Create a copy of FurniturePlacement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemId = null,Object? name = null,Object? position = null,Object? rotationDegrees = null,Object? selectedColor = null,}) {
  return _then(FurniturePlacement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,rotationDegrees: null == rotationDegrees ? _self.rotationDegrees : rotationDegrees // ignore: cast_nullable_to_non_nullable
as double,selectedColor: null == selectedColor ? _self.selectedColor : selectedColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FurniturePlacement].
extension FurniturePlacementPatterns on FurniturePlacement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FurniturePlacement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FurniturePlacement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FurniturePlacement value)  $default,){
final _that = this;
switch (_that) {
case _FurniturePlacement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FurniturePlacement value)?  $default,){
final _that = this;
switch (_that) {
case _FurniturePlacement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String itemId,  String name, @OffsetConverter()  Offset position,  double rotationDegrees,  String selectedColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FurniturePlacement() when $default != null:
return $default(_that.id,_that.itemId,_that.name,_that.position,_that.rotationDegrees,_that.selectedColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String itemId,  String name, @OffsetConverter()  Offset position,  double rotationDegrees,  String selectedColor)  $default,) {final _that = this;
switch (_that) {
case _FurniturePlacement():
return $default(_that.id,_that.itemId,_that.name,_that.position,_that.rotationDegrees,_that.selectedColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String itemId,  String name, @OffsetConverter()  Offset position,  double rotationDegrees,  String selectedColor)?  $default,) {final _that = this;
switch (_that) {
case _FurniturePlacement() when $default != null:
return $default(_that.id,_that.itemId,_that.name,_that.position,_that.rotationDegrees,_that.selectedColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FurniturePlacement implements FurniturePlacement {
  const _FurniturePlacement({required this.id, required this.itemId, required this.name, @OffsetConverter() required this.position, this.rotationDegrees = 0, required this.selectedColor});
  factory _FurniturePlacement.fromJson(Map<String, dynamic> json) => _$FurniturePlacementFromJson(json);

@override final  String id;
@override final  String itemId;
@override final  String name;
@override@OffsetConverter() final  Offset position;
@override@JsonKey() final  double rotationDegrees;
@override final  String selectedColor;

/// Create a copy of FurniturePlacement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FurniturePlacementCopyWith<_FurniturePlacement> get copyWith => __$FurniturePlacementCopyWithImpl<_FurniturePlacement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FurniturePlacementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FurniturePlacement&&(identical(other.id, id) || other.id == id)&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.rotationDegrees, rotationDegrees) || other.rotationDegrees == rotationDegrees)&&(identical(other.selectedColor, selectedColor) || other.selectedColor == selectedColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,itemId,name,position,rotationDegrees,selectedColor);
}

@override
String toString() {
    return 'FurniturePlacement(id: $id, itemId: $itemId, name: $name, position: $position, rotationDegrees: $rotationDegrees, selectedColor: $selectedColor)';
}


}

/// @nodoc
abstract mixin class _$FurniturePlacementCopyWith<$Res> implements $FurniturePlacementCopyWith<$Res> {
  factory _$FurniturePlacementCopyWith(_FurniturePlacement value, $Res Function(_FurniturePlacement) _then) = __$FurniturePlacementCopyWithImpl;
@override @useResult
$Res call({
 String id, String itemId, String name,@OffsetConverter() Offset position, double rotationDegrees, String selectedColor
});




}
/// @nodoc
class __$FurniturePlacementCopyWithImpl<$Res>
    implements _$FurniturePlacementCopyWith<$Res> {
  __$FurniturePlacementCopyWithImpl(this._self, this._then);

  final _FurniturePlacement _self;
  final $Res Function(_FurniturePlacement) _then;

/// Create a copy of FurniturePlacement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemId = null,Object? name = null,Object? position = null,Object? rotationDegrees = null,Object? selectedColor = null,}) {
  return _then(_FurniturePlacement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,rotationDegrees: null == rotationDegrees ? _self.rotationDegrees : rotationDegrees // ignore: cast_nullable_to_non_nullable
as double,selectedColor: null == selectedColor ? _self.selectedColor : selectedColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MaterialSelection {

 String get materialId;@JsonKey(unknownEnumValue: MaterialType.unknown) MaterialType get material; String get color; double get price; double get area;
/// Create a copy of MaterialSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaterialSelectionCopyWith<MaterialSelection> get copyWith => _$MaterialSelectionCopyWithImpl<MaterialSelection>(this as MaterialSelection, _$identity);

  /// Serializes this MaterialSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MaterialSelection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaterialSelection&&(identical(other.materialId, _this.materialId) || other.materialId == _this.materialId)&&(identical(other.material, _this.material) || other.material == _this.material)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.area, _this.area) || other.area == _this.area));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MaterialSelection;
  return Object.hash(runtimeType,_this.materialId,_this.material,_this.color,_this.price,_this.area);
}

@override
String toString() {
  final _this = this as MaterialSelection;
  return 'MaterialSelection(materialId: ${_this.materialId}, material: ${_this.material}, color: ${_this.color}, price: ${_this.price}, area: ${_this.area})';
}


}

/// @nodoc
abstract mixin class $MaterialSelectionCopyWith<$Res>  {
  factory $MaterialSelectionCopyWith(MaterialSelection value, $Res Function(MaterialSelection) _then) = _$MaterialSelectionCopyWithImpl;
@useResult
$Res call({
 String materialId,@JsonKey(unknownEnumValue: MaterialType.unknown) MaterialType material, String color, double price, double area
});




}
/// @nodoc
class _$MaterialSelectionCopyWithImpl<$Res>
    implements $MaterialSelectionCopyWith<$Res> {
  _$MaterialSelectionCopyWithImpl(this._self, this._then);

  final MaterialSelection _self;
  final $Res Function(MaterialSelection) _then;

/// Create a copy of MaterialSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialId = null,Object? material = null,Object? color = null,Object? price = null,Object? area = null,}) {
  return _then(MaterialSelection(
materialId: null == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as MaterialType,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MaterialSelection].
extension MaterialSelectionPatterns on MaterialSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaterialSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaterialSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaterialSelection value)  $default,){
final _that = this;
switch (_that) {
case _MaterialSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaterialSelection value)?  $default,){
final _that = this;
switch (_that) {
case _MaterialSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String materialId, @JsonKey(unknownEnumValue: MaterialType.unknown)  MaterialType material,  String color,  double price,  double area)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaterialSelection() when $default != null:
return $default(_that.materialId,_that.material,_that.color,_that.price,_that.area);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String materialId, @JsonKey(unknownEnumValue: MaterialType.unknown)  MaterialType material,  String color,  double price,  double area)  $default,) {final _that = this;
switch (_that) {
case _MaterialSelection():
return $default(_that.materialId,_that.material,_that.color,_that.price,_that.area);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String materialId, @JsonKey(unknownEnumValue: MaterialType.unknown)  MaterialType material,  String color,  double price,  double area)?  $default,) {final _that = this;
switch (_that) {
case _MaterialSelection() when $default != null:
return $default(_that.materialId,_that.material,_that.color,_that.price,_that.area);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaterialSelection implements MaterialSelection {
  const _MaterialSelection({required this.materialId, @JsonKey(unknownEnumValue: MaterialType.unknown) required this.material, required this.color, required this.price, required this.area});
  factory _MaterialSelection.fromJson(Map<String, dynamic> json) => _$MaterialSelectionFromJson(json);

@override final  String materialId;
@override@JsonKey(unknownEnumValue: MaterialType.unknown) final  MaterialType material;
@override final  String color;
@override final  double price;
@override final  double area;

/// Create a copy of MaterialSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaterialSelectionCopyWith<_MaterialSelection> get copyWith => __$MaterialSelectionCopyWithImpl<_MaterialSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaterialSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaterialSelection&&(identical(other.materialId, materialId) || other.materialId == materialId)&&(identical(other.material, material) || other.material == material)&&(identical(other.color, color) || other.color == color)&&(identical(other.price, price) || other.price == price)&&(identical(other.area, area) || other.area == area));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,materialId,material,color,price,area);
}

@override
String toString() {
    return 'MaterialSelection(materialId: $materialId, material: $material, color: $color, price: $price, area: $area)';
}


}

/// @nodoc
abstract mixin class _$MaterialSelectionCopyWith<$Res> implements $MaterialSelectionCopyWith<$Res> {
  factory _$MaterialSelectionCopyWith(_MaterialSelection value, $Res Function(_MaterialSelection) _then) = __$MaterialSelectionCopyWithImpl;
@override @useResult
$Res call({
 String materialId,@JsonKey(unknownEnumValue: MaterialType.unknown) MaterialType material, String color, double price, double area
});




}
/// @nodoc
class __$MaterialSelectionCopyWithImpl<$Res>
    implements _$MaterialSelectionCopyWith<$Res> {
  __$MaterialSelectionCopyWithImpl(this._self, this._then);

  final _MaterialSelection _self;
  final $Res Function(_MaterialSelection) _then;

/// Create a copy of MaterialSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialId = null,Object? material = null,Object? color = null,Object? price = null,Object? area = null,}) {
  return _then(_MaterialSelection(
materialId: null == materialId ? _self.materialId : materialId // ignore: cast_nullable_to_non_nullable
as String,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as MaterialType,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$DesignSelection {

 String get id; String get roomId;@JsonKey(unknownEnumValue: DesignStage.unknown) DesignStage get stage; Map<String, MaterialSelection> get selections; RoomCondition? get roomCondition; List<FurniturePlacement> get furniture;@JsonKey(unknownEnumValue: RenovationStage.unknown) RenovationStage get renovationStage;
/// Create a copy of DesignSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DesignSelectionCopyWith<DesignSelection> get copyWith => _$DesignSelectionCopyWithImpl<DesignSelection>(this as DesignSelection, _$identity);

  /// Serializes this DesignSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DesignSelection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DesignSelection&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.stage, _this.stage) || other.stage == _this.stage)&&const DeepCollectionEquality().equals(other.selections, _this.selections)&&(identical(other.roomCondition, _this.roomCondition) || other.roomCondition == _this.roomCondition)&&const DeepCollectionEquality().equals(other.furniture, _this.furniture)&&(identical(other.renovationStage, _this.renovationStage) || other.renovationStage == _this.renovationStage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DesignSelection;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.stage,const DeepCollectionEquality().hash(_this.selections),_this.roomCondition,const DeepCollectionEquality().hash(_this.furniture),_this.renovationStage);
}

@override
String toString() {
  final _this = this as DesignSelection;
  return 'DesignSelection(id: ${_this.id}, roomId: ${_this.roomId}, stage: ${_this.stage}, selections: ${_this.selections}, roomCondition: ${_this.roomCondition}, furniture: ${_this.furniture}, renovationStage: ${_this.renovationStage})';
}


}

/// @nodoc
abstract mixin class $DesignSelectionCopyWith<$Res>  {
  factory $DesignSelectionCopyWith(DesignSelection value, $Res Function(DesignSelection) _then) = _$DesignSelectionCopyWithImpl;
@useResult
$Res call({
 String id, String roomId,@JsonKey(unknownEnumValue: DesignStage.unknown) DesignStage stage, Map<String, MaterialSelection> selections, RoomCondition? roomCondition, List<FurniturePlacement> furniture,@JsonKey(unknownEnumValue: RenovationStage.unknown) RenovationStage renovationStage
});


$RoomConditionCopyWith<$Res>? get roomCondition;

}
/// @nodoc
class _$DesignSelectionCopyWithImpl<$Res>
    implements $DesignSelectionCopyWith<$Res> {
  _$DesignSelectionCopyWithImpl(this._self, this._then);

  final DesignSelection _self;
  final $Res Function(DesignSelection) _then;

/// Create a copy of DesignSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? stage = null,Object? selections = null,Object? roomCondition = freezed,Object? furniture = null,Object? renovationStage = null,}) {
  return _then(DesignSelection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as DesignStage,selections: null == selections ? _self.selections : selections // ignore: cast_nullable_to_non_nullable
as Map<String, MaterialSelection>,roomCondition: freezed == roomCondition ? _self.roomCondition : roomCondition // ignore: cast_nullable_to_non_nullable
as RoomCondition?,furniture: null == furniture ? _self.furniture : furniture // ignore: cast_nullable_to_non_nullable
as List<FurniturePlacement>,renovationStage: null == renovationStage ? _self.renovationStage : renovationStage // ignore: cast_nullable_to_non_nullable
as RenovationStage,
  ));
}
/// Create a copy of DesignSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomConditionCopyWith<$Res>? get roomCondition {
    if (_self.roomCondition == null) {
    return null;
  }

  return $RoomConditionCopyWith<$Res>(_self.roomCondition!, (value) {
    return _then(_self.copyWith(roomCondition: value));
  });
}
}


/// Adds pattern-matching-related methods to [DesignSelection].
extension DesignSelectionPatterns on DesignSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DesignSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DesignSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DesignSelection value)  $default,){
final _that = this;
switch (_that) {
case _DesignSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DesignSelection value)?  $default,){
final _that = this;
switch (_that) {
case _DesignSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId, @JsonKey(unknownEnumValue: DesignStage.unknown)  DesignStage stage,  Map<String, MaterialSelection> selections,  RoomCondition? roomCondition,  List<FurniturePlacement> furniture, @JsonKey(unknownEnumValue: RenovationStage.unknown)  RenovationStage renovationStage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DesignSelection() when $default != null:
return $default(_that.id,_that.roomId,_that.stage,_that.selections,_that.roomCondition,_that.furniture,_that.renovationStage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId, @JsonKey(unknownEnumValue: DesignStage.unknown)  DesignStage stage,  Map<String, MaterialSelection> selections,  RoomCondition? roomCondition,  List<FurniturePlacement> furniture, @JsonKey(unknownEnumValue: RenovationStage.unknown)  RenovationStage renovationStage)  $default,) {final _that = this;
switch (_that) {
case _DesignSelection():
return $default(_that.id,_that.roomId,_that.stage,_that.selections,_that.roomCondition,_that.furniture,_that.renovationStage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId, @JsonKey(unknownEnumValue: DesignStage.unknown)  DesignStage stage,  Map<String, MaterialSelection> selections,  RoomCondition? roomCondition,  List<FurniturePlacement> furniture, @JsonKey(unknownEnumValue: RenovationStage.unknown)  RenovationStage renovationStage)?  $default,) {final _that = this;
switch (_that) {
case _DesignSelection() when $default != null:
return $default(_that.id,_that.roomId,_that.stage,_that.selections,_that.roomCondition,_that.furniture,_that.renovationStage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DesignSelection implements DesignSelection {
  const _DesignSelection({required this.id, required this.roomId, @JsonKey(unknownEnumValue: DesignStage.unknown) required this.stage,  Map<String, MaterialSelection> selections = const <String, MaterialSelection>{}, this.roomCondition,  List<FurniturePlacement> furniture = const <FurniturePlacement>[], @JsonKey(unknownEnumValue: RenovationStage.unknown) this.renovationStage = RenovationStage.suvoq}): _selections = selections,_furniture = furniture;
  factory _DesignSelection.fromJson(Map<String, dynamic> json) => _$DesignSelectionFromJson(json);

@override final  String id;
@override final  String roomId;
@override@JsonKey(unknownEnumValue: DesignStage.unknown) final  DesignStage stage;
 final  Map<String, MaterialSelection> _selections;
@override@JsonKey() Map<String, MaterialSelection> get selections {
  if (_selections is EqualUnmodifiableMapView) return _selections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selections);
}

@override final  RoomCondition? roomCondition;
 final  List<FurniturePlacement> _furniture;
@override@JsonKey() List<FurniturePlacement> get furniture {
  if (_furniture is EqualUnmodifiableListView) return _furniture;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_furniture);
}

@override@JsonKey(unknownEnumValue: RenovationStage.unknown) final  RenovationStage renovationStage;

/// Create a copy of DesignSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DesignSelectionCopyWith<_DesignSelection> get copyWith => __$DesignSelectionCopyWithImpl<_DesignSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DesignSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DesignSelection&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.stage, stage) || other.stage == stage)&&const DeepCollectionEquality().equals(other.selections, _selections)&&(identical(other.roomCondition, roomCondition) || other.roomCondition == roomCondition)&&const DeepCollectionEquality().equals(other.furniture, _furniture)&&(identical(other.renovationStage, renovationStage) || other.renovationStage == renovationStage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,stage,const DeepCollectionEquality().hash(_selections),roomCondition,const DeepCollectionEquality().hash(_furniture),renovationStage);
}

@override
String toString() {
    return 'DesignSelection(id: $id, roomId: $roomId, stage: $stage, selections: $selections, roomCondition: $roomCondition, furniture: $furniture, renovationStage: $renovationStage)';
}


}

/// @nodoc
abstract mixin class _$DesignSelectionCopyWith<$Res> implements $DesignSelectionCopyWith<$Res> {
  factory _$DesignSelectionCopyWith(_DesignSelection value, $Res Function(_DesignSelection) _then) = __$DesignSelectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId,@JsonKey(unknownEnumValue: DesignStage.unknown) DesignStage stage, Map<String, MaterialSelection> selections, RoomCondition? roomCondition, List<FurniturePlacement> furniture,@JsonKey(unknownEnumValue: RenovationStage.unknown) RenovationStage renovationStage
});


@override $RoomConditionCopyWith<$Res>? get roomCondition;

}
/// @nodoc
class __$DesignSelectionCopyWithImpl<$Res>
    implements _$DesignSelectionCopyWith<$Res> {
  __$DesignSelectionCopyWithImpl(this._self, this._then);

  final _DesignSelection _self;
  final $Res Function(_DesignSelection) _then;

/// Create a copy of DesignSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? stage = null,Object? selections = null,Object? roomCondition = freezed,Object? furniture = null,Object? renovationStage = null,}) {
  return _then(_DesignSelection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as DesignStage,selections: null == selections ? _self._selections : selections // ignore: cast_nullable_to_non_nullable
as Map<String, MaterialSelection>,roomCondition: freezed == roomCondition ? _self.roomCondition : roomCondition // ignore: cast_nullable_to_non_nullable
as RoomCondition?,furniture: null == furniture ? _self._furniture : furniture // ignore: cast_nullable_to_non_nullable
as List<FurniturePlacement>,renovationStage: null == renovationStage ? _self.renovationStage : renovationStage // ignore: cast_nullable_to_non_nullable
as RenovationStage,
  ));
}

/// Create a copy of DesignSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomConditionCopyWith<$Res>? get roomCondition {
    if (_self.roomCondition == null) {
    return null;
  }

  return $RoomConditionCopyWith<$Res>(_self.roomCondition!, (value) {
    return _then(_self.copyWith(roomCondition: value));
  });
}
}

// dart format on
