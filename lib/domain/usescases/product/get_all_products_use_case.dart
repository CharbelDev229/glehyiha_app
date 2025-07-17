import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/product_repository_impl.dart';

class GetAllProductsUseCase implements UseCase<List<Map<String, dynamic>>, NoParams> {
  final ProductRepository repository;

  GetAllProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(NoParams params) async {
    return await repository.getAllProducts();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
