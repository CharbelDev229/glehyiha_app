import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../../common/enums/user_role.dart';

class GlehihaUserInfo extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String? email;
  final String? phonenumber;
  final UserRole role;
  final String? specialization;
  final String? nomvendeur;
  final String? experience;
  final String? photoUrl;

  const GlehihaUserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phonenumber,
    required this.role,
    this.specialization,
    this.nomvendeur,
    this.experience,
    this.photoUrl,
  });

  factory GlehihaUserInfo.fromMap(Map<String, dynamic> data) {
    return GlehihaUserInfo(
      id: data['id'] ?? 0,

      firstname: data['first_name'] as String,
      lastname: data['last_name'] as String,
      email: data['email'] as String?,
      phonenumber: data['phone_number'] as String?,
      role: UserRoleExtension.fromString(data['role'] as String),
      specialization: data['specialisation'] as String?,
      nomvendeur: data['nom_boutique'] as String?,
      experience: data['experience'] as String?,
      photoUrl: data['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'phone_number': phonenumber,
        'role': role.value,
        'specialisation': specialization,
        'nom_boutique': nomvendeur,
        'experience': experience,
        'photo_url': photoUrl,
      };

  factory GlehihaUserInfo.fromJson(String data) {
    return GlehihaUserInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        email,
        phonenumber,
        role,
        specialization,
        nomvendeur,
        experience,
        photoUrl,
      ];

  
}
