
import 'package:dartz/dartz.dart';


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
  Future<Either<Failure, String>> resentVerificationCode(
       String code);

  /// Reinit password
  Future<Either<Failure, String>> userResetPassword(String email);
  Future<Either<Failure, String>> userForgotPassword(String email);
  Future<Either<Failure, String>> verifyUserAccount(String email);
   Future<Either<Failure, String>> resetPassword(String email);
  /// Login to an account
  Future<Either<Failure, String>> login(String phoneNumber, String password);
}
