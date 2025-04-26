import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../../common/enums/user_role.dart';

class GlehihaUserInfo extends Equatable {
  final int id;
  final String firstname;
  final String lastname;
  final String? email;
  final String? phoneNumber;
  final UserRole role;
  final String? specialisation;
  final String? shopName;
  final String? experience;

  const GlehihaUserInfo({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phoneNumber,
    required this.role,
    this.specialisation,
    this.shopName,
    this.experience,
  });

  factory GlehihaUserInfo.fromMap(Map<String, dynamic> data) {
    return GlehihaUserInfo(
      id: data['id'] as int,
      firstname: data['firstname'] as String,
      lastname: data['lastname'] as String,
      email: data['email'] as String?,
      phoneNumber: data['phone_number'] as String?,
      role: UserRoleExtension.fromString(data['role'] as String),
      specialisation: data['specialisation'] as String?,
      shopName: data['nom_boutique'] as String?,
      experience: data['experience'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'phone_number': phoneNumber,
        'role': role.value,
        'specialisation': specialisation,
        'nom_boutique': shopName,
        'experience': experience,
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
        phoneNumber,
        role,
        specialisation,
        shopName,
        experience,
      ];
}
