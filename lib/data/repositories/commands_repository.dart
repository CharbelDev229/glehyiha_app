import 'package:dartz/dartz.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import 'package:glehiha/domain/repositories/commands_repositories.dart';

import '../../common/utils/failure.dart';
import '../data_source/commands/commands_local_data_source.dart';
import '../data_source/commands/commands_remote_data_source.dart';

class CommandsRepositoryImpl implements CommandsRepository {
  final CommandsRemoteDataSource commandsRemoteDataSource;
  final CommandsLocalDataSource commandsLocalDataSource;

  CommandsRepositoryImpl({
    required this.commandsRemoteDataSource,
    required this.commandsLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> commande(CommandsDto dto) async {
    final commande = await commandsRemoteDataSource.commande(dto);
    return commande.fold(
      (failure) async {
        return Left(failure);
      },
      (res) async {
        return Right(res);
      },
    );
  }
}
