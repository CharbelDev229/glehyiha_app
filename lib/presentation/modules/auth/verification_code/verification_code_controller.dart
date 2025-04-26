import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:glehiha/common/constants/instances.dart';

class VerificationCodeController extends GetxController {
final formKey = GlobalKey<FormState>();
 GlobalKey<FormState> loginFormKey =
  GlobalKey<FormState>(debugLabel: 'verification_code');


 
  TextEditingController codeController = TextEditingController();


   RxString code = ''.obs;
   RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;
  RxBool autoValidate = false.obs;

  @override
  void onInit() {
    logger.w('\nVerificationCodeController onClose\n\n');
    super.onInit();
  }

  @override
  void onClose() {
    logger.w('\nVerificationCodeController onClose\n\n');
    super.onClose();
  }
}
