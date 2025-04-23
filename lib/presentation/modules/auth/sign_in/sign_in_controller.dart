import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/services/location_service.dart';
import 'package:glehiha/presentation/router/go_router.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

class SignInController {
  final formKey = GlobalKey<FormState>();

  // Contrôleurs de formulaire
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Variables observables
  RxString phoneNumber = ''.obs;
  Rx<UserRole> selectedRole = UserRole.agriculteur.obs;
  RxString selectedSexe = ''.obs;
  RxBool isChecked = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxBool autoValidate = false.obs;

  // Variables de localisation
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  TextEditingController phoneNumberController = TextEditingController();
  RxString selectedCountryCode = '+229'.obs;

  Future<void> getCurrentLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        latitude.value = position.latitude.toString();
        longitude.value = position.longitude.toString();
      }
    } catch (e) {
      logger.e('Erreur de localisation: $e');
    }

    void onRoleSelected(BuildContext context) {
      if (selectedRole.value == UserRole.agriculteur) {
        // Si le rôle est Agriculteur, va vers l'écran de vérification du code
        context.pushNamed(AppRoutesNames.code);
      } else if (selectedRole.value == UserRole.encadreur) {
        // Si le rôle est Encadreur, va vers un autre écran
        context.pushNamed(AppRoutesNames.encadreur);
      } else if (selectedRole.value == UserRole.vendeur) {
        // Si le rôle est Vendeur, va vers un autre écran
        context.pushNamed(AppRoutesNames.vendeur);
      } else {
        // Gère un rôle non sélectionné ou incorrect
        errorMessage.value = "Rôle non valide sélectionné.";
      }
    }
  }
}
