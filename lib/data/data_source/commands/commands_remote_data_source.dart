import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/common/utils/uri_formatter.dart';
import '../../../common/constants/instances.dart';
import '../../../common/helpers/request_manager.dart';

abstract class CommandsRemoteDataSource {
  Future<Either<Failure, String>> commande(CommandsDto dto);
  Future<Either<Failure, List<CommandsDto>>> getAllCommande();
  Future<Either<Failure, Map<String, dynamic>>> getCommandeById(String id);
  Future<Either<Failure, String>> deleteCommande(String id);
  Future<Either<Failure, String>> updateCommande(String id, CommandsDto dto);
  Future<Either<Failure, String>> updateCommandeStatus(
    String id,
    String status,
  );
}

class CommandsRemoteDataSourceImpl implements CommandsRemoteDataSource {
  final DioRequestManager dioRequestManager;

  CommandsRemoteDataSourceImpl({required this.dioRequestManager});

  @override
  Future<Either<Failure, String>> commande(CommandsDto dto) async {
    Uri url = UriFormatter('commande/create').format();
    final token = prefs.getString('token');

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: dto.toMap(),
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
Future<Either<Failure, List<CommandsDto>>> getAllCommande() async {
  Uri url = UriFormatter('commande/list').format();
  final token = prefs.getString('token');

  try {
    final response = await dioRequestManager.send(
      'GET',
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.success) {
      // Fix: Convert raw data to CommandsDto objects
      final List<dynamic> rawData = response.map['data'] as List<dynamic>;
      final List<CommandsDto> commands = rawData
          .map((item) => CommandsDto.fromMap(item as Map<String, dynamic>))
          .toList();
      return Right(commands);
    } else {
      return Left(ServerFailure.raise(response));
    }
  } catch (e) {
    return Left(ServerFailure.onCatch(e: e));
  }
}
  
@override
Future<Either<Failure, Map<String, dynamic>>> getCommandeById(String id) async {
  // Fix: Add ID parameter substitution
  Uri url = UriFormatter('commande/{commande_id}').format();
  final token = prefs.getString('token');

  try {
    final response = await dioRequestManager.send(
      'GET',
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.success) {
      return Right(response.map['data'] as Map<String, dynamic>);
    } else {
      return Left(ServerFailure.raise(response));
    }
  } catch (e) {
    return Left(ServerFailure.onCatch(e: e));
  }
}
 

  @override
  Future<Either<Failure, String>> deleteCommande(String id) async {
    Uri url = UriFormatter('commande/{commande_id}').format();
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
  Future<Either<Failure, String>> updateCommande(
    String id,
    CommandsDto dto,
  ) async {
    Uri url = UriFormatter('commande/{commande_id}').format();
    final token = prefs.getString('token');

    try {
      final response = await dioRequestManager.send(
        'PUT',
        url,
        body: dto.toMap(),
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
  Future<Either<Failure, String>> updateCommandeStatus(
    String id,
    String status,
  ) async {
    Uri url = UriFormatter('commande/{commande_id}/status').format();
    final token = prefs.getString('token');

    try {
      final response = await dioRequestManager.send(
        'PUT',
        url,
        body: {'status': status},
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
}
