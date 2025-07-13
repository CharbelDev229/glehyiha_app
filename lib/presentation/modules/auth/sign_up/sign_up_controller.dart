import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/services/location_service.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/dtos/auth/register_dto.dart';
import '../../../../common/utils/utils.dart';
import '../../../../data/models/user_model.dart';
import '../../../../domain/usescases/auth/sign_up.dart';
import '../../../router/routes.dart';
import '../../controller/user_seller_cpntroller.dart';
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
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  SignUpController({required this.signUpUseCase});

  String getCompletePhoneNumber() {
    return selectedCountryCode.value + phoneNumberController.text.trim();
  }

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
  }

  Future<bool> register(BuildContext context) async {
    bool success = false;
    signUpInLoading.value = true;

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

        final roleEnum = selectedRole.value;
    final sellerController = Get.find<UserSellerController>();
    sellerController.setRole(roleEnum);

    // try {
    //       final userController = Get.find<UserController>();
    //       userController.setAddressAndComment(
    //         adress: adresseController.text.trim(),
    //         comment: commentaireController.text.trim(),
    //         phone: getCompletePhoneNumber(),
    //       );

    //       fName.f
    // lastName.value = lName;
    // email.value = mail; 
    //     } catch (e) {
    //       logger.w('UserController non trouvé: $e');
    //     }

        // Mettre à jour le UserController
        
        // Mettre à jour le ProfileController
        
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
