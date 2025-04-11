import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final numController = TextEditingController();
  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();

  var phoneNumber = ''.obs;  
  
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

 

  void submitForm() {
    if (formKey.currentState!.validate()) {
      Get.snackbar("Succès", "Formulaire validé!");
    } else {
      Get.snackbar("Erreur", "Veuillez corriger les champs invalides.");
    }
  }

  @override
  void onClose() {
    numController.dispose();
     passwordController.dispose();
    super.onClose();
  }
}
