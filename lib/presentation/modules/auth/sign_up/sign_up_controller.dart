import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/services/location_service.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/dtos/auth/register_dto.dart';
import '../../../../common/utils/utils.dart';
import '../../../../domain/usescases/auth/sign_up.dart';
import '../../../router/routes.dart';

enum SignUpState { nomPrenom, emailPassword, phoneNumberlocalisation }

class SignUpController {
  Rx<SignUpState> signUpState = SignUpState.nomPrenom.obs;
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );
  RxInt index = 1.obs;
  final SignUpUseCase signUpUseCase;
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'sign_in',
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
  // Ajout de la variable manquante
  RxBool signUpInLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString selectedCountryCode = '+229'.obs;
  RxBool autoValidate = false.obs;

  // Variables de localisation
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  SignUpController({required this.signUpUseCase});

  void onPageChanged(int index) {
    this.index.value = index;
  }

  void onChangeStep({required int index}) {
    this.index.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
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

    logger.d('Inscription: ${nomController.text} ${prenomController.text}');

    final send = await signUpUseCase.call(
      SignUpParams(
        dto: RegisterDto(
          firstname: nomController.text,
          lastname: prenomController.text,
          email: emailController.text,
          password: passwordController.text,
          phoneNumber: phoneNumberController.text,
          userRole: selectedRole.value,
          specialisation: specialisationController.text,
          experience: experienceController.text,
          shopName: shopNameController.text,
        ),
      ),
    );

    send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (email) async {
        Utils.snackSuccess(context: context, message: 'Inscription réussie!');

        success = true;
        if (context.mounted) {
 context.pushNamed(AppRoutesNames.code);
                                                 
        }
      },
    );

    signUpInLoading.value = false;
    return success;
  }
}
