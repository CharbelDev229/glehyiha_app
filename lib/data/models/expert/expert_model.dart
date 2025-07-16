// Classe représentant un seul expert
class Expert {
  final String adresse;
  final String createdAt;
  final double distanceKm;
  final String email;
  final int experience;
  final String firstName;
  final int id;
  final bool isAdmin;
  final bool isVerified;
  final String lastName;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String role;
  final String specialization;
  final String updatedAt;

  Expert({
    required this.adresse,
    required this.createdAt,
    required this.distanceKm,
    required this.email,
    required this.experience,
    required this.firstName,
    required this.id,
    required this.isAdmin,
    required this.isVerified,
    required this.lastName,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.role,
    required this.specialization,
    required this.updatedAt,
  });

  // Méthode copyWith pour créer une copie avec des valeurs modifiées
  Expert copyWith({
    String? adresse,
    String? createdAt,
    double? distanceKm,
    String? email,
    int? experience,
    String? firstName,
    int? id,
    bool? isAdmin,
    bool? isVerified,
    String? lastName,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? role,
    String? specialization,
    String? updatedAt,
  }) {
    return Expert(
      adresse: adresse ?? this.adresse,
      createdAt: createdAt ?? this.createdAt,
      distanceKm: distanceKm ?? this.distanceKm,
      email: email ?? this.email,
      experience: experience ?? this.experience,
      firstName: firstName ?? this.firstName,
      id: id ?? this.id,
      isAdmin: isAdmin ?? this.isAdmin,
      isVerified: isVerified ?? this.isVerified,
      lastName: lastName ?? this.lastName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      specialization: specialization ?? this.specialization,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Factory constructor pour créer un objet Expert à partir d'une map JSON
  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(
      adresse: json['adresse'] as String? ?? 'N/A',
      createdAt: json['created_at'] as String? ?? '',
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0.0,
      email: json['email'] as String? ?? 'N/A',
      experience: json['experience'] is int
          ? json['experience']
          : int.tryParse((json['experience'] ?? '').toString().replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
      firstName: json['first_name'] as String? ?? 'N/A',
      id: json['id'] as int? ?? 0,
      isAdmin: json['is_admin'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      lastName: json['last_name'] as String? ?? 'N/A',
      latitude: json['latitude'] is num
          ? (json['latitude'] as num).toDouble()
          : double.tryParse((json['latitude'] ?? '').toString()) ?? 0.0,
      longitude: json['longitude'] is num
          ? (json['longitude'] as num).toDouble()
          : double.tryParse((json['longitude'] ?? '').toString()) ?? 0.0,
      phoneNumber: json['phone_number'] as String? ?? 'N/A',
      role: json['role'] as String? ?? 'N/A',
      specialization: json['specialization'] as String? ?? 'N/A',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  get name => null;
}

// Classe représentant la réponse complète de l'API
class ExpertResponse {
  final List<Expert> expertsProches;
  final String message;
  final bool success;

  ExpertResponse({
    required this.expertsProches,
    required this.message,
    required this.success,
  });

  // Factory constructor pour créer un objet ExpertResponse à partir d'une map JSON
  factory ExpertResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final list = data['experts_proches'] as List? ?? [];
    final expertsList = list
        .map((i) => Expert.fromJson(i as Map<String, dynamic>))
        .toList();

    return ExpertResponse(
      expertsProches: expertsList,
      message: json['message'] as String? ?? 'Erreur inconnue',
      success: json['success'] as bool? ?? false,
    );
  }
}
