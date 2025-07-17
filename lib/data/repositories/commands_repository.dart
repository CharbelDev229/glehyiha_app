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

  /// POST /api/commande/create
  @override
  Future<Either<Failure, String>> commande(CommandsDto dto) async {
    final commande = await commandsRemoteDataSource.commande(dto);
    return commande.fold(
      (failure) {
        return Left(failure);
      },
      (res) {
        return Right(res);
      },
    );
  }

  /// GET /api/commande/list
  @override
  Future<Either<Failure, List<CommandsDto>>> getAllCommande() async {
    final result = await commandsRemoteDataSource.getAllCommande();
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (res) {
        return Right(res);
      },
    );
  }

  /// GET /api/commande/{commande_id}
  @override
  Future<Either<Failure, Map<String, dynamic>>> getCommandeById(String id) async {
    final result = await commandsRemoteDataSource.getCommandeById(id);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (res) {
        return Right(res);
      },
    );
  }

  /// DELETE /api/commande/{commande_id}
  @override
  Future<Either<Failure, String>> deleteCommande(String id) async {
    final result = await commandsRemoteDataSource.deleteCommande(id);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (res) {
        return Right(res);
      },
    );
  }

  /// PUT /api/commande/{commande_id}
  @override
  Future<Either<Failure, String>> updateCommande(String id, CommandsDto dto) async {
    final result = await commandsRemoteDataSource.updateCommande(id, dto);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (res) {
        return Right(res);
      },
    );
  }

  /// PUT /api/commande/{commande_id}/status
  @override
  Future<Either<Failure, String>> updateCommandeStatus(String id, String status) async {
    final result = await commandsRemoteDataSource.updateCommandeStatus(id, status);
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (res) {
        return Right(res);
      },
    );
  }
}
