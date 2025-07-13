import 'package:equatable/equatable.dart';

import '../../../common/dtos/product/add_product_dto.dart';

class UpdateProductParams extends Equatable {
  final String productId;
  final AddProductDto dto;

  const UpdateProductParams({required this.productId, required this.dto});

  @override
  List<Object> get props => [productId, dto];
}