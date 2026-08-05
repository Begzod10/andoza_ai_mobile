// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apartment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Apartment _$ApartmentFromJson(Map<String, dynamic> json) {
  return _Apartment.fromJson(json);
}

/// @nodoc
mixin _$Apartment {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get developer => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<RoomOut> get rooms => throw _privateConstructorUsedError;

  /// Serializes this Apartment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Apartment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApartmentCopyWith<Apartment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApartmentCopyWith<$Res> {
  factory $ApartmentCopyWith(Apartment value, $Res Function(Apartment) then) =
      _$ApartmentCopyWithImpl<$Res, Apartment>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String name,
    String? address,
    String? developer,
    @JsonKey(name: 'created_at') DateTime createdAt,
    List<RoomOut> rooms,
  });
}

/// @nodoc
class _$ApartmentCopyWithImpl<$Res, $Val extends Apartment>
    implements $ApartmentCopyWith<$Res> {
  _$ApartmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Apartment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? address = freezed,
    Object? developer = freezed,
    Object? createdAt = null,
    Object? rooms = null,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            developer: freezed == developer
                ? _value.developer
                : developer // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            rooms: null == rooms
                ? _value.rooms
                : rooms // ignore: cast_nullable_to_non_nullable
                      as List<RoomOut>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApartmentImplCopyWith<$Res>
    implements $ApartmentCopyWith<$Res> {
  factory _$$ApartmentImplCopyWith(
    _$ApartmentImpl value,
    $Res Function(_$ApartmentImpl) then,
  ) = __$$ApartmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    String name,
    String? address,
    String? developer,
    @JsonKey(name: 'created_at') DateTime createdAt,
    List<RoomOut> rooms,
  });
}

/// @nodoc
class __$$ApartmentImplCopyWithImpl<$Res>
    extends _$ApartmentCopyWithImpl<$Res, _$ApartmentImpl>
    implements _$$ApartmentImplCopyWith<$Res> {
  __$$ApartmentImplCopyWithImpl(
    _$ApartmentImpl _value,
    $Res Function(_$ApartmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Apartment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? address = freezed,
    Object? developer = freezed,
    Object? createdAt = null,
    Object? rooms = null,
  }) {
    return _then(
      _$ApartmentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        developer: freezed == developer
            ? _value.developer
            : developer // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        rooms: null == rooms
            ? _value._rooms
            : rooms // ignore: cast_nullable_to_non_nullable
                  as List<RoomOut>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApartmentImpl implements _Apartment {
  const _$ApartmentImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    required this.name,
    this.address,
    this.developer,
    @JsonKey(name: 'created_at') required this.createdAt,
    final List<RoomOut> rooms = const <RoomOut>[],
  }) : _rooms = rooms;

  factory _$ApartmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApartmentImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String name;
  @override
  final String? address;
  @override
  final String? developer;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<RoomOut> _rooms;
  @override
  @JsonKey()
  List<RoomOut> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'Apartment(id: $id, userId: $userId, name: $name, address: $address, developer: $developer, createdAt: $createdAt, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApartmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.developer, developer) ||
                other.developer == developer) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    name,
    address,
    developer,
    createdAt,
    const DeepCollectionEquality().hash(_rooms),
  );

  /// Create a copy of Apartment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApartmentImplCopyWith<_$ApartmentImpl> get copyWith =>
      __$$ApartmentImplCopyWithImpl<_$ApartmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApartmentImplToJson(this);
  }
}

abstract class _Apartment implements Apartment {
  const factory _Apartment({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    required final String name,
    final String? address,
    final String? developer,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    final List<RoomOut> rooms,
  }) = _$ApartmentImpl;

  factory _Apartment.fromJson(Map<String, dynamic> json) =
      _$ApartmentImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get name;
  @override
  String? get address;
  @override
  String? get developer;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  List<RoomOut> get rooms;

  /// Create a copy of Apartment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApartmentImplCopyWith<_$ApartmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
