import 'package:dartz/dartz.dart';

import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/product_repository_impl.dart';
import 'get_product_by_id_use_case.dart';
import 'update_product_params_use_case.dart';

class DeleteProductUseCase implements UseCase<String, ProductIdParams> {
  final ProductRepository repository;

  DeleteProductUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ProductIdParams params) async {
    return await repository.deleteProduct(params.productId);
  }
}

/// UseCase pour mettre à jour un produit
class UpdateProductUseCase implements UseCase<String, UpdateProductParams> {
  final ProductRepository repository;

  UpdateProductUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UpdateProductParams params) async {
    return await repository.updateProduct(params.productId, params.dto);
  }
}
