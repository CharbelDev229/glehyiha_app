import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../data/models/message/chat_message.dart';

class ChatController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;

  final Dio _dio = Dio();

  Future<void> sendMessage(String userInput) async {
    if (userInput.trim().isEmpty) return;

    // Ajouter le message utilisateur
    messages.add(
      ChatMessage(
        id: 0,
        text: userInput,
        content: userInput,
        senderId: 1,
        isUser: true,
        isDeletedAt: null,
        updateAt: DateTime.now().toIso8601String(),
      ),
    );

    isLoading.value = true;

    try {
    
      final response = await _dio.post(
        'https://mobileapi.alwaysdata.net/api/chat',
        data: {'message': userInput},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      // Afficher la réponse (pour debug)
      print('Réponse: ${response.data}');

      final String botReply = response.data['reply'] ?? 'Pas de réponse';

      // Ajouter la réponse du bot
      messages.add(
        ChatMessage(
          id: 0,
          text: botReply,
          content: botReply,
          senderId: 0,
          isUser: false,
          isDeletedAt: null,
          updateAt: DateTime.now().toIso8601String(),
        ),
      );
    } catch (e) {
      // Afficher l'erreur complète (pour debug)
      print('Erreur complète: $e');

      messages.add(
        ChatMessage(
          id: 0,
          text: "Erreur: Impossible de contacter le serveur",
          content: "Erreur de connexion",
          senderId: 0,
          isUser: false,
          isDeletedAt: null,
          updateAt: DateTime.now().toIso8601String(),
        ),
      );
    }

    isLoading.value = false;
  }
}
