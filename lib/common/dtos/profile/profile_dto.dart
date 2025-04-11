import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class ProfileDto extends Equatable {
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? pseudo;
  final String? sex;
  final String? bonusCode;
  final String? birthDate;
  final String? notificationId;
  final double? latitude;
  final double? longitude;
  final String? biography;
  final String? firebaseUuid;
  final File? avatar;

  const ProfileDto({
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.role,
    this.pseudo,
    this.sex,
    this.bonusCode,
    this.birthDate,
    this.notificationId,
    this.latitude,
    this.longitude,
    this.biography,
    this.firebaseUuid,
    this.avatar,
  });

  // factory ProfileDto.fromMap(Map<String, dynamic> data) => ProfileDto(
  //       firstname: data['firstname'] as String?,
  //       lastname: data['lastname'] as String?,
  //       email: data['email'] as String?,
  //       phoneNumber: data['phone_number'] as String?,
  //       role: data['role'] as String?,
  //       pseudo: data['pseudo'] as String?,
  //       sex: data['sex'] as String?,
  //       bonusCode: data['bonus_code'] as String?,
  //       birthDate: data['birth_date'] as String?,
  //       notificationId: data['notification_id'] as String?,
  //       latitude: (data['latitude'] as num?)?.toDouble(),
  //       longitude: (data['longitude'] as num?)?.toDouble(),
  //       biography: data['biography'] as String?,
  //       firebaseUuid: data['firebase_uuid'] as String?,
  //       avatar: data['avatar'] as String?,
  //     );

  Map<String, String> toMap() {
    final Map<String, String> data = {};

    addIfNotNull(String key, dynamic value) {
      if (value != null && value != '') {
        data[key] = value.toString();
      }
    }

    addIfNotNull('firstname', firstname);
    addIfNotNull('lastname', lastname);
    addIfNotNull('email', email);
    addIfNotNull('phone_number', phoneNumber);
    addIfNotNull('role', role);
    addIfNotNull('pseudo', pseudo);
    addIfNotNull('sex', sex);
    addIfNotNull('bonus_code', bonusCode);
    addIfNotNull('birth_date', birthDate);
    addIfNotNull('notification_id', notificationId);
    addIfNotNull('latitude', latitude);
    addIfNotNull('longitude', longitude);
    addIfNotNull('biography', biography);
    addIfNotNull('firebase_uuid', firebaseUuid);
    // addIfNotNull('avatar', avatar);

    return data;
  }

  // /// `dart:convert`
  // ///
  // /// Parses the string and returns the resulting Json object as [ProfileDto].
  // factory ProfileDto.fromJson(String data) {
  //   return ProfileDto.fromMap(json.decode(data) as Map<String, dynamic>);
  // }

  /// `dart:convert`
  ///
  /// Converts [ProfileDto] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      firstname,
      lastname,
      email,
      phoneNumber,
      role,
      pseudo,
      sex,
      bonusCode,
      birthDate,
      notificationId,
      latitude,
      longitude,
      biography,
      firebaseUuid,
      avatar,
    ];
  }
}

