import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:glehiha/common/constants/instances.dart';



class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'login',
  );

 
  TextEditingController numController = TextEditingController();
 
  TextEditingController passwordController = TextEditingController();
  

  RxString phoneNumber = ''.obs;
  RxBool isPasswordVisible = false.obs;


  RxBool loginInLoading = false.obs;

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
}
