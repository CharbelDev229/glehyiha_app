import 'package:dartz/dartz.dart';
import 'package:glehiha/common/utils/usecase.dart';
import '../../../common/utils/failure.dart';
import '../../repositories/commands_repositories.dart';

class DeleteCommandeUseCase implements UseCase<String, CommandeIdParams> {
  final CommandsRepository repository;

  DeleteCommandeUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(CommandeIdParams params) async {
    // Correction : conversion en String
    return await repository.deleteCommande(params.commandeId);
  }
}

class CommandeIdParams {
  final String commandeId; // Correction ici : int => String

  CommandeIdParams(this.commandeId);

  @override
  List<Object> get props => [commandeId];
}
