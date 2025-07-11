import 'package:dartz/dartz.dart';
import '../../../common/utils/failure.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/uri_formatter.dart';
import '../../../common/constants/instances.dart';
import '../../../common/constants/storage_keys.dart';
import '../../models/expert/expert_model.dart';

abstract class ExpertRemoteDataSource {
  Future<Either<Failure, ExpertResponse>> fetchExpertsProches({
    Map<String, dynamic>? additionalParams,
  });
  
  Future<Either<Failure, TrainerResponse>> fetchAllTrainers({
    int? page,
    int? perPage,
    Map<String, dynamic>? additionalParams,
  });
}

class ExpertRemoteDataSourceImpl implements ExpertRemoteDataSource {
  final DioRequestManager dioRequestManager;

  ExpertRemoteDataSourceImpl({required this.dioRequestManager});

  // Méthode pour récupérer le token
  String _getToken() {
    return prefs.getString(StorageKeys.token) ?? '';
  }

  @override
  Future<Either<Failure, ExpertResponse>> fetchExpertsProches({
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final extras = additionalParams ?? {};
      final token = _getToken();

      final uri = UriFormatter(
        'user/experts-proches',
        extras: extras,
      ).format();

      final response = await dioRequestManager.send('GET', uri, token: token);

      if (response.success && response.data is Map<String, dynamic>) {
        return Right(ExpertResponse.fromJson(response.data));
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, TrainerResponse>> fetchAllTrainers({
    int? page,
    int? perPage,
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final controls = <String, dynamic>{
        if (page != null) 'page': page,
        if (perPage != null) 'per_page': perPage,
      };

      final extras = additionalParams ?? {};
      final token = _getToken();

      final uri = UriFormatter(
        'user/get_all_trainers',
        extras: {...controls, ...extras},
      ).format();

      final response = await dioRequestManager.send('GET', uri, token: token);

      if (response.success && response.data is Map<String, dynamic>) {
        return Right(TrainerResponse.fromJson(response.data));
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}

