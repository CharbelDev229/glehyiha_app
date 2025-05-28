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
      chatRoomId: params.chatRoomId,
      content: params.content,
      mentionedUsers: params.mentionedUsers
    );
  }
}

class SendMessageParams {
  final int chatRoomId;
  final String content;
  final List<int>? mentionedUsers;

  SendMessageParams({required this.chatRoomId, required this.content, required this.mentionedUsers});
}
