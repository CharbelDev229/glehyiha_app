import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/domain/usescases/auth/login.dart';
import 'package:glehiha/domain/usescases/user/get_profile.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/utils.dart';
import '../../../../data/models/user_model.dart';
import '../../../router/routes.dart';
import '../../controller/user_seller_cpntroller.dart';
import '../../order_detail/user_controller.dart';

class SignInController {
  final LoginUseCase loginUseCase;
  final GetProfileUseCase getProfileUseCase;

  final UserSellerController userSellerController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxString selectedCountryCode = '+229'.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool autoValidate = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool loginInLoading = false.obs;

  SignInController({
    required this.loginUseCase,
    required this.getProfileUseCase,
  });

  String getCompletePhoneNumber() {
    return selectedCountryCode.value + phoneNumberController.text.trim();
  }


  /// ✅ Fonction qui convertit le texte reçu par l’API en `UserRole`
  UserRole mapApiRoleToUserRole(String? role) {
    switch (role?.toLowerCase()) {
      case 'seller':
        return UserRole.vendeur;
      case 'expert':
        return UserRole.encadreur;
      case 'farmer':
      case 'agriculteur':
        return UserRole.agriculteur;
      default:
        return UserRole.agriculteur;
    }
  }

  Future<bool> login(BuildContext context) async {
    bool success = false;
    loginInLoading.value = true;
    autoValidate.value = true;

    final send = await loginUseCase.call(
      LoginParams(
        password: passwordController.text,
        phoneNumber: getCompletePhoneNumber(),
      ),
    );

    await send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        Utils.snackSuccess(context: context, message: 'Connexion réussie!');
        success = true;

        // 🔁 Appel de l’API /profile pour récupérer le rôle
        final profileResult =
            await getProfileUseCase.call(const GetProfileParams());

        profileResult.fold(
          (fail) => print('Erreur récupération profil : ${fail.message}'),
          (user) async {
            final roleEnum = mapApiRoleToUserRole(user.role);
            userSellerController.setRole(roleEnum);
            print('🎯 Rôle défini : $roleEnum');


          //    if (roleEnum == UserRole.vendeur) {
          //   await userSellerController.initVendeur(); // ← placé ici proprement
          // }
          },
        );




        try {
        final userController = Get.find<UserController>();

        // ✅ On extrait les données de "data"
         final responseMap = response as Map<String, dynamic>;
        final userMap = (responseMap['data'] as Map<String, dynamic>);

        // ✅ On crée l'utilisateur avec UserModel
        final user = UserModel.fromMap(userMap);

        // ✅ On met à jour le UserController
        userController.setUserData(user);

      } catch (e) {
        print('❌ Erreur de récupération des infos utilisateur : $e');
      }

        if (context.mounted) {
          context.pushNamed(
            AppRoutesNames.parameters,
            extra: getCompletePhoneNumber(),
          );
        }
      },
    );

    loginInLoading.value = false;
    return success;
  }
}
