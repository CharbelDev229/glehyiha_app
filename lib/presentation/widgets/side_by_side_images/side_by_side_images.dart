import 'package:flutter/material.dart';

class ImageRowWidget extends StatelessWidget {
  final String imagePath1;
  final String imagePath2;

  const ImageRowWidget({
    super.key,
    required this.imagePath1,
    required this.imagePath2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
        child: Image.asset(
              imagePath1,
              fit: BoxFit.cover,
              height: 270,
            ),
          ),
      
        Flexible(
            child: Image.asset(
              imagePath2,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
        ]);
      
    
  }
}
