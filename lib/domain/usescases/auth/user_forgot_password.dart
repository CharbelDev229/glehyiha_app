import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class UserForgetPasswordUseCase
    implements UseCase<String, UserForgetPasswordParams> {
  final AuthRepository repository;

  UserForgetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UserForgetPasswordParams params) async {
    return await repository.userForgotPassword(params.email);
  }
}

class UserForgetPasswordParams extends Equatable {
  final String email;

  const UserForgetPasswordParams({
    required this.email,
  }) : super();

  @override
  List<Object> get props => [email];
}
