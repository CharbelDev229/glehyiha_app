import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/domain/usescases/auth/reset_password.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordController {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordController({required this.resetPasswordUseCase});

  final formKey = GlobalKey<FormState>();

  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController resetcodeController = TextEditingController();

  final RxBool autoValidate = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> submitRequest(BuildContext context) async {
    autoValidate.value = true;
    errorMessage.value = '';
    isLoading.value = true;

    if (!(formKey.currentState?.validate() ?? false)) {
      isLoading.value = true;
      return;
    }

    final result = await resetPasswordUseCase.call(
      ResetPasswordParams(
        new_password: newpasswordController.text.trim(),
        reset_code: resetcodeController.text.trim(),
      ),
    );

    result.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
        isLoading.value = false;
      },
      (data) async {
        Utils.snackSuccess(context: context, message: "Mot de passe réinitialisé avec succès");

        if (context.mounted) {
          context.pushNamed(AppRoutesNames.signIn);
        }
        isLoading.value = false;
      },
    );
  }
}
