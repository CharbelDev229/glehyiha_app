import 'package:dartz/dartz.dart';
import 'package:glehiha/data/models/user/glehiha_user_info.dart';
import '../../../common/constants/instances.dart';
import '../../../common/dtos/auth/register_dto.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/uri_formatter.dart';

abstract class AuthRemoteDataSource {
  /// Register to an account

  Future<Either<Failure, String>> signUp(RegisterDto dto);
  Future<Either<Failure, String>> userForgotPassword(String email);

  Future<Either<Failure, String>> resentVerificationCode(String email);
  Future<Either<Failure, String>> resetPassword(String new_password, String reset_code);
  Future<Either<Failure, String>> userResetPassword(String email);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, String>> verifyUserAccount(
    String verification_code,
    String email,
  );

  /// Check if user exist
  Future<Either<Failure, String>> resentCode(String email);

  /// Login to an account
  Future<Either<Failure, String>> login(String phoneNumber, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioRequestManager dioRequestManager;

  AuthRemoteDataSourceImpl({required this.dioRequestManager});

  @override
  Future<Either<Failure, String>> login(
    String phoneNumber,
    String password,
  ) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/login').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {'phone_number': phoneNumber, 'password': password},
      );

      if (response.success) {
       prefs.setString('token', response.map['data']['access_token']);
      

        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> signUp(RegisterDto dto) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/signup').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: dto.toMap(),
      );
      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> resentCode(String email) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/resent_user_verification_link').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {"email": email},
      );
      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> userForgotPassword(String email) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/user_forgot_password').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {"email": email},
      );
      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/forgot_password').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {"email": email},
      );
      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> resentVerificationCode(String email) async {
    Uri url = UriFormatter('auth/resent_verification_code').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {"email": email},
      );
    
      if (response.success) {
       return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(String new_password, String reset_code) async {
    /// URL of the endpoint 
    Uri url = UriFormatter('auth/reset_password').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {"new_password": new_password, "reset_code": reset_code},
      );
      if (response.success) {
       return Right(response.message);

      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> verifyUserAccount(
    String verification_code,
    String email,
  ) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/verify_user_account').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {"verification_code": verification_code, "email": email},
      );
      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> userResetPassword(String email) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/user_reset_password').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: {"email": email},
      );
      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}
