import 'package:dartz/dartz.dart';
import '../../common/utils/failure.dart';
import '../data_source/expert/expert_remote_data_source.dart';
import '../../data/models/expert/expert_model.dart';

abstract class ExpertRepository {
  Future<Either<Failure, ExpertResponse>> fetchExpertsProches({
    int? page,
    int? pageSize,
    String? sortBy,
    String? order,
    Map<String, dynamic>? additionalParams,
  });
}

class ExpertRepositoryImpl implements ExpertRepository {
  final ExpertRemoteDataSource expertRemoteDataSource;

  ExpertRepositoryImpl({required this.expertRemoteDataSource});

  @override
  Future<Either<Failure, ExpertResponse>> fetchExpertsProches({
    int? page,
    int? pageSize,
    String? sortBy,
    String? order,
    Map<String, dynamic>? additionalParams,
  }) async {
    final result = await expertRemoteDataSource.fetchExpertsProches(
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      order: order,
      additionalParams: additionalParams,
    );

    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }
}