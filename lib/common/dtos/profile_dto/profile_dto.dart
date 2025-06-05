import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class ProfileDto extends Equatable {
  final String? firstname;
  final String? lastname;
  final String? email; // <- Retiré temporairement de l'envoi
  final String? phoneNumber;
  final String? role;
  final String? pseudo;
  final String? sex;
  final File? avatar;
  final String? media;

  const ProfileDto({
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.role,
    this.pseudo,
    this.sex,
    this.avatar,
    this.media,
  });

  Map<String, String> toMap() {
    final Map<String, String> data = {};

    void addIfNotNull(String key, dynamic value) {
      if (value != null && value != '') {
        data[key] = value.toString();
      }
    }

    // Envoi uniquement des champs de base pour tester
    addIfNotNull('firstname', firstname);
    addIfNotNull('lastname', lastname);
    addIfNotNull('phone_number', phoneNumber);
    addIfNotNull('role', role);
    addIfNotNull('pseudo', pseudo);
    addIfNotNull('sex', sex);
    addIfNotNull('media', media);

    // ⚠️ N'ajoute pas l'email ici pour éviter erreur serveur
    // addIfNotNull('email', email);

    return data;
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      firstname,
      lastname,
      // email,
      phoneNumber,
      role,
      pseudo,
      sex,
      avatar,
      media,
    ];
  }
}
