import 'dart:convert';

import 'package:equatable/equatable.dart';

class PwdReInitDto extends Equatable {
  final String email;
  final String password;
  final String passwordConfirmation;
  final int code;

  const PwdReInitDto({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.code,
  });

  factory PwdReInitDto.fromMap(Map<String, dynamic> data) => PwdReInitDto(
        email: data['email'] as String,
        password: data['password'] as String,
        passwordConfirmation: data['password_confirmation'] as String,
        code: data['code'] as int,
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'code': code,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PwdReInitDto].
  factory PwdReInitDto.fromJson(String data) {
    return PwdReInitDto.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PwdReInitDto] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      email,
      password,
      passwordConfirmation,
      code,
    ];
  }
}

