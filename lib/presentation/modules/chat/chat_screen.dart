import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:glehiha/presentation/widgets/footer_widget/footer_widget.dart';
import 'dart:async';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';

import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';
import 'chat_controller.dart'; // Ajoutez cette ligne pour importer votre contrôleur

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
  
  // Ajout du contrôleur
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _animations = [];
    _sendFirstMessage();
    // Chargement des messages existants
    _loadExistingMessages();
  }

  // Nouvelle méthode pour charger les messages existants
  Future<void> _loadExistingMessages() async {
    await chatController.get(context);
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

  // Méthode pour générer une réponse automatique basée sur le message de l'utilisateur
  String _generateResponse(String userMessage) {
    // Convertir le message en minuscules pour faciliter la comparaison
    final lowerCaseMessage = userMessage.toLowerCase();

    // Tableau de correspondances entre mots-clés et réponses
    final Map<List<String>, String> responses = {
      [
        'bonjour',
        'salut',
        'hello',
        'hi',
      ]: "Bonjour ! Comment puis-je vous aider avec vos questions agricoles aujourd'hui ?",

      [
        'culture',
        'planter',
        'semis',
        'plantation',
      ]: "Pour réussir votre culture, il est important de considérer le type de sol, l'exposition et les besoins en eau. Quelle plante souhaitez-vous cultiver ?",

      [
        'engrais',
        'fertilisant',
        'nourrir',
        'nutriment',
      ]: "Les engrais organiques sont excellents pour améliorer la structure du sol. Préférez-vous utiliser des engrais naturels ou chimiques ?",

      [
        'bio',
        'biologique',
        'écologique',
        'naturel',
      ]: "L'agriculture biologique favorise la biodiversité et préserve la qualité des sols. Quelles pratiques biologiques vous intéressent particulièrement ?",

      [
        'maladie',
        'parasite',
        'insecte',
        'traitement',
      ]: "Pour identifier une maladie ou un parasite, observez les symptômes sur vos plantes. Pouvez-vous me décrire ce que vous constatez ?",

      [
        'irrigation',
        'arrosage',
        'eau',
        'arroser',
      ]: "Un bon système d'irrigation est essentiel pour optimiser l'utilisation de l'eau. Quel type de culture souhaitez-vous irriguer ?",

      [
        'sol',
        'terre',
        'terrain',
        'ph',
      ]: "La qualité du sol est fondamentale pour la réussite de vos cultures. Avez-vous déjà effectué une analyse de votre sol ?",

      [
        'récolte',
        'rendement',
        'production',
        'productivité',
      ]: "Pour améliorer vos rendements, plusieurs facteurs entrent en jeu : qualité du sol, choix des variétés, pratiques culturales... Quelle culture vous préoccupe ?",

      [
        'saison',
        'calendrier',
        'quand',
        'période',
      ]: "Le calendrier agricole est essentiel pour planifier vos activités. Quelle culture souhaitez-vous planifier ?",

      [
        'outil',
        'équipement',
        'matériel',
        'machine',
      ]: "Le choix des bons outils permet d'optimiser votre travail. Pour quelle tâche agricole recherchez-vous des équipements ?",
    };

    // Vérifier si le message contient des mots-clés connus
    for (var entry in responses.entries) {
      for (var keyword in entry.key) {
        if (lowerCaseMessage.contains(keyword)) {
          return entry.value;
        }
      }
    }

    // Réponse par défaut si aucun mot-clé n'est trouvé
    return "Merci pour votre question. Pourriez-vous me donner plus de détails pour que je puisse vous aider plus précisément dans votre démarche agricole ?";
  }

  // Méthode modifiée pour envoyer un message depuis le FooterWidget avec le contrôleur
  void _sendMessage(String message) async {
    if (message.isNotEmpty) {
      _addMessage(message); // Ajout du message de l'utilisateur

      setState(() {
        isLoading = true; // Afficher l'indicateur de chargement
      });

      // Utilisation du contrôleur pour envoyer le message avec le contenu
      final success = await chatController.send(context, message);
      
      if (success) {
        // Simuler un délai de traitement pour plus de réalisme
        Future.delayed(Duration(milliseconds: 1500), () {
          // Générer une réponse automatique basée sur le contenu du message
          final response = _generateResponse(message);

          setState(() {
            isLoading = false; // Masquer l'indicateur de chargement
          });

          _addMessage(response); // Ajouter la réponse du chatbot
        });
      } else {
        setState(() {
          isLoading = false; // Masquer l'indicateur de chargement en cas d'erreur
        });
      }
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
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: index % 2 == 0 ? AppColors.black : AppColors.primaryGreen,
              // Couleur différente selon gauche/droite
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
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
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(messages[index], index);
                    },
                  ),
                  // Utilisation de Obx pour observer l'état de chargement du contrôleur
                  Obx(() {
                    if (isLoading || chatController.chatControllerInLoading.value) {
                      return Positioned(
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
                      );
                    }
                    return SizedBox.shrink();
                  }),
                ],
              ),
            ),
            FooterWidget(onSendMessage: _sendMessage),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
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