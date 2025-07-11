import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../../data/models/message/chat_message.dart';
import '../../repositories/chat_room_message_repository.dart';

class SendImageMessageUseCase implements UseCase<ChatMessage, SendImageMessageParams> {
  final ChatRoomMessageRepository repository;

  SendImageMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, ChatMessage>> call(SendImageMessageParams params) async {
    return await repository.sendImageMessage(
      image: params.image,
    );
  }
}

class SendImageMessageParams {
  final File image;

  SendImageMessageParams({required this.image});
}
