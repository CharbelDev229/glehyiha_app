import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class VerifyUserAccountUseCase
    implements UseCase<String, VerifyUserAccountParams> {
  final AuthRepository repository;

  VerifyUserAccountUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(VerifyUserAccountParams params) async {
    return await repository.verifyUserAccount(params.verification_code, params.email);
  }
}

class VerifyUserAccountParams extends Equatable {
  final String verification_code;
  final String email;

  const VerifyUserAccountParams({required this.verification_code, required this.email}) : super();

  @override
  List<Object> get props => [verification_code,email];
}
