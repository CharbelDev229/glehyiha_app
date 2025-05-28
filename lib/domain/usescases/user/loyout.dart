import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/user_repository.dart';


class LogoutUseCase implements UseCase<String, LogoutParams> {
  final UserRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(LogoutParams params) async {
    return await repository.logout();
  }
}

class LogoutParams extends Equatable {
  const LogoutParams() : super();

  @override
  List<Object> get props => [];
}
