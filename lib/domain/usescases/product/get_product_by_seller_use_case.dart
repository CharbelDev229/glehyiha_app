import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:glehiha/common/utils/usecase.dart';

import '../../../common/utils/failure.dart';
import '../../repositories/product_repository_impl.dart';

class GetProductsByIdSellerUseCase implements UseCase<List<Map<String, dynamic>>, SellerIdParams> {
  final ProductRepository repository;

  GetProductsByIdSellerUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(SellerIdParams params) async {
    return await repository.getProductsBySeller(params.sellerId);
  }
}

class SellerIdParams extends Equatable {
  final String sellerId;

  const SellerIdParams({required this.sellerId});

  @override
  List<Object> get props => [sellerId];
}