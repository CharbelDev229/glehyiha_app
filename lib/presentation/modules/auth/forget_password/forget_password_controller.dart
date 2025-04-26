import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:glehiha/common/constants/instances.dart';

class ForgetPasswordController extends GetxController {
final formKey = GlobalKey<FormState>();

 
  TextEditingController phoneNumberController = TextEditingController();


   RxString phoneNumber = ''.obs;
    RxString selectedCountryCode = '+229'.obs;
     RxBool autoValidate = false.obs;
 
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    logger.w('\nSignupController onClose\n\n');
    super.onInit();
  }

  @override
  void onClose() {
    logger.w('\nSignupController onClose\n\n');
    super.onClose();
  }
}
