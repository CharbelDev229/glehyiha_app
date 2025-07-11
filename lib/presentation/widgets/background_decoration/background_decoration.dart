import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/assets/assets.dart';  

class BackgroundDecoration extends StatelessWidget {
  final Widget child;

  const BackgroundDecoration({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
  
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(Assets.frame3),  
        
          alignment: Alignment.topRight, 
      
        ),
      ),
      child: child,  
    );
  }
}
