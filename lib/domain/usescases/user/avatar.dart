import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/user_repository.dart';

class AvatarUseCase implements UseCase<String, AvatarParams> {
  final UserRepository repository;

  AvatarUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(AvatarParams params) async {
    return await repository.avatar(params.avatarUrl);
  }
}

class AvatarParams extends Equatable {
  final String avatarUrl;

  const AvatarParams(this.avatarUrl);

  @override
  List<Object> get props => [avatarUrl];
}
