import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/auth/sign_in/sign_in_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/common/utils/text_field_validators.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.controller});
  final SignInController controller;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late SignInController controller;
  bool _autoValidate = false;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  void _onSubmit() {
    final isFormValid = controller.formKey.currentState!.validate();
    final isCheckboxChecked = controller.isChecked.value;

    if (isFormValid && isCheckboxChecked) {
      // Redirection si tout est OK
      context.pushNamed(AppRoutesNames.code);
    } else {
      setState(() {
        _autoValidate = true; // Pour déclencher l'affichage des erreurs
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryGreen,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 150),
                Expanded(
                  child: Container(
                    width: constraints.maxWidth,
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 150,
                    ),
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
                            _autoValidate
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
                            const SizedBox(height: 25),

                            // Nom Field
                            TextFormField(
                              controller: controller.nomController,
                              decoration: InputDecoration(
                                labelText: "Nom",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.black,
                                ),
                              ),
                              validator: TextFieldValidators.required,
                            ),
                            const SizedBox(height: 20),

                            // Prénom Field
                            TextFormField(
                              controller: controller.prenomController,
                              decoration: InputDecoration(
                                labelText: "Prénom",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.black,
                                ),
                              ),
                              validator: TextFieldValidators.required,
                            ),
                            const SizedBox(height: 20),

                            // Phone Field
                            IntlPhoneField(
                              controller: controller.numController,
                              decoration: InputDecoration(
                                labelText: 'Numéro',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                              ),
                              initialCountryCode: 'BJ',
                              showDropdownIcon: false,
                              disableLengthCheck: true,
                              flagsButtonPadding: EdgeInsets.zero,
                              showCountryFlag: true,
                              invalidNumberMessage: 'Numéro invalide',
                              style: TextStyle(fontSize: 14),
                              dropdownTextStyle: TextStyle(fontSize: 14),
                              initialValue: "+229",
                              keyboardType: TextInputType.phone,
                              onChanged: (phone) {
                                controller.phoneNumber.value = phone.number;
                              },
                              validator: (value) {
                                if (value == null || value.number.isEmpty) {
                                  return 'Ce champ est requis';
                                }
                                
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Role Dropdown
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => DropdownButton<UserRole>(
                                        value: controller.selectedRole.value,
                                        onChanged: (UserRole? newValue) {
                                          if (newValue != null) {
                                            controller.selectedRole.value =
                                                newValue;
                                          }
                                        },
                                        items:
                                            UserRole.values.map((
                                              UserRole role,
                                            ) {
                                              return DropdownMenuItem<UserRole>(
                                                value: role,
                                                child: Text(role.name),
                                              );
                                            }).toList(),
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        hint: Text('Sélectionnez un rôle'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Adresse Field
                            TextFormField(
                              controller: controller.addressController,
                              decoration: InputDecoration(
                                labelText: "Adresse",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                suffixIcon: Icon(
                                  Icons.location_on,
                                  color: AppColors.black,
                                ),
                              ),
                              validator: TextFieldValidators.required,
                            ),
                            const SizedBox(height: 20),

                            // Email Field
                            Obx(() {
                              return CustomTextFormField(
                                controller: controller.emailController,
                                validator: TextFieldValidators.validEmail,
                                maxLines: 1,
                                labelText: "Email",
                                keyboardType: TextInputType.emailAddress,
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: AppColors.black,
                                ),
                              );
                            }),
                            const SizedBox(height: 20),

                            // Password Field
                            Obx(() {
                              return CustomTextFormField(
                                controller: controller.passwordController,
                                validator: TextFieldValidators.strongPassword,
                                labelText: "Mot de passe",
                                obscureText:
                                    !controller.isPasswordVisible.value,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isPasswordVisible.value =
                                        !controller.isPasswordVisible.value;
                                  },
                                  icon: Obx(() {
                                    return Icon(
                                      color:
                                          controller.isPasswordVisible.value
                                              ? Colors.black
                                              : const Color(0XFF7C7C7C),
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    );
                                  }),
                                ),
                              );
                            }),
                            const SizedBox(height: 20),

                            // Confirm Password Field
                            Obx(() {
                              return CustomTextFormField(
                                controller: controller.confirmPasswordController,
                                validator: TextFieldValidators.strongPassword,
                                labelText: "Confirmez mot de passe",
                                obscureText:
                                    !controller.isPasswordVisible.value,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isPasswordVisible.value =
                                        !controller.isPasswordVisible.value;
                                  },
                                  icon: Obx(() {
                                    return Icon(
                                      color:
                                          controller.isPasswordVisible.value
                                              ? Colors.black
                                              : const Color(0XFF7C7C7C),
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    );
                                  }),
                                ),
                              );
                            }),
                            const SizedBox(height: 25),

                            // Terms Checkbox
                            Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: controller.isChecked.value,
                                    onChanged: (newValue) {
                                      controller.isChecked.value = newValue!;
                                    },
                                    activeColor: AppColors.primaryGreen,
                                  );
                                }),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Je suis d’accord avec les termes et conditions d’utilisation",
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                        ),
                                      ),
                                      if (_autoValidate &&
                                          !controller.isChecked.value)
                                        Padding(
                                          padding: const EdgeInsets.only(
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

                            // Submit Button
                            Obx(() {
                              return CustomButton(
                                isLoading: controller.isLoading.value,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  43,
                                  131,
                                  68,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                onPressed:
                                    controller.isLoading.value
                                        ? null
                                        : () {
                                          _onSubmit();
                                        },

                                child:
                                    controller.isLoading.value
                                        ? CircularProgressIndicator()
                                        : const Text(
                                          "Valider",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                              );
                            }),

                            const SizedBox(height: 20),

                            // Login Link
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
                                              AppRoutesNames.login,
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
            );
          },
        ),
      ),
    );
  }
}
