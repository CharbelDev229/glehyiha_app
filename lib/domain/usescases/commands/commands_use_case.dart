
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../common/dtos/commands/commands_dto.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/commands_repositories.dart';

class CommandsUseCase implements UseCase<String, CommandsParams> {
  final CommandsRepository repository;

  CommandsUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(CommandsParams params) async {
    return await repository.commande(params.dto);
  }
}

class CommandsParams extends Equatable {
  final CommandsDto dto;

  const CommandsParams({
    required this.dto,
   
  }) : super();

  @override
  List<Object> get props => [dto];
}
