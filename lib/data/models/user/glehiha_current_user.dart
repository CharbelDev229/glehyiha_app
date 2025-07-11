import 'dart:convert';
import 'package:equatable/equatable.dart';

class GlehihaCurrentUser extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? emailVerifiedAt;
  final bool isActive;
  final String? lastSeen;
  final String pseudo;
  final String? sex;
  final String avatar;
  final String role;
  final String? biography;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> media;

  const GlehihaCurrentUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
   required this.phoneNumber,
    this.emailVerifiedAt,
    required this.isActive,
    this.lastSeen,
    required this.pseudo,
    this.sex,
    required this.avatar,
    required this.media,
    required this.role,
    this.biography,
    required this.createdAt,
    required this.updatedAt,
  });

 factory GlehihaCurrentUser.fromMap(Map<String, dynamic> data) =>
    GlehihaCurrentUser(
      id: data['id'] ?? 0,
      firstName: data['first_name']?.toString() ?? '', // ✅ Corrigé
      lastName: data['last_name']?.toString() ?? '',   // ✅ Corrigé
      email: data['email']?.toString() ?? '',
      phoneNumber: data['phone_number']?.toString() ?? '',
      emailVerifiedAt: data['email_verified_at']?.toString(),
      isActive: data['is_verified'] == true, // ✅ Corrigé selon ton backend
      lastSeen: data['last_seen']?.toString(),
      pseudo: data['pseudo']?.toString() ?? '',
      sex: data['sex']?.toString(),
      avatar: data['avatar']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      biography: data['biography']?.toString(),
      createdAt: DateTime.tryParse(data['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(data['updated_at']?.toString() ?? '') ?? DateTime.now(),
      media: [], // ou List<dynamic>.from(data['media'] ?? []), si présent
    );

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'email_verified_at': emailVerifiedAt,
        'active': isActive ? 1 : 0,
        'last_seen': lastSeen,
        'pseudo': pseudo,
        'sex': sex,
        'avatar': avatar,
        'role': role,
        'biography': biography,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'media': media,
      };

  GlehihaCurrentUser copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? emailVerifiedAt,
    bool? isActive,
    String? lastSeen,
    String? pseudo,
    String? sex,
    String? avatar,
    String? role,
    String? biography,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? media,
  }) {
    return GlehihaCurrentUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      isActive: isActive ?? this.isActive,
      lastSeen: lastSeen ?? this.lastSeen,
      pseudo: pseudo ?? this.pseudo,
      sex: sex ?? this.sex,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      biography: biography ?? this.biography,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      media: media ?? this.media,
    );
  }

  /// Crée une instance depuis une chaîne JSON
  factory GlehihaCurrentUser.fromJson(String data) {
    return GlehihaCurrentUser.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// Convertit l'instance en chaîne JSON
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        emailVerifiedAt,
        isActive,
        lastSeen,
        pseudo,
        sex,
        avatar,
        role,
        biography,
        createdAt,
        updatedAt,
        media,
      ];

  get data => null;

  @override
  String toString() {
    return 'GlehihaCurrentUser(id: $id, firstName: $firstName, lastName: $lastName, email: $email, role: $role)';
  }
}
