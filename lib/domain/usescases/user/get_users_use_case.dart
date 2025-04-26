import 'package:glehiha/data/data_models/get_users_data.dart';
import 'package:glehiha/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';

class GetUsersUseCase implements UseCase<GetUsersData, GetUsersParams> {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  @override
  Future<Either<Failure, GetUsersData>> call(GetUsersParams params) async {
    return await repository.getUsers(page:  params.page, search: params.search);
  }
}

class GetUsersParams extends Equatable {
  final int page;
  final String? search;

  const GetUsersParams({required this.page, this.search});

  @override
  List<Object> get props => [page,];
}