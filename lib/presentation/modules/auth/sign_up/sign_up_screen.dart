import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/presentation/widgets/background_decoration/background_deco.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/enums/user_role.dart';
import '../../../../common/utils/text_field_validators.dart';
import '../../../router/routes.dart';
import '../../../widgets/button/custom_button.dart';

import '../../../widgets/custom_text_form_field/custom_text_form_field.dart';
import 'sign_up_controller.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.controller});
  final SignUpController controller;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackgroundDeco(
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Obx(
                () => Column(
                  children: [
                    SizedBox(height: Utils.deviceH(context) * 0.15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 30.0,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0,
                          ),
                          child: Form(
                            key: controller.formKey,
                            autovalidateMode:
                                controller.autoValidate.value
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 90,
                                  child: Divider(
                                    thickness: 2,
                                    color: AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                const Text(
                                  "Inscription",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Veuillez entrer vos informations",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                CustomTextFormField(
                                  controller: controller.nomController,
                                  validator: TextFieldValidators.required,
                                  labelText: "Nom",
                                  suffixIcon: const Icon(
                                    Icons.person,
                                    color: AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                CustomTextFormField(
                                  controller: controller.prenomController,
                                  validator: TextFieldValidators.required,
                                  labelText: "Prénom",
                                  suffixIcon: const Icon(
                                    Icons.person,
                                    color: AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  controller: controller.phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  labelText: 'Numéro de téléphone',
                                  validator: (value) {
                                    return TextFieldValidators.validatePhoneNumber(
                                      context: context,
                                      value:
                                          '${controller.selectedCountryCode.value}${value ?? ''}',
                                    );
                                  },
                                  prefixIcon: Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: CountryCodePicker(
                                      onChanged: (CountryCode code) {
                                        if (code.dialCode != null) {
                                          controller.selectedCountryCode.value =
                                              code.dialCode!;
                                        }
                                      },
                                      initialSelection:
                                          controller.selectedCountryCode.value,
                                      favorite: ['+229', 'BJ'],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: false,
                                      padding: EdgeInsets.zero,
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                DropdownButtonFormField<UserRole>(
                                  dropdownColor: AppColors.white,
                                  value: controller.selectedRole.value,
                                  decoration: InputDecoration(
                                    labelText: "Sélectionnez un rôle",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 16,
                                    ),
                                  ),
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      controller.selectedRole.value = newValue;
                                    }
                                  },
                                  items:
                                      UserRole.values.map((role) {
                                        return DropdownMenuItem<UserRole>(
                                          value: role,
                                          child: Text(
                                            role.name,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                ),

                                Visibility(
                                  visible:
                                      controller.selectedRole.value ==
                                              UserRole.vendeur
                                          ? true
                                          : false,

                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: CustomTextFormField(
                                      controller: controller.shopNameController,
                                      validator:
                                          controller.selectedRole.value ==
                                                  UserRole.vendeur
                                              ? TextFieldValidators.required
                                              : null,
                                      labelText: "Nom de votre boutique",
                                    ),
                                  ),
                                ),

                                Visibility(
                                  visible:
                                      controller.selectedRole.value ==
                                              UserRole.encadreur
                                          ? true
                                          : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: CustomTextFormField(
                                      controller: controller.shopNameController,
                                      validator:
                                          controller.selectedRole.value ==
                                                  UserRole.encadreur
                                              ? TextFieldValidators.required
                                              : null,
                                      labelText: "Expérience",
                                    ),
                                  ),
                                ),

                                Visibility(
                                  visible:
                                      controller.selectedRole.value ==
                                              UserRole.encadreur
                                          ? true
                                          : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: CustomTextFormField(
                                      controller:
                                          controller.specialisationController,
                                      validator:
                                          controller.selectedRole.value ==
                                                  UserRole.encadreur
                                              ? TextFieldValidators.required
                                              : null,
                                      labelText: "Spécialisation",
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Obx(
                                  () => CustomTextFormField(
                                    controller: controller.emailController,
                                    validator:
                                        !(controller.selectedRole.value !=
                                                UserRole.agriculteur)
                                            ? TextFieldValidators.validEmail
                                            : TextFieldValidators
                                                .requiredForRule,
                                    labelText: "Email",
                                    keyboardType: TextInputType.emailAddress,
                                    suffixIcon: const Icon(
                                      Icons.email,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Obx(
                                  () => CustomTextFormField(
                                    controller: controller.passwordController,
                                    validator:
                                        TextFieldValidators.strongPassword,
                                    labelText: "Mot de passe",
                                    obscureText:
                                        !controller.isPasswordVisible.value,
                                    suffixIcon: IconButton(
                                      onPressed:
                                          () =>
                                              controller.isPasswordVisible
                                                  .toggle(),
                                      icon: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Obx(
                                  () => CustomTextFormField(
                                    controller:
                                        controller.confirmPasswordController,
                                    validator: (value) {
                                      if (value !=
                                          controller.passwordController.text) {
                                        return "Les mots de passe ne correspondent pas";
                                      }
                                      return null;
                                    },
                                    labelText: "Confirmez mot de passe",
                                    obscureText:
                                        !controller
                                            .isConfirmPasswordVisible
                                            .value,
                                    suffixIcon: IconButton(
                                      onPressed:
                                          () =>
                                              controller
                                                  .isConfirmPasswordVisible
                                                  .toggle(),
                                      icon: Icon(
                                        controller
                                                .isConfirmPasswordVisible
                                                .value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),

                                Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                        value: controller.isChecked.value,
                                        onChanged: (newValue) {
                                          controller.isChecked.value =
                                              newValue!;
                                        },
                                        activeColor: AppColors.primaryGreen,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Je suis d’accord avec les termes et conditions d’utilisation",
                                            style: TextStyle(
                                              color: AppColors.textPrimary,
                                              fontSize: 16,
                                            ),
                                          ),
                                          if (controller.autoValidate.value &&
                                              !controller.isChecked.value)
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                top: 4.0,
                                              ),
                                              child: Text(
                                                'Vous devez accepter les conditions',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                Obx(
                                  () => CustomButton(
                                    isLoading: controller.isLoading.value,
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      43,
                                      131,
                                      68,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    onPressed:
                                        controller.isLoading.value
                                            ? null
                                            : () {
                                              if (controller
                                                      .formKey
                                                      .currentState
                                                      ?.validate() ??
                                                  false) {
                                               
                                              } else {
                                                // logger.w(
                                                //   controller
                                                //       .formKey
                                                //       .currentState,
                                                // );
                                                Utils.snackInfo(
                                                  context: context,
                                                  message:
                                                      'Une erreur est dans le formulaire',
                                                );
                                              }
                                            },

                                    child:
                                        controller.signUpInLoading.value
                                            ? const CircularProgressIndicator()
                                            : const Text(
                                              "Valider",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 16),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: "Vous avez déjà un compte? ",
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Connectez-vous",
                                        style: const TextStyle(
                                          color: AppColors.primaryGreen,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                context.pushNamed(
                                                  AppRoutesNames.signIn,
                                                );
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
