import 'package:dartz/dartz.dart';
import '../../common/utils/failure.dart';
import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../domain/repositories/chat_room_message_repository.dart';
import '../data_models/chat_room/chat_room_message.dart';
import '../data_source/chat_room/chat_room_message_remote_data_source.dart';
import '../models/message/chat_message.dart';


class ChatRoomMessageRepositoryImpl implements ChatRoomMessageRepository {
  final AuthLocalDataSource authLocalDataSource;
  final ChatRoomMessageRemoteDataSource chatRoomMessageRemoteDataSource;

  ChatRoomMessageRepositoryImpl({
    required this.authLocalDataSource,
    required this.chatRoomMessageRemoteDataSource,
  });

  @override
  Future<Either<Failure, ChatMessage>> sendMessage({
    required int chatRoomId,
    required String content,
    List<int>? mentionedUsers,
  }) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold(
          (failure) => Left(failure),
          (token) async {
        final response = await chatRoomMessageRemoteDataSource.sendMessage(
          chatRoomId: chatRoomId,
          content: content,
          token: token,
          mentionedUsers: mentionedUsers
        );
        return response.fold(
              (failure) => Left(failure),
              (message) => Right(message),
        );
      },
    );
  }

  @override
  Future<Either<Failure, GetChatRoomMessageData>> getMessages({
    required int chatRoomId,
    required int page,
  }) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold(
          (failure) => Left(failure),
          (token) async {
        final response = await chatRoomMessageRemoteDataSource.getMessages(
          chatRoomId: chatRoomId,
          token: token,
          page: page,
        );
        return response.fold(
              (failure) => Left(failure),
              (messages) => Right(messages),
        );
      },
    );
  }

  @override
  Future<Either<Failure, String>> deleteMessage({
    required int chatRoomId,
    required int messageId,
  }) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold(
          (failure) => Left(failure),
          (token) async {
        final response = await chatRoomMessageRemoteDataSource.deleteMessage(
          chatRoomId: chatRoomId,
          messageId: messageId,
          token: token,
        );
        return response.fold(
              (failure) => Left(failure),
              (message) => Right(message),
        );
      },
    );
  }

 
}
