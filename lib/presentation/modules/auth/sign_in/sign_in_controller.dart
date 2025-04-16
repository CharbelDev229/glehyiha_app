import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:go_router/go_router.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'sign_in',
  );

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString phoneNumber = ''.obs;
  Rx<UserRole> selectedRole = UserRole.agriculteur.obs;
  RxBool isChecked = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

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
