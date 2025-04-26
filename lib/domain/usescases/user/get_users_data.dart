

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../../data/models/user/glehiha_user_info.dart';
import '../../repositories/user_repository.dart';

class GetUsersDataUseCase implements UseCase<GlehihaUserInfo, GetUsersDataParams> {
  final UserRepository repository;

  GetUsersDataUseCase({required this.repository});

  @override
  Future<Either<Failure, GlehihaUserInfo>> call(GetUsersDataParams params) async {
    return await repository.getUsersdata(userId:params.userId );
  }
}

class GetUsersDataParams extends Equatable {
  
  final int userId;

  const GetUsersDataParams({required this.userId});

  @override
  List<Object> get props => [userId];
}