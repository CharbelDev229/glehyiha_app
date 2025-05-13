import 'package:flutter/material.dart';
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

  List<String> messages = [];
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;
  bool isLoading = false;

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

  // Ajoute un message à la liste
  void _addMessage(String message) {
    setState(() {
      messages.add(message);
    });

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
      _addMessage(message); // Ajout du message de l'utilisateur

      // Attendre un moment avant d'ajouter la réponse du chatbot
      Future.delayed(Duration(seconds: 1), () {
        _addMessage(
          "Merci pour votre message, comment puis-je vous aider ?",
        ); // Réponse du chatbot
      });
    }
  }

  // Méthode pour construire chaque message avec animation
  Widget _buildMessage(String message, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment:
            index % 2 == 0
                ? Alignment.centerLeft
                : Alignment.centerRight, // Alternance gauche/droite
        child: SlideTransition(
          position: _animations[index], // Applique l'animation
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color:
                  index % 2 == 0
                      ? AppColors.black
                      : AppColors.primaryGreen,
                       // Couleur différente selon gauche/droite
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
              maxLines: 4,
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            HeaderWidget(),
            SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(messages[index], index);
                },
              ),
            ),
            FooterWidget(onSendMessage: _sendMessage),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
} 