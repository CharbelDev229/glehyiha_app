import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
 
  final Function(String) onSendMessage;

  const FooterWidget({super.key, required this.onSendMessage}); // Ici, nous utilisons "required" pour s'assurer que la fonction est fournie.

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isWriting = false;
  

  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      // Appel de la fonction passée en paramètre, pour envoyer le message
      widget.onSendMessage(message); // Accès via "widget" pour accéder au paramètre de la classe parent
      _controller.clear();
      setState(() {
        _isWriting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image.asset(
            "assets/images/camera1/camera1.png",
            width: 37,
            height: 43,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 204, 200, 200),
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    spreadRadius: 0.5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) {
                        setState(() {
                          _isWriting = text.isNotEmpty;
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: 'Tapez votre message ici ou prenez une photo...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 43, 131, 68),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: Image.asset(
                        'assets/icon/fleche.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
