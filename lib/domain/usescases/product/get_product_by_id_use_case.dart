import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/product_repository_impl.dart';

class GetProductByIdUseCase implements UseCase<Map<String, dynamic>, ProductIdParams> {
  final ProductRepository repository;

  GetProductByIdUseCase({required this.repository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(ProductIdParams params) async {
    return await repository.getProductById(params.productId);
  }
}

class ProductIdParams extends Equatable {
  final String productId;

  const ProductIdParams({required this.productId});

  @override
  List<Object> get props => [productId];
}