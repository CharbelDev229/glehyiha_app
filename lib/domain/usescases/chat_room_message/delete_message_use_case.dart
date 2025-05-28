import 'package:dartz/dartz.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../repositories/chat_room_message_repository.dart';

class DeleteMessageUseCase implements UseCase<String, DeleteMessageParams> {
  final ChatRoomMessageRepository repository;

  DeleteMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(DeleteMessageParams params) async {
    return await repository.deleteMessage(
      chatRoomId: params.chatRoomId,
      messageId: params.messageId,
    );
  }
}

class DeleteMessageParams {
  final int chatRoomId;
  final int messageId;

  DeleteMessageParams({required this.chatRoomId, required this.messageId});
}