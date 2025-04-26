import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class ForgotPasswordUseCase implements UseCase<String, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ForgotPasswordParams params) async {
    return await repository.forgotPassword(params.email);
  }
}

class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email}) : super();

  @override
  List<Object> get props => [email];
}
