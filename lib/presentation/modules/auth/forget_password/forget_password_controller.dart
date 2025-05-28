import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/auth/forgot_password.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordController {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgetPasswordController({required this.forgotPasswordUseCase});

  final formKey = GlobalKey<FormState>();
  
  final TextEditingController emailController = TextEditingController();

  final RxString selectedCountryCode = '+229'.obs;
  final RxBool autoValidate = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;


  Future<void> submitRequest(BuildContext context) async {
    autoValidate.value = true;
    errorMessage.value = '';
    isLoading.value = true;

    if (!(formKey.currentState?.validate() ?? false)) {
      isLoading.value = false;
      return;
    }

    final send = await forgotPasswordUseCase.call(
      ForgotPasswordParams(
        
        email: emailController.text.trim(),
      ),
    );

    send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
        isLoading.value = false;
      },
      (data) async {
        Utils.snackSuccess(context: context, message: "Un code a été envoyé");

        if (context.mounted) {
          context.pushNamed(
            AppRoutesNames.resetcode,
            extra: emailController.text,
          );
        }
        isLoading.value = false;
      },
    );
  }
}
