import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/assets/assets.dart';
import 'package:glehiha/common/constants/colors.dart';  

class BackgroundDeco extends StatelessWidget {
  final Widget child;

  const BackgroundDeco({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
  
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        image: DecorationImage(
          image: AssetImage(Assets.frame3),  
        
          alignment: Alignment.topRight, 
      
        ),
      ),
      child: child,  
    );
  }
}
