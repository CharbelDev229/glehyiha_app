import 'package:dartz/dartz.dart';
import '../../../common/constants/instances.dart';
import '../../../common/constants/storage_keys.dart';
import '../../../common/utils/failure.dart';

abstract class AuthLocalDataSource {
  Future<Either<Failure, String>> getToken();
}

class CommandsLocalDataSource implements AuthLocalDataSource {
  CommandsLocalDataSource();

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final tokenP = prefs.getString(StorageKeys.token);

      logger.f('token: $tokenP');

      if (tokenP != null && tokenP.isNotEmpty) {
        return Right(tokenP);
      }

      return Left(
        ServerFailure.onCatch(),
      );
    } catch (e) {
      return Left(
        ServerFailure.onCatch(),
      );
    }
  }
}
