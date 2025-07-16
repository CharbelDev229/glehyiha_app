import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/chat_room_message/get_messages_use_case.dart.dart';
import 'package:glehiha/domain/usescases/chat_room_message/send_message_use_case.dart';
import 'package:glehiha/domain/usescases/chat_room_message/send_image_message_use_case.dart';
import 'package:glehiha/common/utils/usecase.dart';
import '../../../common/utils/utils.dart';
import '../../../data/models/message/chat_message.dart';
import '../../../domain/usescases/chat_room_message/delete_message_use_case.dart';

class ChatController {
  final DeleteMessageUseCase deleteMessageUseCase = Get.find();
  final GetMessagesUseCase getMessagesUseCase = Get.find();
  final SendMessageUseCase sendMessageUseCase = Get.find();
  final SendImageMessageUseCase sendImageMessageUseCase = Get.find();

  RxBool isLoading = false.obs;
  RxBool chatControllerInLoading = false.obs;
  RxBool autoValidate = false.obs;

  RxString currentMessage = ''.obs;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  void setMessage(String message) {
    currentMessage.value = message;
  }

  Future<void> send(BuildContext context, String message) async {
    chatControllerInLoading.value = true;
    setMessage(message);

    try {
      final send = await sendMessageUseCase.call(
        SendMessageParams(message: currentMessage.value),
      );

      return send.fold(
        (failure) {
          Utils.snackError(context: context, message: failure.message);
          chatControllerInLoading.value = false;
        },
        (response) async {
          // Ajouter le message à la liste des messages
          messages.add(response);
          chatControllerInLoading.value = false;
        },
      );
    } catch (e) {
      chatControllerInLoading.value = false;
    }
  }

  // Méthode mise à jour pour accepter les paramètres nommés
  Future<String?> sendImage(
    BuildContext context, {
    File? imageFile,
    Uint8List? imageBytes,
    required String filename,
  }) async {
    chatControllerInLoading.value = true;

    ChatMessage? tempMessage;
    try {
      if (imageFile != null && await imageFile.exists()) {
        tempMessage = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch,
          userId: 1,
          message: "Analyse en cours...",
          imagePath: imageFile.path,
          createdAt: DateTime.now(),
          isUser: true,
        );
        messages.add(tempMessage);
      }

      final send = await sendImageMessageUseCase.call(
        SendImageMessageParams(
          imageFile: imageFile,
          imageBytes: imageBytes,
          filename: filename,
        ),
      );

      return send.fold(
        (failure) {
          Utils.snackError(context: context, message: failure.message);
          if (tempMessage != null) messages.remove(tempMessage);
          chatControllerInLoading.value = false;
          return null;
        },
        (response) async {
          // Mise à jour ou pas du message utilisateur (tempMessage suffit déjà)
          if (tempMessage != null) {
            final index = messages.indexOf(tempMessage);
            if (index != -1) {
              messages[index] = tempMessage;
            }
          }

          // Ajout du message IA
          final botReplyMessage = ChatMessage(
            id: response.id ?? DateTime.now().millisecondsSinceEpoch,
            userId: response.userId,
            message: response.message,
            reply: response.reply,
            imagePath: response.imagePath,
            createdAt: response.createdAt,
            isUser: false,
          );
          messages.add(botReplyMessage);

          chatControllerInLoading.value = false;
          return response.reply ?? "Pas d’analyse d’image disponible";
        },
      );
    } catch (e) {
      print("Erreur lors de l’envoi de l’image: $e");
      if (tempMessage != null) messages.remove(tempMessage);
      chatControllerInLoading.value = false;
      return null;
    }
  }

  Future<bool> get(BuildContext context) async {
    chatControllerInLoading.value = true;
    final result = await getMessagesUseCase.call(NoParams());
    chatControllerInLoading.value = false;

    return result.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
        return false;
      },
      (response) async {
        messages.value =
            (response.chatRoomItems ?? []).whereType<ChatMessage>().toList();
        return true;
      },
    );
  }

  Future<bool> delete(BuildContext context, int chatId) async {
    chatControllerInLoading.value = true;
    final result = await deleteMessageUseCase.call(
      DeleteMessageParams(chatId: chatId),
    );
    chatControllerInLoading.value = false;

    return result.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
        return false;
      },
      (response) async {
        await get(context);
        return true;
      },
    );
  }
}
