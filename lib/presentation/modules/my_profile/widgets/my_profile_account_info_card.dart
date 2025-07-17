import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../service/profile_service.dart';
import '../../../widgets/avatar/custom_avatar.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/custom_gradient_text.dart';
import '../my_profile_controller.dart';

class MyProfileAccountInfoCard extends StatelessWidget {
  const MyProfileAccountInfoCard({super.key, required this.controller});

  final MyProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return GestureDetector(
              onTap: () async {
                await pickImageFromGallery();
                Get.find<ProfileService>().pickImage();
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    controller.profileService.profileImagePath.value.isNotEmpty
                        ? FileImage(
                          File(
                            controller.profileService.profileImagePath.value,
                          ),
                        )
                        : null,
                child:
                    controller.profileService.profileImagePath.value.isEmpty
                        ? const Icon(Icons.person, size: 50)
                        : null,
              ),
            );
          }),

          const SizedBox(height: 12),

          Obx(() {
            return CustomGradientText(
              controller.profileService.currentUser.value?.pseudo ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF563267),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
              ),
            );
          }),

          const SizedBox(height: 8),

          Obx(() {
            var user = controller.profileService.currentUser.value;
            return Text(
              [
                if ((user?.firstName.isNotEmpty ?? false) ||
                    (user?.lastName.isNotEmpty ?? false))
                  [
                    if (user?.firstName.isNotEmpty ?? false) user!.firstName,
                    if (user?.lastName.isNotEmpty ?? false) user!.lastName,
                  ].join(' '),
                if (user?.email?.isNotEmpty ?? false) user!.email,
              ].join(' | '),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF563267),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            );
          }),

          const SizedBox(height: 16),

          // CustomButton(
          //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          //   gradient: const LinearGradient(
          //     begin: Alignment.bottomCenter,
          //     end: Alignment.topCenter,
          //     colors: [
          //       Color.fromARGB(255, 237, 231, 240),
          //       Color.fromARGB(255, 234, 229, 236),
          //     ],
          //   ),
          //   border: Border.all(
          //     color: const Color.fromARGB(255, 224, 221, 226).withOpacity(0.5),
          //   ),
          //   borderRadius: BorderRadius.circular(999),
          //   onPressed: () {
          //     controller.showUpdateProfileDialog(context: context);
          //   },
          //   child: const Text(
          //     "Compléter le profil",
          //     style: TextStyle(
          //       color: Color.fromARGB(255, 12, 12, 11),
          //       fontWeight: FontWeight.w700,
          //       fontStyle: FontStyle.italic,
          //       fontSize: 15,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

Future<void> pickImageFromGallery() async {
  final picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final profileService = Get.find<ProfileService>();
    profileService.updateProfileImage(image.path);
  }
}
