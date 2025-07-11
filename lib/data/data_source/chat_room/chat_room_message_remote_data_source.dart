import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../common/constants/instances.dart';
import '../../../common/utils/failure.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/uri_formatter.dart';
import '../../data_models/chat_room/chat_room_message.dart';
import '../../models/message/chat_message.dart';

abstract class ChatRoomMessageRemoteDataSource {
  Future<Either<Failure, ChatMessage>> sendMessage({
    required String message,
    required String token,
  });

  Future<Either<Failure, ChatMessage>> sendImageMessage({
    required File image,
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
        fields: {"message": message},
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
    required File image,
    required String token,
  }) async {
    final url = UriFormatter('chat/').format();
    final List<FileDetails> files = [];

    files.add(FileDetails(image.path, 'image'));

    try {
      final response = await dioRequestManager.sendMultipart(
        'POST',
        url,
        files,
        fileField: 'image',
        token: token,
        fields: {},
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
