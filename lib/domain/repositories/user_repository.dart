import 'package:dartz/dartz.dart';
import 'package:glehiha/common/dtos/profile_dto/profile_dto.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/data/models/user/glehiha_current_user.dart';
import 'package:glehiha/data/models/user/glehiha_user_info.dart';
import '../../common/dtos/profile_dto/change_pwd_dto.dart';


abstract class UserRepository {
  /// Get user infos
  Future<Either<Failure, GlehihaCurrentUser>> getProfile();

  /// Update user infos
  Future<Either<Failure, String>> updateProfile( ProfileDto dto, 
  String email);

  /// logout user
  Future<Either<Failure, String>> logout();
  // avatar user
   Future<Either<Failure, String>> avatar(String avatarUrl);

  /// Change password
  Future<Either<Failure, String>> changePassword(ChangePwdDto dto,
  );
  /// Delete account
  Future<Either<Failure, String>> deleteAccount({required String password});

 
}
