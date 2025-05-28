
import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../../data/data_models/chat_room/chat_room_message.dart';
import '../../data/models/message/chat_message.dart';

abstract class ChatRoomMessageRepository {
  /// Send a message to a chat room
  Future<Either<Failure, ChatMessage>> sendMessage({
    required int chatRoomId,
    required String content,
    List<int>? mentionedUsers,
  });

  /// Get messages from a chat room
  Future<Either<Failure, GetChatRoomMessageData>> getMessages({
    required int chatRoomId,
    required int page
  });

  /// Delete a message from a chat room
  Future<Either<Failure, String>> deleteMessage({
    required int chatRoomId,
    required int messageId,
  });

  
}
