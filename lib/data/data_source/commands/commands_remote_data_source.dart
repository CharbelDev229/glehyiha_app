

import 'package:dartz/dartz.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/common/utils/uri_formatter.dart';

import '../../../common/constants/instances.dart';
import '../../../common/helpers/request_manager.dart';

abstract class CommandsRemoteDataSource {
  
  Future<Either<Failure, String>> commande(CommandsDto dto);
}

class CommandsRemoteDataSourceImpl implements CommandsRemoteDataSource {
   final DioRequestManager dioRequestManager;

  CommandsRemoteDataSourceImpl({required this.dioRequestManager});

  @override
  Future<Either<Failure, String>> commande(
   CommandsDto dto
  ) async {
    /// URL of the endpoint
    Uri url = UriFormatter('commande/create').format();

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: dto.toMap(),
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

  
  
  }

