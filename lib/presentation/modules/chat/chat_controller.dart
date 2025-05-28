import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../data/models/message/chat_message.dart';

class ChatController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  final Dio _dio = Dio();

  Future<void> sendMessage(String userInput) async {
    if (userInput.trim().isEmpty) return;

    // Ajouter le message utilisateur
    messages.add(ChatMessage(
      id: 0,
      text: userInput,
      content: userInput,
      senderId: 1,
      isUser: true,
      isDeletedAt: null,
      updateAt: DateTime.now().toIso8601String(),
    ));

    isLoading.value = true;

    try {
    //   Requête vers ton API
      final response = await _dio.post(
       'https://mobileapi.alwaysdata.net/api/chat', // remplace par l'URL de ton API
       data: {'message': userInput},
      );

      final String botReply = response.data['reply'];

      // Ajouter la réponse du bot
      messages.add(ChatMessage(
        id: 0,
        text: botReply,
        content: botReply,
        senderId: 0,
        isUser: false,
        isDeletedAt: null,
        updateAt: DateTime.now().toIso8601String(),
      ));
    } catch (e) {
      messages.add(ChatMessage(
        id: 0,
        text: "Erreur de connexion à l'API.",
        content: "Erreur de connexion",
        senderId: 0,
        isUser: false,
        isDeletedAt: null,
        updateAt: DateTime.now().toIso8601String(),
      ));
    } finally {
      isLoading.value = false;
    }
  }
}
