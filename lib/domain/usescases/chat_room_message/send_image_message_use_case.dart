import 'dart:io';
import 'package:dartz/dartz.dart';
import 'dart:typed_data';
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
      imageFile: params.imageFile,
      imageBytes: params.imageBytes,
      filename: params.filename,
    );
  }
}

class SendImageMessageParams {
  final File? imageFile;
  final Uint8List? imageBytes;
  final String filename;

  SendImageMessageParams({
    this.imageFile,
    this.imageBytes,
    required this.filename,
  });
}
