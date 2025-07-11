import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/dtos/auth/register_dto.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class SignUpUseCase
    implements UseCase<String, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(SignUpParams params) async {
    return await repository.signUp(params.dto);
  }
}

class SignUpParams extends Equatable {
  final RegisterDto dto;

  const SignUpParams({
    required this.dto,
  }) : super();

  @override
  List<Object> get props => [dto];
}
