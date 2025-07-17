import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:glehiha/common/utils/usecase.dart';

import '../../../common/utils/failure.dart';
import '../../repositories/commands_repositories.dart';

class GetCommandeByIdUseCase implements UseCase<Map<String, dynamic>, CommandeIdParams> {
  final CommandsRepository repository;

  GetCommandeByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(CommandeIdParams params) async {
    return await repository.getCommandeById(params.commandeId);
  }
}

class CommandeIdParams extends Equatable {
  final String commandeId;

  const CommandeIdParams({required this.commandeId});

  @override
  List<Object> get props => [commandeId];
}
