import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/assets/assets.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:glehiha/presentation/widgets/gradient_background/gradient_background.dart';
import 'package:glehiha/presentation/widgets/side_by_side_images/side_by_side_images.dart';

import '../../../common/utils/utils.dart';
import '../../widgets/button/custom_button_with_icon.dart.dart';
import 'onboarding_controller.dart';

class OnboardingScreen3 extends StatefulWidget {
  final OnboardingController controller;
  const OnboardingScreen3({super.key, required this.controller});
   @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  
  late OnboardingController controller;

   @override
  void initState() {
    controller = widget.controller;
   
 controller.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackgroundScreen(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageRowWidget(imagePath1: Assets.shop, imagePath2: Assets.aa),
                const SizedBox(height: 20),
                Flexible(
                  child: const Text(
                    "Trouver tout ce dont vous avez besoin pour votre exploitation",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),

                Flexible(
                  child: const Text(
                    "Engrais, semences, pesticides... Achetez en toute sécurité ou vendez vos produits",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                    child: Text(
                      'Vendez vos récoltes et produits agricoles',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                      'Trouvez les meilleurs fournisseurs d’intrants agricoles',
                      maxLines: 3,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                      'Commandez en quelques clics',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: CustomButtonWithIcon(
                    text: 'Commencer',
                    onPressed: () => context.pushNamed(AppRoutesNames.signUp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
