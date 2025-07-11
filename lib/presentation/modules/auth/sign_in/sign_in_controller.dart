import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/auth/login.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/utils.dart';
import '../../../../data/models/user/glehiha_user_info.dart';
import '../../../router/routes.dart';
import '../../order_detail/user_controller.dart';
import '../../my_profile/my_profile_controller.dart';

class SignInController {
  final LoginUseCase loginUseCase;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs du formulaire
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Variables réactives
  final RxString selectedCountryCode = '+229'.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool autoValidate = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool loginInLoading = false.obs;

  SignInController({required this.loginUseCase});

  String getCompletePhoneNumber() {
    return selectedCountryCode.value + phoneNumberController.text.trim();
  }

  Future<bool> login(BuildContext context) async {
    bool success = false;
    loginInLoading.value = true;
    autoValidate.value = true;

    final send = await loginUseCase.call(
      LoginParams(
        password: passwordController.text,
        phoneNumber: getCompletePhoneNumber(),
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
        // try {
        //   final userController = Get.find<UserController>();
        //   userController.setUser(
        //     fName: userInfo.firstname ?? '',
        //     lName: userInfo.lastname ?? '',
        //     mail: userInfo.email ?? '',
        //     phone: userInfo.phonenumber ?? getCompletePhoneNumber(),
        //   );
        // } catch (e) {
        //   print('UserController non trouvé ou erreur: $e');
        // }

        // Mettre à jour le ProfileController

        if (context.mounted) {
          context.pushNamed(
            AppRoutesNames.parameters,
            extra: getCompletePhoneNumber(),
          );
        }
      },
    );

    loginInLoading.value = false;
    return success;
  }
}
