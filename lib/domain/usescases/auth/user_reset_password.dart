import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class UserResetPasswordUseCase implements UseCase<String, UserResetPasswordParams> {
  final AuthRepository repository;

  UserResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UserResetPasswordParams params) async {
    return await repository.userResetPassword(params.email);
  }
}

class UserResetPasswordParams extends Equatable {
  final String email;

  const UserResetPasswordParams({required this.email}) : super();

  @override
  List<Object> get props => [email];
}
