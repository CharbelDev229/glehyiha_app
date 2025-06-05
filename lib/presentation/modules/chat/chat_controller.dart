import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/chat_room_message/get_messages_use_case.dart.dart';
import 'package:glehiha/domain/usescases/chat_room_message/send_message_use_case.dart';

import '../../../common/utils/utils.dart';
import '../../../data/models/message/chat_message.dart';
import '../../../domain/usescases/chat_room_message/delete_message_use_case.dart';

class ChatController  {
  final DeleteMessageUseCase deleteMessageUseCase =
      Get.find<DeleteMessageUseCase>();
  final GetMessagesUseCase getMessagesUseCase = Get.find<GetMessagesUseCase>();
  final SendMessageUseCase sendMessageUseCase = Get.find<SendMessageUseCase>();

  RxBool isLoading = false.obs;
  RxBool chatControllerInLoading = false.obs;
  RxBool autoValidate = false.obs;

 
  RxInt currentChatRoomId = 1.obs; // ID de la room de chat par défaut
  RxString currentMessage = ''.obs;
  //RxList<dynamic> messages = <dynamic>[].obs; // Liste des messages
  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  RxInt currentPage = 0.obs;

  // Méthode pour définir le message à envoyer
  void setMessage(String message) {
    currentMessage.value = message;
  }

  // Méthode pour définir l'ID de la room de chat
  void setChatRoomId(int chatRoomId) {
    currentChatRoomId.value = chatRoomId;
  }

  Future<bool> send(BuildContext context, String message) async {
    bool success = false;
    chatControllerInLoading.value = true;

    // Mise à jour du message avant envoi
    setMessage(message);

    final send = await sendMessageUseCase.call(
      SendMessageParams(
        chatRoomId: currentChatRoomId.value, 
        content: currentMessage.value, 
        mentionedUsers: []
      ),
    );

    send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        Utils.snackSuccess(context: context, message: 'Message envoyé avec succès!');
        success = true;
        // Recharger les messages après envoi
        await get(context);
      },
    );
    chatControllerInLoading.value = false;
    return success;
  }

  Future<bool> get(BuildContext context) async {
    bool success = false;
    chatControllerInLoading.value = true;

    final result = await getMessagesUseCase.call(
      GetMessagesParams(
        chatRoomId: currentChatRoomId.value, 
        page: currentPage.value
      ),
    );

    result.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        // Stocker les messages récupérés
       // messages.value = response.data ?? [];
       messages.value = (response.chatRoomItems ?? [])
    .whereType<ChatMessage>()
    .toList();



        Utils.snackSuccess(context: context, message: 'Messages chargés avec succès!');
        success = true;
      },
    );
    chatControllerInLoading.value = false;
    return success;
  }

  Future<bool> delete(BuildContext context, int messageId) async {
    bool success = false;
    chatControllerInLoading.value = true;

    final result = await deleteMessageUseCase.call(
      DeleteMessageParams(
        chatRoomId: currentChatRoomId.value, 
        messageId: messageId,
      ),
    );
    
    result.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        Utils.snackSuccess(context: context, message: 'Message supprimé avec succès!');
        success = true;
        // Recharger les messages après suppression
        await get(context);
      },
    );
    chatControllerInLoading.value = false;
    return success;
  }

 
}