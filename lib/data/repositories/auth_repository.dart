import 'package:glehiha/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../common/dtos/auth/register_dto.dart';
import '../../common/utils/failure.dart';
import '../data_source/auth/auth_local_data_source.dart';
import '../data_source/auth/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> signUp(RegisterDto dto) async {
    final signUp = await authRemoteDataSource.signUp(dto);

    return signUp.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }

  @override
  Future<Either<Failure, String>> login(String phoneNumber, String password) async {
    final login = await authRemoteDataSource.login(phoneNumber, password);

    return login.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }

 

  @override
  Future<Either<Failure, String>> resentCode(String email) async {
    final resentCode = await authRemoteDataSource.resentCode(email);

    return resentCode.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }

  @override
 Future<Either<Failure, String>> userForgotPassword(String email)
 async {
    final userForgotPwd = await authRemoteDataSource.userForgotPassword(email);
    return userForgotPwd.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }

    @override
 Future<Either<Failure, String>> userResetPassword(String email)
 async {
    final userResetPwd = await authRemoteDataSource.userResetPassword(email);
    return userResetPwd.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email)
      async {
    final forgotPwd =
        await authRemoteDataSource.forgotPassword(email);

    return forgotPwd.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }
  @override
  Future<Either<Failure, String>> resetPassword(String email)
      async {
    final resetPwd =
        await authRemoteDataSource.resetPassword(email);

    return resetPwd.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }

  @override
 Future<Either<Failure, String>> verifyUserAccount(String email)
 async {
    final verifyUserAccount = await authRemoteDataSource.verifyUserAccount(email);

    return verifyUserAccount.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }

   @override
Future<Either<Failure, String>> resentVerificationCode(String code)
 async {
    final resentVerificationCode = await authRemoteDataSource.resentVerificationCode(code);

    return resentVerificationCode.fold((failure) async {
      return Left(failure);
    }, (res) async {
      return Right(res);
    });
  }
}
