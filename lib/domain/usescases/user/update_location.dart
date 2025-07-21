import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/user_repository.dart';

class UpdateLocationUseCase implements UseCase<String, UpdateLocationParams> {
  final UserRepository repository;

  UpdateLocationUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UpdateLocationParams params) async {
    return await repository.updateLocation(
      params.latitude,
      params.longitude,
    );
  }
}

class UpdateLocationParams extends Equatable {
  final double latitude;
  final double longitude;

  const UpdateLocationParams({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}