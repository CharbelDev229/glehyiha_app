import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/domain/usescases/auth/login.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/utils.dart';

class SignInController extends GetxController {
    final LoginUseCase loginUseCase;
   
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'sign_in',
  );

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  RxString phoneNumber = ''.obs;
  RxBool isPasswordVisible = false.obs;
  RxString errorMessage = ''.obs;
  RxString selectedCountryCode = '+229'.obs;
  RxBool autoValidate = false.obs;

  RxBool loginInLoading = false.obs;
  



  SignInController(
      {required this.loginUseCase});

  
  @override
  void onInit() {
    logger.w('\nSignInController onInit\n\n');
    super.onInit();
  }

  @override
  void onClose() {
    logger.w('\nSignInController onClose\n\n');
    super.onClose();
  }


  //  Future<bool> login(BuildContext context) async {
  //   bool success = false;
  //   loginInLoading.value = true;


  //   final send = await loginUseCase.call(LoginParams(
  //     password: passwordController.text,
  //     phoneNumber: phoneNumberController.text,
  //   ));

  //   send.fold(
  //         (failure) {
  //       Utils.snackError(
  //         context: context,
  //         message: failure.message,
  //       );
  //     },
  //         (message) async {
  //       return await profileController.onGetMyProfile().then((value) {
  //         success = value;
  //         if (value) {
  //           if(context.mounted) {
  //             Utils.snackSuccess(
  //             context: context,
  //             message: 'Message réusie',
  //           );
  //           }
  //         }
  //       });
  //     },
  //   );

  //   loginInLoading.value = false;
  //   return success;
  // }
}
