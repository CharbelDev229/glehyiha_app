import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/assets/assets.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:glehiha/common/constants/assets/logo_assets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
         alignment: Alignment.center,
                children: [
                  Image.asset(
                  Assets.elipse,
                  width: 350,
                  height: 350,
                ),
                Image.asset(
                 LogoAssets.logo,
                  width: 52,
                  height: 22,),]),
            
            ElevatedButton(
              onPressed: () => context.pushNamed(AppRoutesNames.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Démarrer',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),),
            ),
      ]  ),),
        
      
    );
  }
}
