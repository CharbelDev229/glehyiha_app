import 'package:dartz/dartz.dart';
import 'package:glehiha/common/constants/instances.dart';

import '../../../common/constants/storage_keys.dart';
import '../../../common/utils/failure.dart';

abstract class CommandsLocalDataSource {
  Future<Either<Failure, String>> getToken();
}

class CommandsLocalDataSourceImpl implements CommandsLocalDataSource {
  CommandsLocalDataSourceImpl();

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final tokenP = prefs.getString(StorageKeys.token);

      logger.f('token: $tokenP');

      if (tokenP != null && tokenP.isNotEmpty) {
        return Right(tokenP);
      }

      return Left(ServerFailure.onCatch());
    } catch (e) {
      return Left(ServerFailure.onCatch());
    }
  }
}
