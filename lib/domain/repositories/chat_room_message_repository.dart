import 'dart:io';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../common/utils/failure.dart';
import '../../data/data_models/chat_room/chat_room_message.dart';
import '../../data/models/message/chat_message.dart';

abstract class ChatRoomMessageRepository {
  /// Send a text message to the bot
  Future<Either<Failure, ChatMessage>> sendMessage({
    required String message,
  });

  /// Send an image to the bot for analysis
  Future<Either<Failure, ChatMessage>> sendImageMessage({
    File? imageFile,
    Uint8List? imageBytes,
    required String filename,
  });

  /// Get chat history
  Future<Either<Failure, GetChatRoomMessageData>> getChatHistory();

  /// Delete a message from chat
  Future<Either<Failure, String>> deleteMessage({
    required int chatId,
  });
}
