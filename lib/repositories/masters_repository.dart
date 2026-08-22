/// A repair master/contractor that can be discovered and booked.
///
/// This is the UI-facing model consumed by `masters_provider.dart` (mapped
/// from the backend `Usta` DTO). The former `MastersRepository` API plumbing
/// (search/reviews/booking over HTTP) was never wired up and has been removed;
/// only this model remains in use.
class Master {
  const Master({
    required this.id,
    required this.name,
    this.avatar,
    this.specialty,
    this.rating,
    this.reviewCount = 0,
    this.latitude,
    this.longitude,
    this.distanceKm,
    this.isAvailable = true,
  });

  factory Master.fromJson(Map<String, dynamic> json) {
    return Master(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      specialty: json['specialty'] as String?,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      distanceKm: json['distance_km'] != null
          ? (json['distance_km'] as num).toDouble()
          : null,
      isAvailable: json['is_available'] as bool? ?? true,
    );
  }

  final String id;
  final String name;
  final String? avatar;
  final String? specialty;
  final double? rating;
  final int reviewCount;
  final double? latitude;
  final double? longitude;

  /// Distance from the searched location in kilometers, when known.
  final double? distanceKm;
  final bool isAvailable;
}
