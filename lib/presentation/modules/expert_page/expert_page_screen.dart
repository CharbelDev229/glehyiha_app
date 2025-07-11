import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:glehiha/common/constants/colors.dart';
import '../../../common/constants/assets/assets.dart';
import '../../../common/utils/utils.dart';
import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';

class ExpertPageScreen extends StatelessWidget {
  const ExpertPageScreen({super.key, required String name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
             HeaderWidget(),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(Assets.expert, width: 109, height: 109),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Dr Maria Rodriguez',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Spécialiste des maladies des cultures',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Image.asset(Assets.location, width: 30, height: 30),
                      const SizedBox(width: 8),
                      const Text(
                        'Dogo, Plateau, Bénin',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Expert en conseils et solutions agricoles pour les agriculteurs locaux. Disponible pour les consultations, des visites sur le terrain et un accompagnement continu de vos exploitations agricoles.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          //  borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image.asset(Assets.phone, width: 24, height: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'Appeler',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          //borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image.asset(Assets.message, width: 24, height: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'Message',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
