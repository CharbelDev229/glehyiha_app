import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glehiha/data/models/message/chat_message.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:glehiha/presentation/widgets/footer_widget/footer_widget.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';
import 'chat_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class BubbleTrianglePainter extends CustomPainter {
  final Color color;
  final bool isUserMessage;

  BubbleTrianglePainter({required this.color, required this.isUserMessage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    if (isUserMessage) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height / 2);
      path.close();
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height / 2);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatController chatController = Get.put(ChatController(), permanent: true); // Permanent instance to maintain state across the app

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _animations = [];
    _loadExistingMessages();
  }

  Future<void> _loadExistingMessages() async {
    
    if (chatController.messages.isEmpty) {
      await chatController.get(context);
      if (chatController.messages.isEmpty) {
        _addWelcomeMessage();
      }
    }
    _initializeAnimationsForExistingMessages();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _addWelcomeMessage() {
    final welcomeMessage = ChatMessage(
      id: 0,
      userId: 0,
      message: "Bienvenue, je suis GLEHYIHA votre assistant agricole. Comment puis-je vous aider aujourd'hui ?",
      createdAt: DateTime.now(),
      isUser: true,
    );
    chatController.messages.add(welcomeMessage);
    _addAnimation();
  }

  void _initializeAnimationsForExistingMessages() {
    for (int i = 0; i < chatController.messages.length; i++) {
      AnimationController controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      );
      Animation<Offset> animation = Tween<Offset>(
        begin: Offset.zero,
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
      _controllers.add(controller);
      _animations.add(animation);
      controller.forward();
    }
  }

  void _sendMessage(String message) async {
    if (message.isEmpty) return;
    _textController.clear();

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch,
      userId: 1,
      message: message,
      createdAt: DateTime.now(),
      isUser: true,
    );
    chatController.messages.add(userMessage);
    _addAnimation();
    _scrollToBottom();
    await chatController.send(context, message);
    _addAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _addAnimation() {
    AnimationController controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    Animation<Offset> animation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutQuad));
    _controllers.add(controller);
    _animations.add(animation);
    controller.forward();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildMessage(ChatMessage message, int index) {
    final bool isUserMessage = message.userId != 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: SlideTransition(
          position: index < _animations.length ? _animations[index] : AlwaysStoppedAnimation(Offset.zero),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUserMessage)
                CustomPaint(
                  painter: BubbleTrianglePainter(color: AppColors.black, isUserMessage: false),
                  size: Size(8, 10),
                ),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: isUserMessage ? AppColors.primaryGreen : AppColors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: isUserMessage ? Radius.circular(16) : Radius.circular(0),
                      bottomRight: isUserMessage ? Radius.circular(0) : Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.imagePath != null && message.imagePath!.isNotEmpty)
                        _buildImageWidget(message.imagePath!),
                      if (message.imagePath != null && message.imagePath!.isNotEmpty)
                        SizedBox(height: 8),
                      Text(
                        isUserMessage ? message.message : message.reply ?? message.message,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                        ),
                      ),
                      if (!isUserMessage && message.createdAt != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            _formatTimestamp(message.createdAt.toString()),
                            style: TextStyle(fontSize: 10, color: AppColors.white.withOpacity(0.7)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (isUserMessage)
                CustomPaint(
                  painter: BubbleTrianglePainter(color: AppColors.primaryGreen, isUserMessage: true),
                  size: Size(8, 10),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      // Image distante (URL)
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200, // Ajouter une hauteur fixe
          errorBuilder: (context, error, stackTrace) {
            print('Erreur de chargement d\'image réseau: $error');
            return Container(
              height: 150,
              color: Colors.grey.shade300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.grey.shade600),
                    SizedBox(height: 8),
                    Text('Erreur de chargement', 
                         style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 150,
              color: Colors.grey.shade200,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / 
                        loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      );
    } else {
      // Image locale (File)
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FutureBuilder<bool>(
          future: File(imagePath).exists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 150,
                color: Colors.grey.shade200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            
            if (snapshot.data == true) {
              return Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Ajouter une hauteur fixe
                errorBuilder: (context, error, stackTrace) {
                  print('Erreur de chargement d\'image locale: $error, chemin: $imagePath');
                  return Container(
                    height: 150,
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.grey.shade600),
                          SizedBox(height: 8),
                          Text('Erreur de chargement', 
                               style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container(
                height: 150,
                color: Colors.grey.shade300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported, color: Colors.grey.shade600),
                      SizedBox(height: 8),
                      Text('Image non trouvée', 
                           style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
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
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Obx(() {
                    final messages = chatController.messages;
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) => _buildMessage(messages[index], index),
                    );
                  }),
                  Obx(() {
                    if (chatController.chatControllerInLoading.value) {
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
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "En train d'\u00e9crire...",
                                style: TextStyle(color: AppColors.white, fontSize: 12),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_camera, color: AppColors.primaryGreen),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final image = await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) await _processImage(image);
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "\u00c9crivez votre message...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: AppColors.primaryGreen),
                    onPressed: () => _sendMessage(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }


  // Methode pour traiter l'image sélectionnée
  Future<void> _processImage(XFile image) async {
    print("Image sélectionnée: ${image.path}"); // Debug
    
    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      await chatController.sendImage(
        context,
        imageBytes: bytes,
        filename: image.name,
      );
    } else {
      final file = File(image.path);
      print("Fichier existe: ${await file.exists()}"); // Vérifier si le fichier existe
      
      await chatController.sendImage(
        context,
        imageFile: file,
        filename: image.name,
      );
    }
  }
  // Dispose methode pour libérer les ressources
  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
