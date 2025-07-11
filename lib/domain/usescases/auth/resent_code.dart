import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/auth_repository.dart';

class ResentCodeUseCase implements UseCase<String, ResentCodeParams> {
  final AuthRepository repository;

  ResentCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ResentCodeParams params) async {
    return await repository.resentCode(params.email);
  }
}

class ResentCodeParams extends Equatable {
  final String email;

  const ResentCodeParams({required this.email}) : super();

  @override
  List<Object> get props => [email];
}
