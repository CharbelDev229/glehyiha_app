import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class ResentVerificationCodeUseCase implements UseCase<String, ResentVerificationCodeParams> {
  final AuthRepository repository;

  ResentVerificationCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ResentVerificationCodeParams params) async {
    return await repository.resentVerificationCode(params.code);
  }
}

class ResentVerificationCodeParams extends Equatable {
  final String code;

  const ResentVerificationCodeParams({required this.code}) : super();

  @override
  List<Object> get props => [code];
}
