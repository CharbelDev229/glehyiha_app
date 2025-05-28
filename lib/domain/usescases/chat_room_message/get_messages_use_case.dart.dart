import 'package:dartz/dartz.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../../data/data_models/chat_room/chat_room_message.dart';
import '../../repositories/chat_room_message_repository.dart';

class GetMessagesUseCase implements UseCase<GetChatRoomMessageData, GetMessagesParams> {
  final ChatRoomMessageRepository repository;

  GetMessagesUseCase({required this.repository});

  @override
  Future<Either<Failure, GetChatRoomMessageData>> call(GetMessagesParams params) async {
    return await repository.getMessages(
      chatRoomId: params.chatRoomId,
      page: params.page
    );
  }
}

class GetMessagesParams {
  final int chatRoomId;
  final int page;

  GetMessagesParams({required this.chatRoomId, required this.page});
}
