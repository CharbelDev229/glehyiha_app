import 'package:dartz/dartz.dart';
import '../../common/utils/failure.dart';
import '../data_source/expert/expert_remote_data_source.dart';
import '../../data/models/expert/expert_model.dart';
import 'package:glehiha/data/models/expert/expert_pagination_model.dart';

abstract class ExpertRepository {
  Future<Either<Failure, ExpertResponse>> getExpertsProches({
    required double latitude,
    required double longitude,
  });
  Future<Either<Failure, AllTrainersResponse>> getAllTrainers({
    int page = 1,
    int perPage = 10,
  });
}

class ExpertRepositoryImpl implements ExpertRepository {
  final ExpertRemoteDataSource expertRemoteDataSource;

  ExpertRepositoryImpl({required this.expertRemoteDataSource});

  @override
  Future<Either<Failure, ExpertResponse>> getExpertsProches({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final result = await expertRemoteDataSource.getExpertsProches(
        latitude: latitude,
        longitude: longitude,
      );
      return result.fold(
        (failure) => Left(failure),
        (response) => Right(response),
      );
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, AllTrainersResponse>> getAllTrainers({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final result = await expertRemoteDataSource.getAllTrainers(
        page: page,
        perPage: perPage,
      );
      return result.fold(
        (failure) => Left(failure),
        (response) => Right(response),
      );
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}