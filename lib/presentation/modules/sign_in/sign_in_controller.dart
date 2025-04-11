import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final numController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final addressController = TextEditingController();

  var name = ''.obs;
  var prenom = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  var selectedRole = 'Agriculteur'.obs;
  var roles = ['Agriculteur', 'Vendeur', 'Encadreur'].obs;

  var isChecked = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void setRole(String? role) {
    if (role != null) {
      selectedRole.value = role;
    }
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }

  void resetForm() {
    nomController.clear();
    prenomController.clear();
    numController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    addressController.clear();
    isChecked.value = false;
  }

  void signIn() {
    if (!isChecked.value) {
      Get.snackbar("Erreur", "Vous devez accepter les conditions.");
      return;
    }

    @override
    void onClose() {
      nomController.dispose();
      prenomController.dispose();
      numController.dispose();
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      addressController.dispose();
      super.onClose();
    }
  }
}
