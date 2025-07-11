
import 'package:dartz/dartz.dart';
import 'package:glehiha/data/models/user/glehiha_user_info.dart';


import '../../common/dtos/auth/register_dto.dart';
import '../../common/utils/failure.dart';

abstract class AuthRepository {
  /// Register to an account
  Future<Either<Failure, String>> signUp(RegisterDto dto);
  /// Check if user exist
  Future<Either<Failure, String>> resentCode(String email);

  /// Reinit password request
  Future<Either<Failure, String>> forgotPassword(String email);

  /// VerifyCode password request
  Future<Either<Failure, String>> resentVerificationCode(String email) 
          ;

  /// Reinit password
  Future<Either<Failure, String>> userResetPassword(String email);
  Future<Either<Failure, String>> userForgotPassword(String email);
  Future<Either<Failure, String>> verifyUserAccount(String verification_code, String email);
   Future<Either<Failure, String>> resetPassword(String new_password, String reset_code);
  /// Login to an account
  Future<Either<Failure, String>> login(String phoneNumber, String password);
}
