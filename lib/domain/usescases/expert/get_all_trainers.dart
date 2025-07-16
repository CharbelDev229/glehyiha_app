import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/common/utils/usecase.dart';
import 'package:glehiha/data/models/expert/expert_pagination_model.dart';
import 'package:glehiha/data/repositories/expert_repository.dart';

class GetAllTrainersUseCase implements UseCase<AllTrainersResponse, GetAllTrainersParams> {
  final ExpertRepository repository;

  GetAllTrainersUseCase({required this.repository});

  @override
  Future<Either<Failure, AllTrainersResponse>> call(GetAllTrainersParams params) async {
    return await repository.getAllTrainers(
      page: params.page,
      perPage: params.perPage,
    );
  }
}

class GetAllTrainersParams extends Equatable {
  final int page;
  final int perPage;

  const GetAllTrainersParams({
    this.page = 1,
    this.perPage = 10,
  });

  @override
  List<Object> get props => [page, perPage];
} 