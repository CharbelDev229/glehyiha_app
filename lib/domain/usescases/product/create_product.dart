import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../common/dtos/product/add_product_dto.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/product_repository_impl.dart';

class CreateProductUseCase implements UseCase<String, CreateProductParams> {
  final ProductRepository repository;

  CreateProductUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(CreateProductParams params) async {
    return await repository.createProduct(params.dto);
  }
}

class CreateProductParams extends Equatable {
  final AddProductDto dto;

  const CreateProductParams({required this.dto});

  @override
  List<Object> get props => [dto];
}