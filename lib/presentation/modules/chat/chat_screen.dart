import 'package:flutter/material.dart';
import 'package:glehiha/data/models/message/chat_message.dart';
import 'package:glehiha/presentation/modules/chat/chat_controller.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:glehiha/presentation/widgets/footer_widget/footer_widget.dart'; // Ton footer actuel
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

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _animations = [];
    _scrollController = ScrollController();
    _sendFirstMessage();
  }

  Future<void> _sendFirstMessage() async {
    await Future.delayed(Duration(seconds: 1));
    _addMessage(
      "Bonjour je suis votre assistant agricole intelligent. Posez-moi toutes sortes de questions et je vous aiderai",
    );
  }

  void _addMessage(String messageText) {
    chatController.messages.add(
      ChatMessage(
        id: chatController.messages.length,
        text: messageText,
        content: messageText,
        senderId: 0,
        isUser: false,
        isDeletedAt: null,
        updateAt: DateTime.now().toIso8601String(),
      ),
    );

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

  // Fonction appelée par ton footer quand l'utilisateur envoie un message
  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      _addAnimationController();
      chatController.sendMessage(message);

      Timer(Duration(milliseconds: 100), () {
        _addAnimationController();
      });
    }
  }

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

  Widget _buildMessage(ChatMessage message, int index) {
    if (index >= _animations.length) {
      _addAnimationController();
    }

    bool isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: SlideTransition(
          position:
              index < _animations.length
                  ? _animations[index]
                  : _animations.last,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: isUser ? Color(0xFFDCF8C6) : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 0),
                bottomRight: Radius.circular(isUser ? 0 : 18),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(fontSize: 16, color: Colors.black87),
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
                      Obx(() {
                        final messageList = chatController.messages;

                        // Scroll automatique
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        });

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return _buildMessage(messageList[index], index);
                          },
                        );
                      }),
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
                // Ici ton FooterWidget existant, tu ne changes rien
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
    for (var controller in _controllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }
}
