import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../common/utils/failure.dart';
import '../../domain/repositories/chat_room_message_repository.dart';
import '../data_models/chat_room/chat_room_message.dart';
import '../data_source/auth/auth_local_data_source.dart';
import '../data_source/chat_room/chat_room_message_remote_data_source.dart';
import '../models/message/chat_message.dart';

class ChatRoomMessageRepositoryImpl implements ChatRoomMessageRepository {
  final ChatRoomMessageRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  ChatRoomMessageRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, ChatMessage>> sendMessage({
    required String message,
  }) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold(
      (failure) => Left(failure),
      (token) async {
        final result = await remoteDataSource.sendMessage(
          message: message,
          token: token,
        );
        return result;
      },
    );
  }

  @override
  Future<Either<Failure, ChatMessage>> sendImageMessage({
    required File image,
  }) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold(
      (failure) => Left(failure),
      (token) async {
        final result = await remoteDataSource.sendImageMessage(
          image: image,
          token: token,
        );
        return result;
      },
    );
  }

  @override
  Future<Either<Failure, GetChatRoomMessageData>> getChatHistory() async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold(
      (failure) => Left(failure),
      (token) async {
        final result = await remoteDataSource.getChatHistory(
          token: token,
        );
        return result;
      },
    );
  }

  @override
  Future<Either<Failure, String>> deleteMessage({
    required int chatId,
  }) async {
    final accessToken = await authLocalDataSource.getToken();

    return accessToken.fold(
      (failure) => Left(failure),
      (token) async {
        final result = await remoteDataSource.deleteMessage(
          chatId: chatId,
          token: token,
        );
        return result;
      },
    );
  }
}
