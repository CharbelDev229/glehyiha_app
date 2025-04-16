import 'package:flutter/material.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/common/constants/assets/assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(70),
                ),
                child: Image.asset(
                  Assets.femme,
                  width: double.infinity,
                  height: 380,
                  fit: BoxFit.cover,
               
                ),
              ),
           Positioned(
                bottom: 0,
                left: 20,
                right: 0,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Text(
                        'Prenez une photo et obtenez un diagnostic instantané',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),]),),  ],),
                      
               Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   SizedBox(height: 5,),
                      Text(
                        'Notre IA reconnaît les maladies des plantes et vous donne des solutions adaptées.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          color: AppColors.white,
                        ),
                      ),
               
                      SizedBox(height: 10,),
                 
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      Assets.image,
                      width: 133,
                      height: 100,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      padding:  EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 94, 104, 77),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Les taches sur cette feuille indiquent une possible infection fongique. Il peut sagir de la tache septorienne. Voici quelques solutions...',
                        maxLines: 5,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 15),
                   ElevatedButton(
                  onPressed: (){},
                   style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white,
                   padding: const EdgeInsets.symmetric(
                   horizontal: 40,
                   vertical: 15,), ),
               child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              GestureDetector(
              onTap: () {
              context.pushNamed(AppRoutesNames.splash); },
          child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 26, 119, 80),
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,), ), ),
          SizedBox(width: 8),
         Text(
        'Suivant',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 26, 119, 80), ), ),
        SizedBox(width: 8),
      GestureDetector(
        onTap: () {
          context.pushNamed(AppRoutesNames.onboarding);},
        child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryGreen,
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.white,
          ),
        ),
      ),
    ],
  ),
),  ],),),), ],),);
}
}
