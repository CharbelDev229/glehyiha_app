import 'package:dartz/dartz.dart';
import 'package:glehiha/data/models/expert/expert_pagination_model.dart';
import '../../../common/utils/failure.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/uri_formatter.dart';
import '../../models/expert/expert_model.dart';
import 'package:glehiha/common/constants/instances.dart';

abstract class ExpertRemoteDataSource {
  Future<Either<Failure, ExpertResponse>> getExpertsProches({
    required double latitude,
    required double longitude,
  });
  Future<Either<Failure, AllTrainersResponse>> getAllTrainers({
    int page = 1,
    int perPage = 10,
  });
}

class ExpertRemoteDataSourceImpl implements ExpertRemoteDataSource {
  final DioRequestManager dioRequestManager;

  ExpertRemoteDataSourceImpl({required this.dioRequestManager});

  String _getToken() {
    return prefs.getString('token') ?? '';
  }

  @override
  Future<Either<Failure, ExpertResponse>> getExpertsProches({
    required double latitude,
    required double longitude,
  }) async {
    Uri url = UriFormatter('user/experts-proches').format().replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      },
    );
    final token = _getToken();

    try {
      final response = await dioRequestManager.send(
        'GET',
        url,
        token: token,
      );

      if (response.success) {
        final expertResponse = ExpertResponse.fromJson(response.map);
        return Right(expertResponse);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, AllTrainersResponse>> getAllTrainers({
    int page = 1,
    int perPage = 10,
  }) async {
    Uri url = UriFormatter('user/get_all_trainers').format().replace(
      queryParameters: {
        'page': page.toString(),
        'per_page': perPage.toString(),
      },
    );
    final token = _getToken();

    try {
      final response = await dioRequestManager.send(
        'GET', 
        url,
        token: token,
      );

      if (response.success) {
        final allTrainersResponse = AllTrainersResponse.fromJson(response.map);
        return Right(allTrainersResponse);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}