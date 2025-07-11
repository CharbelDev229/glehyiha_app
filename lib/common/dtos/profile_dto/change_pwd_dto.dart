import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChangePwdDto extends Equatable {
  final String oldPassword;
  final String newPassword;

  const ChangePwdDto({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePwdDto.fromMap(Map<String, dynamic> data) => ChangePwdDto(
        oldPassword: data['old_password'] as String,
        newPassword: data['new_password'] as String,
      );

  Map<String, dynamic> toMap() => {
        'old_password': oldPassword,
        'new_password': newPassword,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChangePwdDto].
  factory ChangePwdDto.fromJson(String data) {
    return ChangePwdDto.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChangePwdDto] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
