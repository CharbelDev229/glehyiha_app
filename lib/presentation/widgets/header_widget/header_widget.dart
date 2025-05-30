import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

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
                context.pushNamed(AppRoutesNames.myprofile);
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
