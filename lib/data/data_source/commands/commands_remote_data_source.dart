import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/common/utils/uri_formatter.dart';
import 'package:glehiha/data/data_source/commands/commands_local_data_source.dart';

import '../../../common/constants/instances.dart';
import '../../../common/helpers/request_manager.dart';

abstract class CommandsRemoteDataSource {
  Future<Either<Failure, String>> commande(CommandsDto dto);
  Future<Either<Failure, List<CommandsDto>>> getAllCommande();
  Future<Either<Failure, Map<String, dynamic>>> getCommandeById(String id);
  Future<Either<Failure, String>> deleteCommande(String id);
  Future<Either<Failure, String>> updateCommande(String id, CommandsDto dto);
  Future<Either<Failure, String>> updateCommandeStatus(String id, String status);
}

class CommandsRemoteDataSourceImpl implements CommandsRemoteDataSource {
  final DioRequestManager dioRequestManager;

  CommandsRemoteDataSourceImpl({required this.dioRequestManager, required CommandsLocalDataSource localDataSource});

  @override
  Future<Either<Failure, String>> commande(CommandsDto dto) async {
    Uri url = UriFormatter('commande/create').format();

    try {
      // ✅ Récupérer le token directement depuis prefs comme dans auth
      final token = prefs.getString('token');
      
      if (token == null || token.isEmpty) {
        return Left(ServerFailure(
          code: 401,
          message: "Token non trouvé. Veuillez vous reconnecter.",
        ));
      }

      final response = await dioRequestManager.send(
        'POST',
        url,
        body: dto.toMap(),
        token: token,
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

    if (token == null || token.isEmpty) {
      return Left(ServerFailure(
        code: 401,
        message: "Token non trouvé. Veuillez vous reconnecter.",
      ));
    }

    try {
      print('🔑 Token utilisé: ${token.substring(0, 20)}...');
      
      final response = await dioRequestManager.send(
        'GET',
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      
      print('📡 Réponse serveur: ${response.statusCode}');
      print('📄 Corps réponse: ${response.body}');

      if (response.success) {
        // ✅ Gérer les deux formats de réponse
        dynamic rawData = response.map['data'];
        
        List<dynamic> commandsList;
        if (rawData is List) {
          // Format direct: data est une liste
          commandsList = rawData;
        } else if (rawData is Map && rawData.containsKey('items')) {
          // Format paginé: data.items est une liste
          commandsList = rawData['items'] as List<dynamic>;
        } else {
          // Fallback: essayer de traiter comme liste
          commandsList = rawData as List<dynamic>;
        }
        
        final List<CommandsDto> commands = commandsList
            .map((item) => CommandsDto.fromMap(item as Map<String, dynamic>))
            .toList();
        return Right(commands);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      print('❌ Exception dans getAllCommande: $e');
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCommandeById(String id) async {
    // ✅ Remplace l'id dans l'URL
    Uri url = UriFormatter('commande/$id').format();
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
    Uri url = UriFormatter('commande/$id').format();
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
    Uri url = UriFormatter('commande/$id').format();
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
    Uri url = UriFormatter('commande/$id/status').format();
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
