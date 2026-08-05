import 'package:freezed_annotation/freezed_annotation.dart';

import 'room_out.dart';

part 'apartment.freezed.dart';
part 'apartment.g.dart';

/// An apartment / project container (`GET /api/v1/apartments`).
///
/// Mirrors `app/schemas/apartment.py::ApartmentOut`. The list endpoint returns
/// the [ApartmentWithRooms] variant with nested rooms populated.
@freezed
class Apartment with _$Apartment {
  const factory Apartment({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    String? address,
    String? developer,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(<RoomOut>[]) List<RoomOut> rooms,
  }) = _Apartment;

  factory Apartment.fromJson(Map<String, dynamic> json) =>
      _$ApartmentFromJson(json);
}
