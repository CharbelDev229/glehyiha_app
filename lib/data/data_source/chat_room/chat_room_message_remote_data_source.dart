import 'package:dartz/dartz.dart';
import '../../../common/constants/instances.dart';
import '../../../common/utils/failure.dart';
import '../../../common/helpers/request_manager.dart';
import '../../../common/utils/uri_formatter.dart';
import '../../data_models/chat_room/chat_room_message.dart';
import '../../models/message/chat_message.dart';

abstract class ChatRoomMessageRemoteDataSource {
  /// Send a message to a chat room
  Future<Either<Failure, ChatMessage>> sendMessage({
    required int chatRoomId,
    required String content,
    required String token,
    List<int>? mentionedUsers,
  });

  /// Get messages from a chat room
  Future<Either<Failure, GetChatRoomMessageData>> getMessages({
    required int chatRoomId,
    required String token,
    required int page,
  });



  /// Delete a message from a chat room
  Future<Either<Failure, String>> deleteMessage({
    required int chatRoomId,
    required int messageId,
    required String token,
  });



}

class ChatRoomMessageRemoteDataSourceImpl
    implements ChatRoomMessageRemoteDataSource {
  final DioRequestManager dioRequestManager;

  ChatRoomMessageRemoteDataSourceImpl({required this.dioRequestManager});

  @override
  Future<Either<Failure, ChatMessage>> sendMessage({
    required int chatRoomId,
    required String content,
    required String token,
    List<int>? mentionedUsers,
  }) async {
    Uri url = UriFormatter('chat-room/send-message').format();

    Map<String, dynamic> body = {
      'chat_room_id': chatRoomId,
      'content': content,
      'type': 'text',
    };

    if (mentionedUsers != null && mentionedUsers.isNotEmpty) {
      body['mentions'] = mentionedUsers;
    }

    try {
      final response = await dioRequestManager.send(
        'POST',
        url,
        body: body,
        token: token,
      );

      logger.f('response : ${response.body}');

      if (response.success) {
        return Right(
          ChatMessage.fromMap(response.data),
        );
      } else {
        return Left(
          ServerFailure.raise(
            response,
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure.onCatch(e: e));
    }
  }

  @override
  Future<Either<Failure, GetChatRoomMessageData>> getMessages({
    required int chatRoomId,
    required String token,
    required int page,
  }) async {
    Uri url =
        UriFormatter('chat-room/$chatRoomId/messages', extras: {'page': page})
            .format();

    try {
      final response = await dioRequestManager.send(
        'GET',
        url,
        token: token,
      );

      logger.f('response : ${response.body}');
      if (response.success) {
        logger.f('response.map : ${response.map}');
        if (response.data is Map<String, dynamic>) {
          return Right(GetChatRoomMessageData.fromMap(response.data));
        } else {
          return Left(
            ServerFailure.raise(response),
          );
        }
      } else {
        return Left(
          ServerFailure.raise(response),
        );
      }
    } catch (e) {
      return Left(
        ServerFailure.onCatch(e: e),
      );
    }
  }

  @override
  Future<Either<Failure, String>> deleteMessage({
    required int chatRoomId,
    required int messageId,
    required String token,
  }) async {
    Uri url =
        UriFormatter('chat-rooms/$chatRoomId/messages/$messageId').format();

    try {
      final response = await dioRequestManager.send('DELETE', url, token: token);

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
