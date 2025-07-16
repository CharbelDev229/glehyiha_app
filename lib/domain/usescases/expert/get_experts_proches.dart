import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/common/utils/usecase.dart';
import 'package:glehiha/data/models/expert/expert_model.dart';
import 'package:glehiha/data/repositories/expert_repository.dart';

class GetExpertsProchesParams extends Equatable {
  final double latitude;
  final double longitude;

  const GetExpertsProchesParams({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}

class GetExpertsProchesUseCase implements UseCase<ExpertResponse, GetExpertsProchesParams> {
  final ExpertRepository repository;

  GetExpertsProchesUseCase({required this.repository});

  @override
  Future<Either<Failure, ExpertResponse>> call(GetExpertsProchesParams params) async {
    return await repository.getExpertsProches(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
} 
