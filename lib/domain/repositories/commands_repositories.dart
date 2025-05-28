import 'package:dartz/dartz.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import '../../common/utils/failure.dart';

abstract class CommandsRepository{
 
  Future<Either<Failure, String>> commande(CommandsDto dto);

}
