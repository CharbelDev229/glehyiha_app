import 'package:dartz/dartz.dart';
import 'package:glehiha/data/models/user/glehiha_current_user.dart';
import 'package:mime_type/mime_type.dart';
import '../../../common/constants/instances.dart';
import '../../../common/constants/storage_keys.dart';
import '../../../common/dtos/profile_dto/change_pwd_dto.dart';
import '../../../common/dtos/profile_dto/profile_dto.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/uri_formatter.dart';

abstract class UserRemoteDataSource {
  /// Get user infos
  Future<Either<Failure, GlehihaCurrentUser>> getProfile(String token);

  /// Update user infos
  Future<Either<Failure, String>> updateProfile(
    ProfileDto dto,
    String token,
    String email,
  );

  /// logout user
  Future<Either<Failure, String>> logout(String token);
  
  /// logout user
  Future<Either<Failure, String>> avatar(String token, String avatarUrl);

  /// Change password
  Future<Either<Failure, String>> changePassword(
    ChangePwdDto dto,
    String token,
  );

  /// Ajouter un ami par scan

  /// Delete account
  Future<Either<Failure, String>> deleteAccount({
    required String token,
    required String password,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioRequestManager dioRequestManager;

  UserRemoteDataSourceImpl({required this.dioRequestManager});

  @override
  Future<Either<Failure, GlehihaCurrentUser>> getProfile(String token) async {
    /// URL of the endpoint
    Uri url = UriFormatter('user/me').format();

    try {
      final response = await dioRequestManager.send('GET', url, token: token);
      if (response.success) {
        var user = GlehihaCurrentUser.fromMap(response.map['data']);

        return Right(user);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfile(
    ProfileDto dto,
    String token, 
    String email,
  ) async {
    /// URL of the endpoint
    Uri url = UriFormatter('user/update_profile').format();
    List<FileDetails> files = [];
    final avatar = dto.avatar;
    if (avatar != null) {
      files.add(FileDetails(
        avatar.path, 
        mime(avatar.path) ?? 'image/jpeg'));
    }
    try {
      final response = await dioRequestManager.sendMultipart(
        'POST',
        url,
        files,
        fileField: 'avatar',
        token: token,
        fields: dto.toMap(),
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
  Future<Either<Failure, String>> logout(String token) async {
    /// URL of the endpoint
    Uri url = UriFormatter('auth/logout').format();

    try {
      final response = await dioRequestManager.send('POST', url, token: token);
      if (response.success) {
        prefs.remove(StorageKeys.token);
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
  @override
Future<Either<Failure, String>> avatar(String token, String avatarUrl) async {
  // URL de l'endpoint
  Uri url = UriFormatter('user/avatar').format();

  try {
    // Envoi d'une requête POST avec le token + avatar dans le body
    final response = await dioRequestManager.send(
      'POST',
      url,
      token: token,
    // data: {"avatar": avatarUrl}, // <-- Ajout du body ici
    );

    if (response.success) {
      prefs.remove(StorageKeys.token); 
      return Right(response.message);  
    } else {
      return Left(ServerFailure.raise(response));
    }
  } catch (e) {
    return Left(ServerFailure.onCatch(e: e));
  }
}

  @override
  Future<Either<Failure, String>> changePassword(
    ChangePwdDto dto,
    String token,
  ) async {
    /// URL of the endpoint
    Uri url = UriFormatter('user/change_password').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: dto.toMap(),
        token: token,
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
  Future<Either<Failure, String>> deleteAccount({
    required String token,
    required String password,
  }) async {
    /// URL of the endpoint
    Uri url = UriFormatter('user/delette_my_account').format();

    try {
      final response = await dioRequestManager.send(
        'DELETE',
        url,
        token: token,
        body: {'password': password},
      );
      if (response.success) {
        prefs.clear();
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}
