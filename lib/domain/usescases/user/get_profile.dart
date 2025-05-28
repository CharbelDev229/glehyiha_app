import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:glehiha/data/models/user/glehiha_current_user.dart';
import 'package:glehiha/data/models/user/glehiha_user_info.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/user_repository.dart';

class GetProfileUseCase implements UseCase<GlehihaCurrentUser, GetProfileParams> {
  final UserRepository repository;

  GetProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, GlehihaCurrentUser>> call(GetProfileParams params) async {
    return await repository.getProfile();
  }
}

class GetProfileParams extends Equatable {
  const GetProfileParams() : super();

  @override
  List<Object> get props => [];
}
