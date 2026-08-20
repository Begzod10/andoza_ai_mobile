// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Usta _$UstaFromJson(Map<String, dynamic> json) {
  return _Usta.fromJson(json);
}

/// @nodoc
mixin _$Usta {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get telegram => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'jobs_count')
  int get jobsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_min')
  int? get priceMin => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_max')
  int? get priceMax => throw _privateConstructorUsedError;
  bool get verified => throw _privateConstructorUsedError;
  @JsonKey(name: 'lat')
  double? get lat => throw _privateConstructorUsedError;
  @JsonKey(name: 'lng')
  double? get lng => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Serializes this Usta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Usta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UstaCopyWith<Usta> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UstaCopyWith<$Res> {
  factory $UstaCopyWith(Usta value, $Res Function(Usta) then) =
      _$UstaCopyWithImpl<$Res, Usta>;
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    String? district,
    String phone,
    String? telegram,
    double rating,
    @JsonKey(name: 'jobs_count') int jobsCount,
    @JsonKey(name: 'price_min') int? priceMin,
    @JsonKey(name: 'price_max') int? priceMax,
    bool verified,
    @JsonKey(name: 'lat') double? lat,
    @JsonKey(name: 'lng') double? lng,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class _$UstaCopyWithImpl<$Res, $Val extends Usta>
    implements $UstaCopyWith<$Res> {
  _$UstaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Usta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? district = freezed,
    Object? phone = null,
    Object? telegram = freezed,
    Object? rating = null,
    Object? jobsCount = null,
    Object? priceMin = freezed,
    Object? priceMax = freezed,
    Object? verified = null,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? avatarUrl = freezed,
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
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            district: freezed == district
                ? _value.district
                : district // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            telegram: freezed == telegram
                ? _value.telegram
                : telegram // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            jobsCount: null == jobsCount
                ? _value.jobsCount
                : jobsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            priceMin: freezed == priceMin
                ? _value.priceMin
                : priceMin // ignore: cast_nullable_to_non_nullable
                      as int?,
            priceMax: freezed == priceMax
                ? _value.priceMax
                : priceMax // ignore: cast_nullable_to_non_nullable
                      as int?,
            verified: null == verified
                ? _value.verified
                : verified // ignore: cast_nullable_to_non_nullable
                      as bool,
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lng: freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UstaImplCopyWith<$Res> implements $UstaCopyWith<$Res> {
  factory _$$UstaImplCopyWith(
    _$UstaImpl value,
    $Res Function(_$UstaImpl) then,
  ) = __$$UstaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    String? district,
    String phone,
    String? telegram,
    double rating,
    @JsonKey(name: 'jobs_count') int jobsCount,
    @JsonKey(name: 'price_min') int? priceMin,
    @JsonKey(name: 'price_max') int? priceMax,
    bool verified,
    @JsonKey(name: 'lat') double? lat,
    @JsonKey(name: 'lng') double? lng,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  });
}

/// @nodoc
class __$$UstaImplCopyWithImpl<$Res>
    extends _$UstaCopyWithImpl<$Res, _$UstaImpl>
    implements _$$UstaImplCopyWith<$Res> {
  __$$UstaImplCopyWithImpl(_$UstaImpl _value, $Res Function(_$UstaImpl) _then)
    : super(_value, _then);

  /// Create a copy of Usta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? district = freezed,
    Object? phone = null,
    Object? telegram = freezed,
    Object? rating = null,
    Object? jobsCount = null,
    Object? priceMin = freezed,
    Object? priceMax = freezed,
    Object? verified = null,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _$UstaImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        district: freezed == district
            ? _value.district
            : district // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        telegram: freezed == telegram
            ? _value.telegram
            : telegram // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        jobsCount: null == jobsCount
            ? _value.jobsCount
            : jobsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        priceMin: freezed == priceMin
            ? _value.priceMin
            : priceMin // ignore: cast_nullable_to_non_nullable
                  as int?,
        priceMax: freezed == priceMax
            ? _value.priceMax
            : priceMax // ignore: cast_nullable_to_non_nullable
                  as int?,
        verified: null == verified
            ? _value.verified
            : verified // ignore: cast_nullable_to_non_nullable
                  as bool,
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lng: freezed == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UstaImpl implements _Usta {
  const _$UstaImpl({
    required this.id,
    required this.name,
    required this.category,
    this.district,
    required this.phone,
    this.telegram,
    this.rating = 0.0,
    @JsonKey(name: 'jobs_count') this.jobsCount = 0,
    @JsonKey(name: 'price_min') this.priceMin,
    @JsonKey(name: 'price_max') this.priceMax,
    this.verified = false,
    @JsonKey(name: 'lat') this.lat,
    @JsonKey(name: 'lng') this.lng,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
  });

  factory _$UstaImpl.fromJson(Map<String, dynamic> json) =>
      _$$UstaImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String? district;
  @override
  final String phone;
  @override
  final String? telegram;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'jobs_count')
  final int jobsCount;
  @override
  @JsonKey(name: 'price_min')
  final int? priceMin;
  @override
  @JsonKey(name: 'price_max')
  final int? priceMax;
  @override
  @JsonKey()
  final bool verified;
  @override
  @JsonKey(name: 'lat')
  final double? lat;
  @override
  @JsonKey(name: 'lng')
  final double? lng;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @override
  String toString() {
    return 'Usta(id: $id, name: $name, category: $category, district: $district, phone: $phone, telegram: $telegram, rating: $rating, jobsCount: $jobsCount, priceMin: $priceMin, priceMax: $priceMax, verified: $verified, lat: $lat, lng: $lng, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UstaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.telegram, telegram) ||
                other.telegram == telegram) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.jobsCount, jobsCount) ||
                other.jobsCount == jobsCount) &&
            (identical(other.priceMin, priceMin) ||
                other.priceMin == priceMin) &&
            (identical(other.priceMax, priceMax) ||
                other.priceMax == priceMax) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    district,
    phone,
    telegram,
    rating,
    jobsCount,
    priceMin,
    priceMax,
    verified,
    lat,
    lng,
    avatarUrl,
  );

  /// Create a copy of Usta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UstaImplCopyWith<_$UstaImpl> get copyWith =>
      __$$UstaImplCopyWithImpl<_$UstaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UstaImplToJson(this);
  }
}

abstract class _Usta implements Usta {
  const factory _Usta({
    required final String id,
    required final String name,
    required final String category,
    final String? district,
    required final String phone,
    final String? telegram,
    final double rating,
    @JsonKey(name: 'jobs_count') final int jobsCount,
    @JsonKey(name: 'price_min') final int? priceMin,
    @JsonKey(name: 'price_max') final int? priceMax,
    final bool verified,
    @JsonKey(name: 'lat') final double? lat,
    @JsonKey(name: 'lng') final double? lng,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
  }) = _$UstaImpl;

  factory _Usta.fromJson(Map<String, dynamic> json) = _$UstaImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String? get district;
  @override
  String get phone;
  @override
  String? get telegram;
  @override
  double get rating;
  @override
  @JsonKey(name: 'jobs_count')
  int get jobsCount;
  @override
  @JsonKey(name: 'price_min')
  int? get priceMin;
  @override
  @JsonKey(name: 'price_max')
  int? get priceMax;
  @override
  bool get verified;
  @override
  @JsonKey(name: 'lat')
  double? get lat;
  @override
  @JsonKey(name: 'lng')
  double? get lng;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;

  /// Create a copy of Usta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UstaImplCopyWith<_$UstaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
