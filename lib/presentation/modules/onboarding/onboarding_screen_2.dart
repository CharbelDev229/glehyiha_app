import 'package:flutter/material.dart';
import 'package:glehiha/presentation/router/routes.dart';

import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/common/constants/assets/assets.dart';

import '../../../common/utils/utils.dart';
import '../../widgets/button/custom_buttom_w.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SingleChildScrollView(
        child: Column(
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
                    height: 360,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Text(
                    'Prenez une photo et obtenez un diagnostic instantané',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: const Text(
                      'Notre IA reconnaît les maladies des plantes et vous donne des solutions adaptées.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(Assets.image, width: 133, height: 100),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: Utils.deviceW(context) * 0.8,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 94, 104, 77),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        'Les taches sur cette feuille indiquent une possible infection fongique. Il peut s’agir de la tache septorienne. Voici quelques solutions...',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButtomW(
                    previousRoute: AppRoutesNames.onboarding1,
                    nextRoute: AppRoutesNames.onboarding3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
