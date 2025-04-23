import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotifModeDto extends Equatable {
  final int? email;
  final int? phone;

  const NotifModeDto({this.email, this.phone});

  factory NotifModeDto.fromMap(Map<String, dynamic> data) => NotifModeDto(
        email: data['email'] == null ? 0 : data['email'] as int,
        phone: data['phone'] == null ? 0 : data['phone'] as int,
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'phone': phone,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotifModeDto].
  factory NotifModeDto.fromJson(String data) {
    return NotifModeDto.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NotifModeDto] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, phone];
}

