import 'package:dartz/dartz.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import 'package:glehiha/domain/repositories/commands_repositories.dart';

class GetAllCommandesUseCase {
  final CommandsRepository repository;

  GetAllCommandesUseCase({required this.repository});

  Future<Either<Failure, List<CommandsDto>>> call() async {
    return await repository.getAllCommande();
  }
}
