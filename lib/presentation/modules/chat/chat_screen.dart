import 'package:flutter/material.dart';
import 'package:glehiha/data/models/message/chat_message.dart';
import 'package:glehiha/presentation/modules/chat/chat_controller.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:glehiha/presentation/widgets/footer_widget/footer_widget.dart';
import 'dart:async';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';

import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  final NavigationController navController = Get.put(NavigationController());
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final ChatController chatController = Get.put(ChatController());
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _animations = [];
    _sendFirstMessage();
  }

  // Méthode pour ajouter des messages avec un délai
  Future<void> _sendFirstMessage() async {
    await Future.delayed(Duration(seconds: 1));
    _addMessage(
      "Bonjour je suis votre assistant agricole intelligent. Posez-moi toutes sortes de questions et je vous aiderai",
    );
  }

  // Ajoute un message à la liste du controller
  void _addMessage(String messageText) {
    // Ajouter le message au controller
    chatController.messages.add(ChatMessage(
      id: chatController.messages.length,
      text: messageText,
      content: messageText,
      senderId: 0, // Bot message
      isUser: false,
      isDeletedAt: null,
      updateAt: DateTime.now().toIso8601String(),
    ));

    // Créer un contrôleur d'animation pour chaque message
    AnimationController controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    Animation<Offset> animation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Commence en bas
      end: Offset.zero, // Fin de l'animation
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    // Ajouter l'animation et démarrer
    _controllers.add(controller);
    _animations.add(animation);
    controller.forward(); // Démarre l'animation
  }

  // Méthode pour envoyer un message depuis le FooterWidget
  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      // Ajouter une animation pour le nouveau message utilisateur
      _addAnimationController();
      
      chatController.sendMessage(message); // Envoi du message via le controller
      
      // Ajouter une animation pour la réponse du bot (sera ajoutée après la réponse)
      Timer(Duration(milliseconds: 100), () {
        _addAnimationController();
      });
    }
  }

  // Méthode pour ajouter un contrôleur d'animation
  void _addAnimationController() {
    AnimationController controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    Animation<Offset> animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    _controllers.add(controller);
    _animations.add(animation);
    controller.forward();
  }

  // Méthode pour construire chaque message avec animation
  Widget _buildMessage(ChatMessage message, int index) {
    // S'assurer qu'on a assez d'animations
    if (index >= _animations.length) {
      _addAnimationController();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: message.isUser 
            ? Alignment.centerRight 
            : Alignment.centerLeft,
        child: SlideTransition(
          position: index < _animations.length 
              ? _animations[index] 
              : _animations.last, // Utiliser la dernière animation si index trop grand
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: message.isUser 
                  ? AppColors.primaryGreen 
                  : AppColors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.transparent,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                HeaderWidget(),
                SizedBox(height: 25),
                Expanded(
                  child: Stack(
                    children: [
                      Expanded(
                        child: Obx(() {
                          final messageList = chatController.messages;
                          return ListView.builder(
                            itemCount: messageList.length,
                            itemBuilder: (context, index) {
                              return _buildMessage(messageList[index], index);
                            },
                          );
                        }),
                      ),
                      if (chatController.isLoading.value)
                        Positioned(
                          bottom: 0,
                          left: 20,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "En train d'écrire...",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                FooterWidget(onSendMessage: _sendMessage),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomBar(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Nettoyer les contrôleurs d'animation
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}