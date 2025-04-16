import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/assets/assets.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:glehiha/presentation/widgets/gradient_background/gradient_background.dart';
import 'package:glehiha/presentation/widgets/side_by_side_images/side_by_side_images.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackgroundScreen(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
      body: Padding(
         padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageRowWidget(
          imagePath1: Assets.shop,
          imagePath2: Assets.aa),
          Text("Trouver tout ce dont vous avez besoin pour votre exploitation",
             maxLines: 3,
             overflow: TextOverflow.ellipsis,
             softWrap: true,
             style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
             )),
             Text("Engrais, semences, pesticides...Achetez en toute sécurité ou vendez vos produits",
             maxLines: 3,
             overflow: TextOverflow.ellipsis,
             softWrap: true,
             style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w100,
              color: AppColors.white),),
              SizedBox(height: 10,),
               Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 94, 104, 77),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Vendez vos récoles et produits agricoles',
                        maxLines: 2,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),   
                  SizedBox(height: 10,),

                   Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 94, 104, 77),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Trouvez les meilleurs fournisseurs dintrants agricoles',
                        maxLines: 2,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                   Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 94, 104, 77),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Commandez en quelques clics ',
                        maxLines: 2,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
               SizedBox(height: 25,),
            
                ElevatedButton(
                  onPressed: () => context.pushNamed(AppRoutesNames.signIn),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Commencez',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),),
                ),
               
          ]  ),
          
        ),
      ),
      );
  }
}