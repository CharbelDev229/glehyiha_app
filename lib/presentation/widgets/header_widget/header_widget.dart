import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/my_profile/my_profile_sreen.dart';
import '../../service/profile service .dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});

  final ProfileService profileService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final imagePath = profileService.profileImagePath.value;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        // margin: const EdgeInsets.only(bottom: 8, top: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Texte GLEHYIHA avec le style exact de Figma
            Text(
              'GLEHYIHA',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF097A41),
                fontSize: 17,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
                height: 1.29,
              ),
            ),

            // Avatar avec les dimensions de Figma
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    barrierDismissible: true,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Material(
                            color: Colors.white,
                            elevation: 8,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            child: const MyProfileScreen(),
                          ),
                        ),
                      );
                    },
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                    reverseTransitionDuration: const Duration(
                      milliseconds: 300,
                    ),
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                  image:
                      imagePath.isNotEmpty
                          ? DecorationImage(
                            image: FileImage(File(imagePath)),
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
                child:
                    imagePath.isEmpty
                        ? Icon(Icons.person, color: Colors.grey, size: 30)
                        : null,
              ),
            ),
          ],
        ),
      );
    });
  }
}
