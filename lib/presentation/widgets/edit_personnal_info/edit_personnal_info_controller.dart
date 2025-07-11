import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/domain/usescases/user/change_password.dart';
import 'package:glehiha/domain/usescases/user/get_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/dtos/profile_dto/change_pwd_dto.dart';
import '../../../common/dtos/profile_dto/profile_dto.dart';
import '../../../common/enums/user_role.dart';
import '../../../domain/usescases/user/update_profile.dart';
import '../../router/routes.dart';

class ModifyController {
  final formKey = GlobalKey<FormState>();
   final GetProfileUseCase getProfileUseCase = Get.find<GetProfileUseCase>();
  final UpdateProfileUseCase updateProfileUseCase = Get.find<UpdateProfileUseCase>();
  final ChangePasswordUseCase changePasswordUseCase = Get.find<ChangePasswordUseCase>();
   

  // Contrôleurs de champs
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController numController = TextEditingController();

  // Obx variables
  RxBool isLoading = false.obs;
  RxBool autoValidate = false.obs;
  RxBool isOldPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxString selectedCountryCode = '+229'.obs;

  Rx<UserRole> selected = UserRole.agriculteur.obs;
  
   final Map<String, RxBool> isEditing = {
  "Nom": false.obs,
  "Prénom": false.obs,
  "Téléphone": false.obs,
};


  RxBool showPasswordForm = false.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);


  void toggleEdit(String key) {
    isEditing[key]!.value = !isEditing[key]!.value;
  }

  void togglePasswordForm() {
    showPasswordForm.value = !showPasswordForm.value;
  }

  void pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = image;
    }
  }

  String getCompletePhoneNumber() {
    return selectedCountryCode.value + numController.text.trim();
  }

  Future<void> loadUserInfo(BuildContext context) async {
    isLoading.value = true;

    final send = await getProfileUseCase.call(const GetProfileParams());

    send.fold(
      (failure) {
        Utils.snackError(context: context, message: "Échec de chargement des infos");
      },
      (user) {
        nomController.text = user.firstName;
        prenomController.text = user.lastName;
        emailController.text = user.email;
        numController.text = user.phoneNumber;
        selectedCountryCode.value = '+229';
      },
    );

    isLoading.value = false;
  }

  Future<bool> submitEditPersonnalInfo(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      autoValidate.value = true;
      return false;
    }

    isLoading.value = true;
    bool success = false;

    final profileDto = ProfileDto(
      firstname: nomController.text.trim(),
      lastname: prenomController.text.trim(),
      phoneNumber: getCompletePhoneNumber(),
    );

    final updateSend = await updateProfileUseCase.call(
      UpdateProfileParams(profileDto: profileDto, email: emailController.text.trim()),
    );

    await updateSend.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        if (oldPasswordController.text.isNotEmpty &&
            newPasswordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty) {
          if (newPasswordController.text != confirmPasswordController.text) {
            Utils.snackError(
              context: context,
              message: "Les mots de passe ne correspondent pas.",
            );
            isLoading.value = false;
            return false;
          }

          final pwdDto = ChangePwdDto(
            oldPassword: oldPasswordController.text.trim(),
            newPassword: newPasswordController.text.trim(),
          );

          final pwdSend = await changePasswordUseCase.call(
            ChangePasswordParams(newPwdDto: pwdDto),
          );

          pwdSend.fold(
            (failure) {
              Utils.snackError(context: context, message: failure.message);
            },
            (response) {
              Utils.snackSuccess(context: context, message: "Mot de passe changé !");
            },
          );
        }

        Utils.snackSuccess(context: context, message: "Profil mis à jour !");
        success = true;

        if (context.mounted) {
          context.pushNamed(AppRoutesNames.myprofile);
        }
      },
    );

    isLoading.value = false;
    return success;
  }

 

}
