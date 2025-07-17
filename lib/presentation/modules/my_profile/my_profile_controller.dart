import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/constants/storage_keys.dart';
import '../../service/profile_service.dart';
import 'models/profile_view_select_item.dart';

class MyProfileController {
  final ProfileService profileService = Get.find();

  Rxn<ProfileViewSelectItem> profileViewSelectItem =
      Rxn<ProfileViewSelectItem>();

  late SharedPreferences prefs;

  void onReady() async {
    prefs = await SharedPreferences.getInstance();
    if (hasToken) {
      await onGetMyProfile();
    }
  }

  bool get hasToken {
    final tokenP = prefs.getString(StorageKeys.token);
    return tokenP != null && tokenP.isNotEmpty;
  }

  Future<void> setToken(String token) async {
    await prefs.setString(StorageKeys.token, token);
  }

  Future<void> onGetMyProfile() async {
    bool success = await profileService.onGetMyProfile();
    if (!success) {
      // gérer l'erreur ici si besoin
      print('Erreur lors de la récupération du profil');
    }
  }

  Future<void> onLogout() async {
    // Suppression du token
    await prefs.remove(StorageKeys.token);

    // Nettoyer le profil utilisateur
    profileService.clearCurrentUser();
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileService.updateProfileImage(image.path);
      
    }
  }

  void showUpdateProfileDialog({required BuildContext context}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          title: const Text('Mettre à jour le profil'),
          content: const Text('Contenu du dialogue ici'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

        return SlideTransition(position: slideAnimation, child: child);
      },
    );
  }
}
