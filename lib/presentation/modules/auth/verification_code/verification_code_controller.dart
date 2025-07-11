import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/auth/resent_verification_code.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/domain/usescases/auth/verify_user_account.dart';

class VerificationCodeController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(
    debugLabel: 'verification_code',
  );
  final RxBool isLoading = false.obs;
  final RxBool isResendingCode = false.obs;

  final TextEditingController codeController = TextEditingController();

  final VerifyUserAccountUseCase verfyUserAccountUseCase;
  final ResentVerificationCodeUseCase resentVerificationCodeUseCase;

  final String email;

  VerificationCodeController({
    required this.verfyUserAccountUseCase,
    required this. resentVerificationCodeUseCase,
    required this.email,
  });

  Future<bool> verifyUserAccount(BuildContext context, String verification_code, String email) async {
    isLoading.value = true;
    bool success = false;

    final send = await verfyUserAccountUseCase.call(
      VerifyUserAccountParams(verification_code: verification_code, email: email),
    );

    send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (_) {
        Utils.snackSuccess(
          context: context,
          message: "Code vérifié avec succès.",
        );
        success = true;
      },
    );

    isLoading.value = false;
    return success;
  }

  Future<bool> resentVerificationCode(BuildContext context) async {
    isResendingCode.value = true;
    bool success = false;
    
   final send = await resentVerificationCodeUseCase.call(
  ResentVerificationCodeParams(email:email),
);


    send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (data) {
          print('REPONSE FINAL DU CODE : $data');
        Utils.snackSuccess(
          context: context,
          message: "Code renvoyé avec succès.",
        );
        success = true;
      },
    );

    isResendingCode.value = false;
    return success;
  }
  
}
