import 'package:dartz/dartz.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import '../../common/utils/failure.dart';

abstract class CommandsRepository {
  /// POST /api/commande/create
  Future<Either<Failure, String>> commande(CommandsDto dto);

  /// GET /api/commande/list
  Future<Either<Failure, List<CommandsDto>>> getAllCommande();

  /// GET /api/commande/{commande_id}
  Future<Either<Failure, Map<String, dynamic>>> getCommandeById(String id);

  /// DELETE /api/commande/{commande_id}
  Future<Either<Failure, String>> deleteCommande(String id);

  /// PUT /api/commande/{commande_id}
  Future<Either<Failure, String>> updateCommande(String id, CommandsDto dto);

  /// PUT /api/commande/{commande_id}/status
  Future<Either<Failure, String>> updateCommandeStatus(String id, String status);
}
