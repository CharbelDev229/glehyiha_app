// lib/data/models/auth/login_response_dto.dart

import 'package:glehiha/data/models/user/glehiha_user_info.dart';

class LoginResponseDto {
  final String accessToken;
  final GlehihaUserInfo user;

  LoginResponseDto({
    required this.accessToken,
    required this.user,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      accessToken: json['data']['access_token'],
      user: GlehihaUserInfo.fromJson(json['data']['user']),
    );
  }
}
