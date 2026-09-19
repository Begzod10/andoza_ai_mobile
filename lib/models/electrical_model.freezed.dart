// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electrical_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ElectricalDevice {

 String get id;@JsonKey(unknownEnumValue: DeviceType.unknown) DeviceType get type;@OffsetConverter() Offset get position; String get wallId; double? get amps; double get heightCm; int get gangCount; String? get colorOption;@JsonKey(unknownEnumValue: ColorTemp.unknown) ColorTemp? get colorTemp;
/// Create a copy of ElectricalDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectricalDeviceCopyWith<ElectricalDevice> get copyWith => _$ElectricalDeviceCopyWithImpl<ElectricalDevice>(this as ElectricalDevice, _$identity);

  /// Serializes this ElectricalDevice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ElectricalDevice;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectricalDevice&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.wallId, _this.wallId) || other.wallId == _this.wallId)&&(identical(other.amps, _this.amps) || other.amps == _this.amps)&&(identical(other.heightCm, _this.heightCm) || other.heightCm == _this.heightCm)&&(identical(other.gangCount, _this.gangCount) || other.gangCount == _this.gangCount)&&(identical(other.colorOption, _this.colorOption) || other.colorOption == _this.colorOption)&&(identical(other.colorTemp, _this.colorTemp) || other.colorTemp == _this.colorTemp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ElectricalDevice;
  return Object.hash(runtimeType,_this.id,_this.type,_this.position,_this.wallId,_this.amps,_this.heightCm,_this.gangCount,_this.colorOption,_this.colorTemp);
}

@override
String toString() {
  final _this = this as ElectricalDevice;
  return 'ElectricalDevice(id: ${_this.id}, type: ${_this.type}, position: ${_this.position}, wallId: ${_this.wallId}, amps: ${_this.amps}, heightCm: ${_this.heightCm}, gangCount: ${_this.gangCount}, colorOption: ${_this.colorOption}, colorTemp: ${_this.colorTemp})';
}


}

/// @nodoc
abstract mixin class $ElectricalDeviceCopyWith<$Res>  {
  factory $ElectricalDeviceCopyWith(ElectricalDevice value, $Res Function(ElectricalDevice) _then) = _$ElectricalDeviceCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: DeviceType.unknown) DeviceType type,@OffsetConverter() Offset position, String wallId, double? amps, double heightCm, int gangCount, String? colorOption,@JsonKey(unknownEnumValue: ColorTemp.unknown) ColorTemp? colorTemp
});




}
/// @nodoc
class _$ElectricalDeviceCopyWithImpl<$Res>
    implements $ElectricalDeviceCopyWith<$Res> {
  _$ElectricalDeviceCopyWithImpl(this._self, this._then);

  final ElectricalDevice _self;
  final $Res Function(ElectricalDevice) _then;

/// Create a copy of ElectricalDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? position = null,Object? wallId = null,Object? amps = freezed,Object? heightCm = null,Object? gangCount = null,Object? colorOption = freezed,Object? colorTemp = freezed,}) {
  return _then(ElectricalDevice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,wallId: null == wallId ? _self.wallId : wallId // ignore: cast_nullable_to_non_nullable
as String,amps: freezed == amps ? _self.amps : amps // ignore: cast_nullable_to_non_nullable
as double?,heightCm: null == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double,gangCount: null == gangCount ? _self.gangCount : gangCount // ignore: cast_nullable_to_non_nullable
as int,colorOption: freezed == colorOption ? _self.colorOption : colorOption // ignore: cast_nullable_to_non_nullable
as String?,colorTemp: freezed == colorTemp ? _self.colorTemp : colorTemp // ignore: cast_nullable_to_non_nullable
as ColorTemp?,
  ));
}

}


/// Adds pattern-matching-related methods to [ElectricalDevice].
extension ElectricalDevicePatterns on ElectricalDevice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElectricalDevice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElectricalDevice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElectricalDevice value)  $default,){
final _that = this;
switch (_that) {
case _ElectricalDevice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElectricalDevice value)?  $default,){
final _that = this;
switch (_that) {
case _ElectricalDevice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: DeviceType.unknown)  DeviceType type, @OffsetConverter()  Offset position,  String wallId,  double? amps,  double heightCm,  int gangCount,  String? colorOption, @JsonKey(unknownEnumValue: ColorTemp.unknown)  ColorTemp? colorTemp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElectricalDevice() when $default != null:
return $default(_that.id,_that.type,_that.position,_that.wallId,_that.amps,_that.heightCm,_that.gangCount,_that.colorOption,_that.colorTemp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(unknownEnumValue: DeviceType.unknown)  DeviceType type, @OffsetConverter()  Offset position,  String wallId,  double? amps,  double heightCm,  int gangCount,  String? colorOption, @JsonKey(unknownEnumValue: ColorTemp.unknown)  ColorTemp? colorTemp)  $default,) {final _that = this;
switch (_that) {
case _ElectricalDevice():
return $default(_that.id,_that.type,_that.position,_that.wallId,_that.amps,_that.heightCm,_that.gangCount,_that.colorOption,_that.colorTemp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(unknownEnumValue: DeviceType.unknown)  DeviceType type, @OffsetConverter()  Offset position,  String wallId,  double? amps,  double heightCm,  int gangCount,  String? colorOption, @JsonKey(unknownEnumValue: ColorTemp.unknown)  ColorTemp? colorTemp)?  $default,) {final _that = this;
switch (_that) {
case _ElectricalDevice() when $default != null:
return $default(_that.id,_that.type,_that.position,_that.wallId,_that.amps,_that.heightCm,_that.gangCount,_that.colorOption,_that.colorTemp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElectricalDevice implements ElectricalDevice {
  const _ElectricalDevice({required this.id, @JsonKey(unknownEnumValue: DeviceType.unknown) required this.type, @OffsetConverter() required this.position, required this.wallId, this.amps, this.heightCm = 100, this.gangCount = 1, this.colorOption, @JsonKey(unknownEnumValue: ColorTemp.unknown) this.colorTemp});
  factory _ElectricalDevice.fromJson(Map<String, dynamic> json) => _$ElectricalDeviceFromJson(json);

@override final  String id;
@override@JsonKey(unknownEnumValue: DeviceType.unknown) final  DeviceType type;
@override@OffsetConverter() final  Offset position;
@override final  String wallId;
@override final  double? amps;
@override@JsonKey() final  double heightCm;
@override@JsonKey() final  int gangCount;
@override final  String? colorOption;
@override@JsonKey(unknownEnumValue: ColorTemp.unknown) final  ColorTemp? colorTemp;

/// Create a copy of ElectricalDevice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectricalDeviceCopyWith<_ElectricalDevice> get copyWith => __$ElectricalDeviceCopyWithImpl<_ElectricalDevice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElectricalDeviceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectricalDevice&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.position, position) || other.position == position)&&(identical(other.wallId, wallId) || other.wallId == wallId)&&(identical(other.amps, amps) || other.amps == amps)&&(identical(other.heightCm, heightCm) || other.heightCm == heightCm)&&(identical(other.gangCount, gangCount) || other.gangCount == gangCount)&&(identical(other.colorOption, colorOption) || other.colorOption == colorOption)&&(identical(other.colorTemp, colorTemp) || other.colorTemp == colorTemp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,position,wallId,amps,heightCm,gangCount,colorOption,colorTemp);
}

@override
String toString() {
    return 'ElectricalDevice(id: $id, type: $type, position: $position, wallId: $wallId, amps: $amps, heightCm: $heightCm, gangCount: $gangCount, colorOption: $colorOption, colorTemp: $colorTemp)';
}


}

/// @nodoc
abstract mixin class _$ElectricalDeviceCopyWith<$Res> implements $ElectricalDeviceCopyWith<$Res> {
  factory _$ElectricalDeviceCopyWith(_ElectricalDevice value, $Res Function(_ElectricalDevice) _then) = __$ElectricalDeviceCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(unknownEnumValue: DeviceType.unknown) DeviceType type,@OffsetConverter() Offset position, String wallId, double? amps, double heightCm, int gangCount, String? colorOption,@JsonKey(unknownEnumValue: ColorTemp.unknown) ColorTemp? colorTemp
});




}
/// @nodoc
class __$ElectricalDeviceCopyWithImpl<$Res>
    implements _$ElectricalDeviceCopyWith<$Res> {
  __$ElectricalDeviceCopyWithImpl(this._self, this._then);

  final _ElectricalDevice _self;
  final $Res Function(_ElectricalDevice) _then;

/// Create a copy of ElectricalDevice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? position = null,Object? wallId = null,Object? amps = freezed,Object? heightCm = null,Object? gangCount = null,Object? colorOption = freezed,Object? colorTemp = freezed,}) {
  return _then(_ElectricalDevice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as DeviceType,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,wallId: null == wallId ? _self.wallId : wallId // ignore: cast_nullable_to_non_nullable
as String,amps: freezed == amps ? _self.amps : amps // ignore: cast_nullable_to_non_nullable
as double?,heightCm: null == heightCm ? _self.heightCm : heightCm // ignore: cast_nullable_to_non_nullable
as double,gangCount: null == gangCount ? _self.gangCount : gangCount // ignore: cast_nullable_to_non_nullable
as int,colorOption: freezed == colorOption ? _self.colorOption : colorOption // ignore: cast_nullable_to_non_nullable
as String?,colorTemp: freezed == colorTemp ? _self.colorTemp : colorTemp // ignore: cast_nullable_to_non_nullable
as ColorTemp?,
  ));
}


}


/// @nodoc
mixin _$WireSegment {

 String get id;@OffsetConverter() Offset get from;@OffsetConverter() Offset get to; int get gauge;
/// Create a copy of WireSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WireSegmentCopyWith<WireSegment> get copyWith => _$WireSegmentCopyWithImpl<WireSegment>(this as WireSegment, _$identity);

  /// Serializes this WireSegment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WireSegment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WireSegment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to)&&(identical(other.gauge, _this.gauge) || other.gauge == _this.gauge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WireSegment;
  return Object.hash(runtimeType,_this.id,_this.from,_this.to,_this.gauge);
}

@override
String toString() {
  final _this = this as WireSegment;
  return 'WireSegment(id: ${_this.id}, from: ${_this.from}, to: ${_this.to}, gauge: ${_this.gauge})';
}


}

/// @nodoc
abstract mixin class $WireSegmentCopyWith<$Res>  {
  factory $WireSegmentCopyWith(WireSegment value, $Res Function(WireSegment) _then) = _$WireSegmentCopyWithImpl;
@useResult
$Res call({
 String id,@OffsetConverter() Offset from,@OffsetConverter() Offset to, int gauge
});




}
/// @nodoc
class _$WireSegmentCopyWithImpl<$Res>
    implements $WireSegmentCopyWith<$Res> {
  _$WireSegmentCopyWithImpl(this._self, this._then);

  final WireSegment _self;
  final $Res Function(WireSegment) _then;

/// Create a copy of WireSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? from = null,Object? to = null,Object? gauge = null,}) {
  return _then(WireSegment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Offset,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Offset,gauge: null == gauge ? _self.gauge : gauge // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WireSegment].
extension WireSegmentPatterns on WireSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WireSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WireSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WireSegment value)  $default,){
final _that = this;
switch (_that) {
case _WireSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WireSegment value)?  $default,){
final _that = this;
switch (_that) {
case _WireSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @OffsetConverter()  Offset from, @OffsetConverter()  Offset to,  int gauge)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WireSegment() when $default != null:
return $default(_that.id,_that.from,_that.to,_that.gauge);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @OffsetConverter()  Offset from, @OffsetConverter()  Offset to,  int gauge)  $default,) {final _that = this;
switch (_that) {
case _WireSegment():
return $default(_that.id,_that.from,_that.to,_that.gauge);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @OffsetConverter()  Offset from, @OffsetConverter()  Offset to,  int gauge)?  $default,) {final _that = this;
switch (_that) {
case _WireSegment() when $default != null:
return $default(_that.id,_that.from,_that.to,_that.gauge);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WireSegment implements WireSegment {
  const _WireSegment({required this.id, @OffsetConverter() required this.from, @OffsetConverter() required this.to, required this.gauge});
  factory _WireSegment.fromJson(Map<String, dynamic> json) => _$WireSegmentFromJson(json);

@override final  String id;
@override@OffsetConverter() final  Offset from;
@override@OffsetConverter() final  Offset to;
@override final  int gauge;

/// Create a copy of WireSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WireSegmentCopyWith<_WireSegment> get copyWith => __$WireSegmentCopyWithImpl<_WireSegment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WireSegmentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WireSegment&&(identical(other.id, id) || other.id == id)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.gauge, gauge) || other.gauge == gauge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,from,to,gauge);
}

@override
String toString() {
    return 'WireSegment(id: $id, from: $from, to: $to, gauge: $gauge)';
}


}

/// @nodoc
abstract mixin class _$WireSegmentCopyWith<$Res> implements $WireSegmentCopyWith<$Res> {
  factory _$WireSegmentCopyWith(_WireSegment value, $Res Function(_WireSegment) _then) = __$WireSegmentCopyWithImpl;
@override @useResult
$Res call({
 String id,@OffsetConverter() Offset from,@OffsetConverter() Offset to, int gauge
});




}
/// @nodoc
class __$WireSegmentCopyWithImpl<$Res>
    implements _$WireSegmentCopyWith<$Res> {
  __$WireSegmentCopyWithImpl(this._self, this._then);

  final _WireSegment _self;
  final $Res Function(_WireSegment) _then;

/// Create a copy of WireSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? from = null,Object? to = null,Object? gauge = null,}) {
  return _then(_WireSegment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Offset,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Offset,gauge: null == gauge ? _self.gauge : gauge // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PipeSegment {

 String get id;@OffsetConverter() Offset get from;@OffsetConverter() Offset get to;@JsonKey(unknownEnumValue: PipeType.unknown) PipeType get type;
/// Create a copy of PipeSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipeSegmentCopyWith<PipeSegment> get copyWith => _$PipeSegmentCopyWithImpl<PipeSegment>(this as PipeSegment, _$identity);

  /// Serializes this PipeSegment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PipeSegment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PipeSegment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to)&&(identical(other.type, _this.type) || other.type == _this.type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PipeSegment;
  return Object.hash(runtimeType,_this.id,_this.from,_this.to,_this.type);
}

@override
String toString() {
  final _this = this as PipeSegment;
  return 'PipeSegment(id: ${_this.id}, from: ${_this.from}, to: ${_this.to}, type: ${_this.type})';
}


}

/// @nodoc
abstract mixin class $PipeSegmentCopyWith<$Res>  {
  factory $PipeSegmentCopyWith(PipeSegment value, $Res Function(PipeSegment) _then) = _$PipeSegmentCopyWithImpl;
@useResult
$Res call({
 String id,@OffsetConverter() Offset from,@OffsetConverter() Offset to,@JsonKey(unknownEnumValue: PipeType.unknown) PipeType type
});




}
/// @nodoc
class _$PipeSegmentCopyWithImpl<$Res>
    implements $PipeSegmentCopyWith<$Res> {
  _$PipeSegmentCopyWithImpl(this._self, this._then);

  final PipeSegment _self;
  final $Res Function(PipeSegment) _then;

/// Create a copy of PipeSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? from = null,Object? to = null,Object? type = null,}) {
  return _then(PipeSegment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Offset,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Offset,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PipeType,
  ));
}

}


/// Adds pattern-matching-related methods to [PipeSegment].
extension PipeSegmentPatterns on PipeSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PipeSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PipeSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PipeSegment value)  $default,){
final _that = this;
switch (_that) {
case _PipeSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PipeSegment value)?  $default,){
final _that = this;
switch (_that) {
case _PipeSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @OffsetConverter()  Offset from, @OffsetConverter()  Offset to, @JsonKey(unknownEnumValue: PipeType.unknown)  PipeType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PipeSegment() when $default != null:
return $default(_that.id,_that.from,_that.to,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @OffsetConverter()  Offset from, @OffsetConverter()  Offset to, @JsonKey(unknownEnumValue: PipeType.unknown)  PipeType type)  $default,) {final _that = this;
switch (_that) {
case _PipeSegment():
return $default(_that.id,_that.from,_that.to,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @OffsetConverter()  Offset from, @OffsetConverter()  Offset to, @JsonKey(unknownEnumValue: PipeType.unknown)  PipeType type)?  $default,) {final _that = this;
switch (_that) {
case _PipeSegment() when $default != null:
return $default(_that.id,_that.from,_that.to,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PipeSegment implements PipeSegment {
  const _PipeSegment({required this.id, @OffsetConverter() required this.from, @OffsetConverter() required this.to, @JsonKey(unknownEnumValue: PipeType.unknown) required this.type});
  factory _PipeSegment.fromJson(Map<String, dynamic> json) => _$PipeSegmentFromJson(json);

@override final  String id;
@override@OffsetConverter() final  Offset from;
@override@OffsetConverter() final  Offset to;
@override@JsonKey(unknownEnumValue: PipeType.unknown) final  PipeType type;

/// Create a copy of PipeSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipeSegmentCopyWith<_PipeSegment> get copyWith => __$PipeSegmentCopyWithImpl<_PipeSegment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipeSegmentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PipeSegment&&(identical(other.id, id) || other.id == id)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,from,to,type);
}

@override
String toString() {
    return 'PipeSegment(id: $id, from: $from, to: $to, type: $type)';
}


}

/// @nodoc
abstract mixin class _$PipeSegmentCopyWith<$Res> implements $PipeSegmentCopyWith<$Res> {
  factory _$PipeSegmentCopyWith(_PipeSegment value, $Res Function(_PipeSegment) _then) = __$PipeSegmentCopyWithImpl;
@override @useResult
$Res call({
 String id,@OffsetConverter() Offset from,@OffsetConverter() Offset to,@JsonKey(unknownEnumValue: PipeType.unknown) PipeType type
});




}
/// @nodoc
class __$PipeSegmentCopyWithImpl<$Res>
    implements _$PipeSegmentCopyWith<$Res> {
  __$PipeSegmentCopyWithImpl(this._self, this._then);

  final _PipeSegment _self;
  final $Res Function(_PipeSegment) _then;

/// Create a copy of PipeSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? from = null,Object? to = null,Object? type = null,}) {
  return _then(_PipeSegment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Offset,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Offset,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PipeType,
  ));
}


}


/// @nodoc
mixin _$JunctionBox {

 String get id;@OffsetConverter() Offset get position; int get capacity; int get connections;
/// Create a copy of JunctionBox
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JunctionBoxCopyWith<JunctionBox> get copyWith => _$JunctionBoxCopyWithImpl<JunctionBox>(this as JunctionBox, _$identity);

  /// Serializes this JunctionBox to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as JunctionBox;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JunctionBox&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.connections, _this.connections) || other.connections == _this.connections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as JunctionBox;
  return Object.hash(runtimeType,_this.id,_this.position,_this.capacity,_this.connections);
}

@override
String toString() {
  final _this = this as JunctionBox;
  return 'JunctionBox(id: ${_this.id}, position: ${_this.position}, capacity: ${_this.capacity}, connections: ${_this.connections})';
}


}

/// @nodoc
abstract mixin class $JunctionBoxCopyWith<$Res>  {
  factory $JunctionBoxCopyWith(JunctionBox value, $Res Function(JunctionBox) _then) = _$JunctionBoxCopyWithImpl;
@useResult
$Res call({
 String id,@OffsetConverter() Offset position, int capacity, int connections
});




}
/// @nodoc
class _$JunctionBoxCopyWithImpl<$Res>
    implements $JunctionBoxCopyWith<$Res> {
  _$JunctionBoxCopyWithImpl(this._self, this._then);

  final JunctionBox _self;
  final $Res Function(JunctionBox) _then;

/// Create a copy of JunctionBox
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? position = null,Object? capacity = null,Object? connections = null,}) {
  return _then(JunctionBox(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,connections: null == connections ? _self.connections : connections // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [JunctionBox].
extension JunctionBoxPatterns on JunctionBox {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JunctionBox value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JunctionBox() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JunctionBox value)  $default,){
final _that = this;
switch (_that) {
case _JunctionBox():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JunctionBox value)?  $default,){
final _that = this;
switch (_that) {
case _JunctionBox() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @OffsetConverter()  Offset position,  int capacity,  int connections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JunctionBox() when $default != null:
return $default(_that.id,_that.position,_that.capacity,_that.connections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @OffsetConverter()  Offset position,  int capacity,  int connections)  $default,) {final _that = this;
switch (_that) {
case _JunctionBox():
return $default(_that.id,_that.position,_that.capacity,_that.connections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @OffsetConverter()  Offset position,  int capacity,  int connections)?  $default,) {final _that = this;
switch (_that) {
case _JunctionBox() when $default != null:
return $default(_that.id,_that.position,_that.capacity,_that.connections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JunctionBox implements JunctionBox {
  const _JunctionBox({required this.id, @OffsetConverter() required this.position, required this.capacity, required this.connections});
  factory _JunctionBox.fromJson(Map<String, dynamic> json) => _$JunctionBoxFromJson(json);

@override final  String id;
@override@OffsetConverter() final  Offset position;
@override final  int capacity;
@override final  int connections;

/// Create a copy of JunctionBox
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JunctionBoxCopyWith<_JunctionBox> get copyWith => __$JunctionBoxCopyWithImpl<_JunctionBox>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JunctionBoxToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JunctionBox&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.connections, connections) || other.connections == connections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,position,capacity,connections);
}

@override
String toString() {
    return 'JunctionBox(id: $id, position: $position, capacity: $capacity, connections: $connections)';
}


}

/// @nodoc
abstract mixin class _$JunctionBoxCopyWith<$Res> implements $JunctionBoxCopyWith<$Res> {
  factory _$JunctionBoxCopyWith(_JunctionBox value, $Res Function(_JunctionBox) _then) = __$JunctionBoxCopyWithImpl;
@override @useResult
$Res call({
 String id,@OffsetConverter() Offset position, int capacity, int connections
});




}
/// @nodoc
class __$JunctionBoxCopyWithImpl<$Res>
    implements _$JunctionBoxCopyWith<$Res> {
  __$JunctionBoxCopyWithImpl(this._self, this._then);

  final _JunctionBox _self;
  final $Res Function(_JunctionBox) _then;

/// Create a copy of JunctionBox
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? position = null,Object? capacity = null,Object? connections = null,}) {
  return _then(_JunctionBox(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Offset,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,connections: null == connections ? _self.connections : connections // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ElectricalLayout {

 String get id; String get roomId; List<ElectricalDevice> get devices; List<WireSegment> get wires; List<JunctionBox> get junctionBoxes; List<PipeSegment> get pipes;
/// Create a copy of ElectricalLayout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectricalLayoutCopyWith<ElectricalLayout> get copyWith => _$ElectricalLayoutCopyWithImpl<ElectricalLayout>(this as ElectricalLayout, _$identity);

  /// Serializes this ElectricalLayout to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ElectricalLayout;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectricalLayout&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&const DeepCollectionEquality().equals(other.devices, _this.devices)&&const DeepCollectionEquality().equals(other.wires, _this.wires)&&const DeepCollectionEquality().equals(other.junctionBoxes, _this.junctionBoxes)&&const DeepCollectionEquality().equals(other.pipes, _this.pipes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ElectricalLayout;
  return Object.hash(runtimeType,_this.id,_this.roomId,const DeepCollectionEquality().hash(_this.devices),const DeepCollectionEquality().hash(_this.wires),const DeepCollectionEquality().hash(_this.junctionBoxes),const DeepCollectionEquality().hash(_this.pipes));
}

@override
String toString() {
  final _this = this as ElectricalLayout;
  return 'ElectricalLayout(id: ${_this.id}, roomId: ${_this.roomId}, devices: ${_this.devices}, wires: ${_this.wires}, junctionBoxes: ${_this.junctionBoxes}, pipes: ${_this.pipes})';
}


}

/// @nodoc
abstract mixin class $ElectricalLayoutCopyWith<$Res>  {
  factory $ElectricalLayoutCopyWith(ElectricalLayout value, $Res Function(ElectricalLayout) _then) = _$ElectricalLayoutCopyWithImpl;
@useResult
$Res call({
 String id, String roomId, List<ElectricalDevice> devices, List<WireSegment> wires, List<JunctionBox> junctionBoxes, List<PipeSegment> pipes
});




}
/// @nodoc
class _$ElectricalLayoutCopyWithImpl<$Res>
    implements $ElectricalLayoutCopyWith<$Res> {
  _$ElectricalLayoutCopyWithImpl(this._self, this._then);

  final ElectricalLayout _self;
  final $Res Function(ElectricalLayout) _then;

/// Create a copy of ElectricalLayout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? devices = null,Object? wires = null,Object? junctionBoxes = null,Object? pipes = null,}) {
  return _then(ElectricalLayout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,devices: null == devices ? _self.devices : devices // ignore: cast_nullable_to_non_nullable
as List<ElectricalDevice>,wires: null == wires ? _self.wires : wires // ignore: cast_nullable_to_non_nullable
as List<WireSegment>,junctionBoxes: null == junctionBoxes ? _self.junctionBoxes : junctionBoxes // ignore: cast_nullable_to_non_nullable
as List<JunctionBox>,pipes: null == pipes ? _self.pipes : pipes // ignore: cast_nullable_to_non_nullable
as List<PipeSegment>,
  ));
}

}


/// Adds pattern-matching-related methods to [ElectricalLayout].
extension ElectricalLayoutPatterns on ElectricalLayout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElectricalLayout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElectricalLayout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElectricalLayout value)  $default,){
final _that = this;
switch (_that) {
case _ElectricalLayout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElectricalLayout value)?  $default,){
final _that = this;
switch (_that) {
case _ElectricalLayout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId,  List<ElectricalDevice> devices,  List<WireSegment> wires,  List<JunctionBox> junctionBoxes,  List<PipeSegment> pipes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElectricalLayout() when $default != null:
return $default(_that.id,_that.roomId,_that.devices,_that.wires,_that.junctionBoxes,_that.pipes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId,  List<ElectricalDevice> devices,  List<WireSegment> wires,  List<JunctionBox> junctionBoxes,  List<PipeSegment> pipes)  $default,) {final _that = this;
switch (_that) {
case _ElectricalLayout():
return $default(_that.id,_that.roomId,_that.devices,_that.wires,_that.junctionBoxes,_that.pipes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId,  List<ElectricalDevice> devices,  List<WireSegment> wires,  List<JunctionBox> junctionBoxes,  List<PipeSegment> pipes)?  $default,) {final _that = this;
switch (_that) {
case _ElectricalLayout() when $default != null:
return $default(_that.id,_that.roomId,_that.devices,_that.wires,_that.junctionBoxes,_that.pipes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElectricalLayout implements ElectricalLayout {
  const _ElectricalLayout({required this.id, required this.roomId,  List<ElectricalDevice> devices = const <ElectricalDevice>[],  List<WireSegment> wires = const <WireSegment>[],  List<JunctionBox> junctionBoxes = const <JunctionBox>[],  List<PipeSegment> pipes = const <PipeSegment>[]}): _devices = devices,_wires = wires,_junctionBoxes = junctionBoxes,_pipes = pipes;
  factory _ElectricalLayout.fromJson(Map<String, dynamic> json) => _$ElectricalLayoutFromJson(json);

@override final  String id;
@override final  String roomId;
 final  List<ElectricalDevice> _devices;
@override@JsonKey() List<ElectricalDevice> get devices {
  if (_devices is EqualUnmodifiableListView) return _devices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_devices);
}

 final  List<WireSegment> _wires;
@override@JsonKey() List<WireSegment> get wires {
  if (_wires is EqualUnmodifiableListView) return _wires;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wires);
}

 final  List<JunctionBox> _junctionBoxes;
@override@JsonKey() List<JunctionBox> get junctionBoxes {
  if (_junctionBoxes is EqualUnmodifiableListView) return _junctionBoxes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_junctionBoxes);
}

 final  List<PipeSegment> _pipes;
@override@JsonKey() List<PipeSegment> get pipes {
  if (_pipes is EqualUnmodifiableListView) return _pipes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pipes);
}


/// Create a copy of ElectricalLayout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectricalLayoutCopyWith<_ElectricalLayout> get copyWith => __$ElectricalLayoutCopyWithImpl<_ElectricalLayout>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElectricalLayoutToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectricalLayout&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&const DeepCollectionEquality().equals(other.devices, _devices)&&const DeepCollectionEquality().equals(other.wires, _wires)&&const DeepCollectionEquality().equals(other.junctionBoxes, _junctionBoxes)&&const DeepCollectionEquality().equals(other.pipes, _pipes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,const DeepCollectionEquality().hash(_devices),const DeepCollectionEquality().hash(_wires),const DeepCollectionEquality().hash(_junctionBoxes),const DeepCollectionEquality().hash(_pipes));
}

@override
String toString() {
    return 'ElectricalLayout(id: $id, roomId: $roomId, devices: $devices, wires: $wires, junctionBoxes: $junctionBoxes, pipes: $pipes)';
}


}

/// @nodoc
abstract mixin class _$ElectricalLayoutCopyWith<$Res> implements $ElectricalLayoutCopyWith<$Res> {
  factory _$ElectricalLayoutCopyWith(_ElectricalLayout value, $Res Function(_ElectricalLayout) _then) = __$ElectricalLayoutCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId, List<ElectricalDevice> devices, List<WireSegment> wires, List<JunctionBox> junctionBoxes, List<PipeSegment> pipes
});




}
/// @nodoc
class __$ElectricalLayoutCopyWithImpl<$Res>
    implements _$ElectricalLayoutCopyWith<$Res> {
  __$ElectricalLayoutCopyWithImpl(this._self, this._then);

  final _ElectricalLayout _self;
  final $Res Function(_ElectricalLayout) _then;

/// Create a copy of ElectricalLayout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? devices = null,Object? wires = null,Object? junctionBoxes = null,Object? pipes = null,}) {
  return _then(_ElectricalLayout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,devices: null == devices ? _self._devices : devices // ignore: cast_nullable_to_non_nullable
as List<ElectricalDevice>,wires: null == wires ? _self._wires : wires // ignore: cast_nullable_to_non_nullable
as List<WireSegment>,junctionBoxes: null == junctionBoxes ? _self._junctionBoxes : junctionBoxes // ignore: cast_nullable_to_non_nullable
as List<JunctionBox>,pipes: null == pipes ? _self._pipes : pipes // ignore: cast_nullable_to_non_nullable
as List<PipeSegment>,
  ));
}


}

// dart format on
