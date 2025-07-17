import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../common/dtos/commands/commands_dto.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/commands_repositories.dart';

class UpdateCommandeUseCase implements UseCase<String, UpdateCommandeParams> {
  final CommandsRepository repository;

  UpdateCommandeUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UpdateCommandeParams params) async {
    return await repository.updateCommande(params.commandeId, params.dto);
  }
}

class UpdateCommandeParams extends Equatable {
  final String commandeId;
  final CommandsDto dto;

  UpdateCommandeParams({
    required this.commandeId,
    required this.dto,
  });

  @override
  List<Object> get props => [commandeId, dto];
}
