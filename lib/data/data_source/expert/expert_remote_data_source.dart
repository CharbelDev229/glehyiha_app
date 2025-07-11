import 'package:dartz/dartz.dart';
import '../../../common/utils/failure.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/uri_formatter.dart';
import '../../models/expert/expert_model.dart';

abstract class ExpertRemoteDataSource {
  Future<Either<Failure, ExpertResponse>> fetchExpertsProches({
    int? page,
    int? pageSize,
    String? sortBy,
    String? order,
    Map<String, dynamic>? additionalParams,
  });
}

class ExpertRemoteDataSourceImpl implements ExpertRemoteDataSource {
  final DioRequestManager dioRequestManager;

  ExpertRemoteDataSourceImpl({required this.dioRequestManager});

  @override
  Future<Either<Failure, ExpertResponse>> fetchExpertsProches({
    int? page,
    int? pageSize,
    String? sortBy,
    String? order,
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final controls = <String, dynamic>{
        if (page != null) 'page': page,
        if (pageSize != null) 'pageSize': pageSize,
        if (sortBy != null) 'sortBy': sortBy,
        if (order != null) 'order': order,
      };

      final extras = additionalParams ?? {};

      final uri = UriFormatter(
        'user/experts-proches',
        extras: {...controls, ...extras},
      ).format();

      final response = await dioRequestManager.send('GET', uri);

      if (response.success && response.data is Map<String, dynamic>) {
        return Right(ExpertResponse.fromJson(response.data));
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}