import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/chat_room_message/get_messages_use_case.dart.dart';
import 'package:glehiha/domain/usescases/chat_room_message/send_message_use_case.dart';
import 'package:glehiha/domain/usescases/chat_room_message/send_image_message_use_case.dart';
import 'package:glehiha/common/utils/usecase.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<String?> sendImage(BuildContext context, File image) async {
    chatControllerInLoading.value = true;

    try {
      final send = await sendImageMessageUseCase.call(
        SendImageMessageParams(image: image),
      );

      return send.fold(
        (failure) {
          Utils.snackError(context: context, message: failure.message);
          chatControllerInLoading.value = false;
          return null;
        },
        (response) async {
          // Ajouter le message à la liste des messages
          messages.add(response);
          chatControllerInLoading.value = false;

          // Retourner la réponse du chatbot pour l'affichage
          return response.reply ?? "Pas d'analyse d'image disponible";
        },
      );
    } catch (e) {
      chatControllerInLoading.value = false;
      return null;
    }
  }

  // méthode pour gérer spécifiquement le web
  Future<String?> sendImageFromXFile(
    BuildContext context,
    XFile imageFile,
  ) async {
    chatControllerInLoading.value = true;

    try {
      File file;
      if (kIsWeb) {
        // Sur le web, créez un File à partir des bytes
        final bytes = await imageFile.readAsBytes();
        file = File.fromRawPath(bytes);
      } else {
        file = File(imageFile.path);
      }

      final send = await sendImageMessageUseCase.call(
        SendImageMessageParams(image: file),
      );

      return send.fold(
        (failure) {
          Utils.snackError(context: context, message: failure.message);
          chatControllerInLoading.value = false;
          return null;
        },
        (response) async {
          messages.add(response);
          chatControllerInLoading.value = false;
          return response.reply ?? "Pas d'analyse d'image disponible";
        },
      );
    } catch (e) {
      chatControllerInLoading.value = false;
      Utils.snackError(
        context: context,
        message: 'Erreur lors de l\'envoi de l\'image: ${e.toString()}',
      );
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
