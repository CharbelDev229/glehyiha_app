import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:glehiha/common/utils/failure.dart';

import '../../../common/utils/usecase.dart';
import '../../repositories/commands_repositories.dart';

class UpdateCommandeStatusUseCase implements UseCase<String, UpdateCommandeStatusParams> {
  final CommandsRepository repository;

  UpdateCommandeStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UpdateCommandeStatusParams params) async {
    return await repository.updateCommandeStatus(params.commandeId, params.status);
  }
}

class UpdateCommandeStatusParams extends Equatable {
  final String commandeId;
  final String status;

  const UpdateCommandeStatusParams({
    required this.commandeId,
    required this.status,
  });

  @override
  List<Object> get props => [commandeId, status];
}
