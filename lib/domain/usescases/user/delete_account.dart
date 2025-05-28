import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/user_repository.dart';


class DeleteAccountUseCase implements UseCase<String, DeleteAccountParams> {
  final UserRepository repository;

  DeleteAccountUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(DeleteAccountParams params) async {
    return await repository.deleteAccount(password: params.password);
  }
}

class DeleteAccountParams extends Equatable {
  const DeleteAccountParams({required this.password}) : super();
  final String password;

  @override
  List<Object> get props => [];
}
