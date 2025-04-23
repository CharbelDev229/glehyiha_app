import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/auth/login/login_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:glehiha/common/utils/text_field_validators.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final LoginController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  bool _autoValidate = false;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  void _onsubmit() {
    final isFormValid = controller.formKey.currentState!.validate();
    setState(() {
      _autoValidate = true;
    });

    if (isFormValid) {
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
          builder: (context, Constraints) {
            return Column(
              children: [
                const SizedBox(height: 150),
                Expanded(
                  child: Container(
                    width: 392,
                    height: 400,
                    constraints: BoxConstraints(
                      minHeight: Constraints.maxHeight - 150,
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
                              "Connexion",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Veuillez entrer vos identifiants",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 40),

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
                            const SizedBox(height: 8),

                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  context.pushNamed(
                                    AppRoutesNames.forgetpassword,
                                  );
                                },
                                child: const Text(
                                  "Mot de passe oublié?",
                                  style: TextStyle(
                                    color: AppColors.primaryGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Submit Button
                            Obx(() {
                              return CustomButton(
                                isLoading: controller.loginInLoading.value,
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
                                    controller.loginInLoading.value
                                        ? null
                                        : () {
                                          _onsubmit();
                                        },

                                child:
                                    controller.loginInLoading.value
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

                            // Bouton "Inscrivez-vous"
                            Obx(
                              () => CustomButton(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                onPressed:
                                    controller.loginInLoading.value
                                        ? null
                                        : null,
                                child:
                                    controller.loginInLoading.value
                                        ? CircularProgressIndicator()
                                        : const Text(
                                          "Inscrivez-vous",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.green,
                                          ),
                                        ),
                              ),
                            ),

                            const SizedBox(height: 30),
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
