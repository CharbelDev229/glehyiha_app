

import 'package:dartz/dartz.dart';

import '../../common/dtos/product/add_product_dto.dart';
import '../../common/utils/failure.dart';
abstract class ProductRepository {
  Future<Either<Failure, String>> createProduct(AddProductDto dto);
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllProducts();
  Future<Either<Failure, Map<String, dynamic>>> getProductById(String id);
  Future<Either<Failure, String>> deleteProduct(String id);
  Future<Either<Failure, String>> updateProduct(String id, AddProductDto dto);
  Future<Either<Failure, List<Map<String, dynamic>>>> getProductsBySeller(String sellerId);
}
