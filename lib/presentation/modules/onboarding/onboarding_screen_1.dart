import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/button/custom_button_with_icon.dart.dart';
import 'package:go_router/go_router.dart';
import 'package:glehiha/common/constants/assets/assets.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(70),
              ),
              child: Image.asset(
                Assets.images,
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Flexible(
                    child: Text(
                      'Obtenez des conseils agricoles personnalisés,',
                       style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      'Optimisez votre production agricole avec notre assistant intelligent',

                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: Utils.deviceW(context) * 0.6,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 94, 104, 77),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Identifiez les maladies des plantes en un clic ',

                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: Utils.deviceW(context) * 0.6,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 94, 104, 77),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Posez vos question à notre chatbot intelligent ',

                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomButtonWithIcon(
                    text: 'Suivant',
                    onPressed:
                        () => context.pushNamed(AppRoutesNames.onboarding2),
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
