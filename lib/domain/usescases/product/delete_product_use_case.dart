import 'package:dartz/dartz.dart';

import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/product_repository_impl.dart';
import 'get_product_by_id_use_case.dart';

class DeleteProductUseCase implements UseCase<String, ProductIdParams> {
  final ProductRepository repository;

  DeleteProductUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(ProductIdParams params) async {
    return await repository.deleteProduct(params.productId);
  }
}


