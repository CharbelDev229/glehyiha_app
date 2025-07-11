import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<String, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      params.new_password,
      params.reset_code,
    );
  }
}

class ResetPasswordParams extends Equatable {
  final String new_password;
  final String reset_code;

  const ResetPasswordParams({required this.new_password, required this.reset_code}) : super();

  @override
  List<Object> get props => [new_password, reset_code];
}
