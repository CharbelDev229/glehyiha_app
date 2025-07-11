import 'package:dartz/dartz.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../../data/models/message/chat_message.dart';
import '../../repositories/chat_room_message_repository.dart';

class SendMessageUseCase implements UseCase<ChatMessage, SendMessageParams> {
  final ChatRoomMessageRepository repository;

  SendMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, ChatMessage>> call(SendMessageParams params) async {
    return await repository.sendMessage(
      message: params.message,
    );
  }
}

class SendMessageParams {
  final String message;

  SendMessageParams({required this.message});
}
