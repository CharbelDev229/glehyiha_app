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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/logo/logo.png", width: 94, height: 22),
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
                          widthFactor: 0.7, // 80% de l’écran
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
                          begin: const Offset(
                            1.0,
                            0.0,
                          ), // Animation depuis la droite
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
              child: CircleAvatar(
                radius: 29,
                backgroundColor: Colors.white,
                backgroundImage:
                    imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
                child:
                    imagePath.isEmpty
                        ? const Icon(Icons.person, color: Colors.grey, size: 30)
                        : null,
              ),
            ),
          ],
        ),
      );
    });
  }
}
