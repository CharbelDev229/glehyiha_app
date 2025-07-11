import 'package:flutter/material.dart';

class GradientBackgroundScreen extends StatelessWidget {
  final Widget child;

  const GradientBackgroundScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 196, 192, 192),  // Départ Blanc
            Color.fromARGB(255, 7, 68, 24), // Fin Vert
          ],
          stops: [0.1, 1.0], 
        ),
      ),
      child: child,
    );
  }
}
