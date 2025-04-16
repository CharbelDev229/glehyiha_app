import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/router/routes.dart';

import 'package:glehiha/common/constants/instances.dart';

class ComplementInfoController extends GetxController {
  final formKeyEncadreur = GlobalKey<FormState>();
  final formKeyVendeur = GlobalKey<FormState>();

  TextEditingController specialisationController = TextEditingController();
  TextEditingController certificationController = TextEditingController();
  TextEditingController nomboutiqueController = TextEditingController();

  RxBool specialisation = false.obs;
  RxBool certification = false.obs;
  RxBool nomboutique = false.obs;

  void onSubmitEncadreur() {
    if (!formKeyEncadreur.currentState!.validate()) {
      Get.snackbar("Erreur", "Veuillez remplir correctement tous les champs");
      return;
    }

    Get.toNamed(AppRoutesNames.code);
  }

  void onsubmitVendeur() {
    if (!formKeyVendeur.currentState!.validate()) {
      Get.snackbar("Erreur", "Veuillez remplir correctement tous les champs");
      return;
    }
    Get.toNamed(AppRoutesNames.code);
  }

  @override
  void onInit() {
    logger.w('\nSignupController onClose\n\n');
    super.onInit();
  }

  @override
  void onClose() {
    logger.w('\nSignupController onClose\n\n');
    super.onClose();
  }
}
