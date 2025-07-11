import 'package:dartz/dartz.dart';
import '../../../common/utils/failure.dart';
import '../../../common/utils/usecase.dart';
import '../../../data/data_models/chat_room/chat_room_message.dart';
import '../../repositories/chat_room_message_repository.dart';

class GetMessagesUseCase implements UseCase<GetChatRoomMessageData, NoParams> {
  final ChatRoomMessageRepository repository;

  GetMessagesUseCase({required this.repository});

  @override
  Future<Either<Failure, GetChatRoomMessageData>> call(NoParams params) async {
    return await repository.getChatHistory();
  }
}
