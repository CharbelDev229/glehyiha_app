import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart'; // Pour FormData et MultipartFile

import '../../../common/dtos/product/add_product_dto.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/uri_formatter.dart';
import '../../../common/constants/instances.dart';
import '../../../common/helpers/request_manager.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, String>> createProduct(AddProductDto dto);
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllProducts();
  Future<Either<Failure, Map<String, dynamic>>> getProductById(String id);
  Future<Either<Failure, String>> deleteProduct(String id);
  Future<Either<Failure, String>> updateProduct(String id, AddProductDto dto);
  Future<Either<Failure, List<Map<String, dynamic>>>> getProductsBySeller(String sellerId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioRequestManager dioRequestManager;

  ProductRemoteDataSourceImpl({required this.dioRequestManager});

  @override
  Future<Either<Failure, String>> createProduct(AddProductDto dto) async {
    final url = UriFormatter('product/create').format();
    final token = prefs.getString('token');

    try {
      final formData = await dto.toFormData();

      final response = await dioRequestManager.sendMultipart(
        'POST',
        url,
        [], // files list - à adapter selon votre DTO
        token: token ?? '',
        fields: {}, // fields - à adapter selon votre DTO
      );

      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getAllProducts() async {
    final url = UriFormatter('product/list').format();
    final token = prefs.getString('token');

    try {
      final response = await dioRequestManager.send(
        'GET',
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.success) {
        final data = response.map['data'];
        if (data is List<dynamic>) {
          final listOfMaps = data.cast<Map<String, dynamic>>();
          return Right(listOfMaps);
        } else {
          return Left(ServerFailure( code: 500,message: "Format des données invalides"));
        }
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductById(String id) async {
    final url = UriFormatter('product/$id').format();
    final token = prefs.getString('token');

    try {
      final response = await dioRequestManager.send(
        'GET',
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.success) {
        final data = response.map['data'];
        if (data is Map<String, dynamic>) {
          return Right(data);
        } else {
          return Left(ServerFailure( code: 500,message: "Format des données invalides"));
        }
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) async {
    final url = UriFormatter('product/$id/delete').format();
    final token = prefs.getString('token');

    try {
      final response = await dioRequestManager.send(
        'DELETE',
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> updateProduct(String id, AddProductDto dto) async {
    final url = UriFormatter('product/$id/update').format();
    final token = prefs.getString('token');

    try {
      final formData = await dto.toFormData();

      final response = await dioRequestManager.sendMultipart(
        'PUT',
        url,
        [], // files list - à adapter selon votre DTO
        token: token ?? '',
        fields: {}, // fields - à adapter selon votre DTO
      );

      if (response.success) {
        return Right(response.message);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getProductsBySeller(String sellerId) async {
    final url = UriFormatter('user/$sellerId/products').format();
    final token = prefs.getString('token');

    try {
      final response = await dioRequestManager.send(
        'GET',
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.success) {
        final data = response.map['data'];
        if (data is List<dynamic>) {
          final listOfMaps = data.cast<Map<String, dynamic>>();
          return Right(listOfMaps);
        } else {
          return Left(ServerFailure( code: 500,message: "Format des données invalides"));
        }
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}
