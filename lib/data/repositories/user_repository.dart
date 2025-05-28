import 'package:dartz/dartz.dart';
import 'package:glehiha/common/dtos/profile_dto/profile_dto.dart';
import 'package:glehiha/data/models/user/glehiha_current_user.dart';
import 'package:glehiha/data/models/user/glehiha_user_info.dart';
import '../../common/dtos/profile_dto/change_pwd_dto.dart';
import '../../common/utils/failure.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_source/auth/auth_local_data_source.dart';
import '../data_source/profile/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, GlehihaCurrentUser>> getProfile() async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold((failure) {
      return Left(failure);
    }, (accessToken) async {
      final remoteUser = await userRemoteDataSource.getProfile(accessToken);

      return remoteUser.fold((failure) async {
        return Left(failure);
      }, (user) async {
        return Right(user);
      });
    });
  }

  @override
  Future<Either<Failure, String>> changePassword(ChangePwdDto dto) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold((failure) {
      return Left(failure);
    }, (accessToken) async {
      final remoteChangePwd = await userRemoteDataSource.changePassword(
        dto,
        accessToken,
      );

      return remoteChangePwd.fold((failure) async {
        return Left(failure);
      }, (res) async {
        return Right(res);
      });
    });
  }

  @override
  Future<Either<Failure, String>> deleteAccount({required String password}) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold((failure) {
      return Left(failure);
    }, (accessToken) async {
      final remoteDeleteAccount = await userRemoteDataSource.deleteAccount(
        token: accessToken,
        password: password
      );

      return remoteDeleteAccount.fold((failure) async {
        return Left(failure);
      }, (res) async {
        return Right(res);
      });
    });
  }

  @override
  Future<Either<Failure, String>> logout() async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold((failure) {
      return Left(failure);
    }, (accessToken) async {
      final remoteLogout = await userRemoteDataSource.logout(
        accessToken,
      );

      return remoteLogout.fold((failure) async {
        return Left(failure);
      }, (res) async {
        return Right(res);
      });
    });
  }

   @override
   Future<Either<Failure, String>> updateProfile(ProfileDto dto, String email) async {
   final accessToken = await authLocalDataSource.getToken();

     return accessToken.fold((failure) {
       return Left(failure);
     }, (accessToken) async {
       final remoteUpdate = await userRemoteDataSource.updateProfile(
         dto,
         accessToken,
         email,
       );

       return remoteUpdate.fold((failure) async {
         return Left(failure);
       }, (res) async {
         return Right(res);
       });
     });
   }

 
  }

