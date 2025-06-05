import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:glehiha/common/dtos/profile_dto/profile_dto.dart';
import 'package:glehiha/domain/repositories/user_repository.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';

class UpdateProfileUseCase implements UseCase<String, UpdateProfileParams> {
  final UserRepository repository;

  UpdateProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(
      params.profileDto,
      params.email,
      
    );
  }
}

class UpdateProfileParams extends Equatable {
  final ProfileDto profileDto;
  final String email;
  const UpdateProfileParams({required this.profileDto, required this.email})
    : super();

  @override
  List<Object> get props => [profileDto];
}
