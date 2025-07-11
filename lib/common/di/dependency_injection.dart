import 'package:get/get.dart';
import '../../domain/usescases/chat_room_message/send_image_message_use_case.dart';
import '../../domain/repositories/chat_room_message_repository.dart';

void initDependencies() {
  // Autres initialisations...
  
  // Enregistrement du SendImageMessageUseCase
  Get.lazyPut<SendImageMessageUseCase>(
    () => SendImageMessageUseCase(repository: Get.find<ChatRoomMessageRepository>()),
    fenix: true,
  );
}