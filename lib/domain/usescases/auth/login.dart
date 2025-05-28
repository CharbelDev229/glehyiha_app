import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<String, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await repository.login(
      params.phoneNumber,
      params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String phoneNumber;
  final String password;

  const LoginParams({required this.phoneNumber, required this.password});

  @override
  List<Object> get props => [phoneNumber, password];
}
