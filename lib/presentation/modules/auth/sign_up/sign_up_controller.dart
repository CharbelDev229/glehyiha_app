import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/services/location_service.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../common/dtos/auth/register_dto.dart';
import '../../../../common/utils/utils.dart';
import '../../../../domain/usescases/auth/sign_up.dart';
import '../../../router/routes.dart';
import '../../order_detail/user_controller.dart';

class SignUpController {
  final SignUpUseCase signUpUseCase;
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'sign_up',
  );

  // Contrôleurs de formulaire
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController shopNameController = TextEditingController();

  TextEditingController specialisationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

 
  GlobalKey<FormState> nomPrenomFormKey = GlobalKey<FormState>(
    debugLabel: 'nom_prenom',
  );
  GlobalKey<FormState> emailPasswordFormKey = GlobalKey<FormState>(
    debugLabel: 'email_password',
  );
  GlobalKey<FormState> phoneLocalisationFormKey = GlobalKey<FormState>(
    debugLabel: 'phone_localisation',
  );

  // Variables observables
  RxString phoneNumber = ''.obs;
  Rx<UserRole> selectedRole = UserRole.agriculteur.obs;
  RxString selectedSexe = ''.obs;
  RxBool isChecked = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isLoading = false.obs;
  RxBool signUpInLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString selectedCountryCode = '+229'.obs;
  RxBool autoValidate = false.obs;

  // Variables de localisation
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool locationPermissionGranted = false.obs;
  RxBool isRequestingLocation = false.obs;

  SignUpController({required this.signUpUseCase});

  String getCompletePhoneNumber() {
    return selectedCountryCode.value + phoneNumberController.text.trim();
  }

  // Méthode pour demander la permission de localisation
  Future<bool> requestLocationPermission() async {
    isRequestingLocation.value = true;
    
    try {
      // Vérifier si les services de localisation sont activés
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Demander à l'utilisateur d'activer la localisation
        bool shouldEnable = await _showLocationServiceDialog();
        if (!shouldEnable) {
          isRequestingLocation.value = false;
          return false;
        }
        // L'utilisateur sera redirigé vers les paramètres
        await Geolocator.openLocationSettings();
        isRequestingLocation.value = false;
        return false;
      }

      // Vérifier les permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isRequestingLocation.value = false;
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Demander à l'utilisateur d'aller dans les paramètres
        bool shouldOpenSettings = await _showLocationPermissionDialog();
        if (shouldOpenSettings) {
          await Geolocator.openAppSettings();
        }
        isRequestingLocation.value = false;
        return false;
      }

      // Obtenir la position actuelle
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      locationPermissionGranted.value = true;
      
      isRequestingLocation.value = false;
      return true;
      
    } catch (e) {
      logger.e('Erreur lors de la récupération de la localisation: $e');
      isRequestingLocation.value = false;
      return false;
    }
  }

  // Dialog pour demander l'activation de la localisation
  Future<bool> _showLocationServiceDialog() async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Localisation requise'),
        content: const Text(
          'Pour les encadreurs, nous avons besoin de votre localisation pour vous connecter avec les agriculteurs proches. '
          'Voulez-vous activer la localisation ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Oui'),
          ),
        ],
      ),
    ) ?? false;
  }

  // Dialog pour demander l'ouverture des paramètres
  Future<bool> _showLocationPermissionDialog() async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Permission de localisation'),
        content: const Text(
          'La permission de localisation est nécessaire pour les encadreurs. '
          'Voulez-vous ouvrir les paramètres pour l\'activer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Ouvrir les paramètres'),
          ),
        ],
      ),
    ) ?? false;
  }

  Future<bool> register(BuildContext context) async {
    bool success = false;
    signUpInLoading.value = true;

    // Si c'est un encadreur, demander la localisation
    if (selectedRole.value == UserRole.encadreur) {
      bool locationGranted = await requestLocationPermission();
      if (!locationGranted) {
        Utils.snackError(
          context: context, 
          message: 'La localisation est requise pour les encadreurs. Veuillez l\'activer et réessayer.'
        );
        signUpInLoading.value = false;
        return false;
      }
    }

    final send = await signUpUseCase.call(
      SignUpParams(
        dto: RegisterDto(
          first_name: nomController.text,
          last_name: prenomController.text,
          email: emailController.text,
          password: passwordController.text,
          phone_number: getCompletePhoneNumber(),
          userRole: selectedRole.value,
          specialization: specialisationController.text,
          experience: experienceController.text,
          nom_boutique: shopNameController.text,
          latitude: selectedRole.value == UserRole.encadreur ? latitude.value : null,
          longitude: selectedRole.value == UserRole.encadreur ? longitude.value : null,
        ),
      ),
    );

    send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        Utils.snackSuccess(context: context, message: 'Inscription réussie!');
        success = true;

        // Mettre à jour le UserController
        try {
          final userController = Get.find<UserController>();
          userController.setUser(
            fName: nomController.text.trim(),
            lName: prenomController.text.trim(),
            mail: emailController.text.trim(),
          );
        } catch (e) {
          logger.w('UserController non trouvé: $e');
        }

        if (context.mounted) {
          context.pushNamed(
            AppRoutesNames.code,
            extra: emailController.text.trim(),
          );
        }
      },
    );

    signUpInLoading.value = false;
    return success;
  }
}