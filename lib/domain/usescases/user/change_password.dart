import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/dtos/profile_dto/change_pwd_dto.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/user_repository.dart';

class ChangePasswordUseCase implements UseCase<String, ChangePasswordParams> {
  final UserRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ChangePasswordParams params) async {
    return await repository.changePassword(params.newPwdDto);
  }
}

class ChangePasswordParams extends Equatable {
  final ChangePwdDto newPwdDto;
  const ChangePasswordParams({required this.newPwdDto}) : super();

  @override
  List<Object> get props => [newPwdDto];
}
