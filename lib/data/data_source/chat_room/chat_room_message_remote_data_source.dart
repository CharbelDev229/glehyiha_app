import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:http_parser/http_parser.dart';

import '../../../common/constants/instances.dart';
import '../../../common/utils/failure.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/uri_formatter.dart';
import '../../data_models/chat_room/chat_room_message.dart';
import '../../models/message/chat_message.dart';

abstract class ChatRoomMessageRemoteDataSource {
  /// ✅ CONFORME API : POST /api/chat/ avec champ 'message' uniquement
  /// Documentation: message (string) - Message textuel de l'utilisateur
  Future<Either<Failure, ChatMessage>> sendMessage({
    required String message,
    required String token,
  });

  /// ✅ CONFORME API : POST /api/chat/ avec champ 'image' uniquement  
  /// Documentation: image (file) - Image de plante à analyser
  /// Contrainte: message OU image, pas les deux (évite erreur 422)
  Future<Either<Failure, ChatMessage>> sendImageMessage({
    File? imageFile,
    Uint8List? imageBytes,
    required String filename,
    required String token,
  });

  Future<Either<Failure, GetChatRoomMessageData>> getChatHistory({
    required String token,
  });

  Future<Either<Failure, String>> deleteMessage({
    required int chatId,
    required String token,
  });
}

class ChatRoomMessageRemoteDataSourceImpl
    implements ChatRoomMessageRemoteDataSource {
  final DioRequestManager dioRequestManager;

  ChatRoomMessageRemoteDataSourceImpl({required this.dioRequestManager});

  /// ✅ VALIDATION : S'assure qu'on respecte la contrainte API "message OU image, pas les deux"
  void _validateChatRequest({String? message, File? image}) {
    if (message != null && image != null) {
      throw ArgumentError('API Error 422: Champ image ou message requis - Pas les deux');
    }
    if (message == null && image == null) {
      throw ArgumentError('API Error 422: Champ image ou message requis');
    }
  }

  String _extractReply(dynamic data, {required String fallback}) {
    try {
      if (data is Map && data['reply'] != null && data['reply'] is String) {
        return data['reply'];
      }
    } catch (e) {
      logger.e('Error parsing reply from data: $e');
    }
    return fallback;
  }

  @override
  Future<Either<Failure, ChatMessage>> sendMessage({
    required String message,
    required String token,
  }) async {
    // ✅ VALIDATION : S'assure qu'on envoie seulement un message texte
    _validateChatRequest(message: message);
    
    final url = UriFormatter('chat/').format();
    final List<FileDetails> files = [];

    logger.i('Sending message: $message');
    logger.e('URL utilisée : $url');

    try {
      final response = await dioRequestManager.sendMultipart(
        'POST',
        url,
        files,
        token: token,
        fields: {"message": message}, // ✅ Seulement le champ message
      );

      if (response.success) {
        final chatMessage = ChatMessage.fromBotReply(response.data);
        return Right(chatMessage);
      } else {
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, ChatMessage>> sendImageMessage({
    File? imageFile,
    Uint8List? imageBytes,
    required String filename,
    required String token,
  }) async {
    final url = UriFormatter('chat/').format();
    final List<FileDetails> files = [];

    try {
      dynamic multipartFile;
      if (imageFile != null) {
        // Mobile/Desktop
        multipartFile = await MultipartFile.fromFile(
          imageFile.path,
          filename: filename,
          contentType: MediaType('image', 'jpeg'),
        );
      } else if (imageBytes != null) {
        // Web
        multipartFile = MultipartFile.fromBytes(
          imageBytes,
          filename: filename,
          contentType: MediaType('image', 'jpeg'),
        );
      } else {
        throw ArgumentError('Aucune image fournie');
      }

      final formData = FormData.fromMap({
        'image': multipartFile,
      });

      final response = await dioRequestManager.dio.postUri(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.data['success'] == true) {
        final chatMessage = ChatMessage.fromBotReply(response.data['data']);
        return Right(chatMessage);
      } else {
        return Left(ServerFailure.raise(response.data));
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, GetChatRoomMessageData>> getChatHistory({
    required String token,
  }) async {
    final url = UriFormatter('chat/history').format();

    try {
      final response = await dioRequestManager.send('GET', url, token: token);
      logger.f('Chat history response: ${response.body}');

      if (response.success) {
        final data = response.data;
        if (data != null) {
          return Right(GetChatRoomMessageData.fromMap(data));
        } else {
          return Right(GetChatRoomMessageData.empty());
        }
      } else {
        logger.w('Failed to load chat history: ${response.statusCode}');
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      logger.e('Error getting chat history: $e');
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteMessage({
    required int chatId,
    required String token,
  }) async {
    final url = UriFormatter('chat/$chatId/delete').format();

    try {
      final response = await dioRequestManager.send(
        'DELETE',
        url,
        token: token,
      );

      if (response.success) {
        return Right(response.message);
      } else {
        logger.w('Failed to delete message: ${response.statusCode}');
        return Left(ServerFailure.raise(response));
      }
    } catch (e) {
      logger.e('Error deleting message: $e');
      return Left(ServerFailure.onCatch(e: e));
    }
  }
}
