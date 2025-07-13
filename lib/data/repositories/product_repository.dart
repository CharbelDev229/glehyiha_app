import 'package:dartz/dartz.dart';
import '../../common/dtos/product/add_product_dto.dart';
import '../../common/utils/failure.dart';
import '../../domain/repositories/product_repository_impl.dart';
import '../data_source/produit/produit_local_data_source.dart';
import '../data_source/produit/produit_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;

  ProductRepositoryImpl({
    required this.productRemoteDataSource,
    required this.productLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> createProduct(AddProductDto dto) async {
    final result = await productRemoteDataSource.createProduct(dto);
    return result.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllProducts() async {
    final result = await productRemoteDataSource.getAllProducts();
    return result.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductById(String id) async {
    final result = await productRemoteDataSource.getProductById(id);
    return result.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) async {
    final result = await productRemoteDataSource.deleteProduct(id);
    return result.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }

  @override
  Future<Either<Failure, String>> updateProduct(String id, AddProductDto dto) async {
    final result = await productRemoteDataSource.updateProduct(id, dto);
    return result.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getProductsBySeller(String sellerId) async {
    final result = await productRemoteDataSource.getProductsBySeller(sellerId);
    return result.fold(
      (failure) => Left(failure),
      (res) => Right(res),
    );
  }
}
