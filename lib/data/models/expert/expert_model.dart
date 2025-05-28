// data/models/expert/expert.dart
class Expert {
  final int id;
  final String name;
  final String specialty;
  final double latitude;
  final double longitude;
  final double rating;
  final String profileImage;
  final String phoneNumber;
  final String email;
  final bool isAvailable;
  final double? distance; // Calculée côté client

  Expert({
    required this.id,
    required this.name,
    required this.specialty,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.profileImage,
    required this.phoneNumber,
    required this.email,
    required this.isAvailable,
    this.distance,
  });

  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      profileImage: json['profile_image'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      isAvailable: json['is_available'] ?? false,
      distance: json['distance']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'profile_image': profileImage,
      'phone_number': phoneNumber,
      'email': email,
      'is_available': isAvailable,
      'distance': distance,
    };
  }

  Expert copyWith({
    int? id,
    String? name,
    String? specialty,
    double? latitude,
    double? longitude,
    double? rating,
    String? profileImage,
    String? phoneNumber,
    String? email,
    bool? isAvailable,
    double? distance,
  }) {
    return Expert(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      isAvailable: isAvailable ?? this.isAvailable,
      distance: distance ?? this.distance,
    );
  }
}