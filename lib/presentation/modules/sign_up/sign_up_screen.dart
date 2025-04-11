import 'package:flutter/material.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:glehiha/presentation/modules/sign_up/sign_up_controller.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:glehiha/common/constants/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 456),
            Container(
              padding: const EdgeInsets.all(30.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    child: Divider(thickness: 2, color: AppColors.black),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Inscription",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Veuillez entrer vos informations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        IntlPhoneField(
                          controller: controller.numController,
                          decoration: InputDecoration(
                            labelText: 'Numéro',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          ),
                          initialCountryCode: 'BJ',
                          showDropdownIcon: false,
                          disableLengthCheck: false,
                          flagsButtonPadding: EdgeInsets.zero,
                          showCountryFlag: true,
                          invalidNumberMessage: 'Numéro invalide',
                          style: const TextStyle(fontSize: 14),
                          dropdownTextStyle: const TextStyle(fontSize: 14),
                          initialValue: "+229",
                          onChanged: (phone) {
                            controller.phoneNumber.value = phone.completeNumber;
                          },
                          validator: (value) {
                            if (value == null || !value.isValidNumber()) {
                              return 'Veuillez entrer votre numéro de téléphone';
                            }
                            return value.toString();
                          },
                        ),

                        const SizedBox(height: 20),

                        CustomTextFormField(
                          controller: controller.passwordController,
                          labelText: "Mot de passe",
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.black,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          obscureText: !controller.isPasswordVisible.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate() && 
                                  controller.phoneNumber.value.isNotEmpty) {
                                context.push(AppRoutesNames.parameters);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Veuillez remplir tous les champs'),
                                    backgroundColor: AppColors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "S'inscrire",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textWhite,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => context.pushNamed(AppRoutesNames.signIn),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: AppColors.borderGreen,
                                width: 1,
                              ),
                              backgroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Inscrivez-vous",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textGreen,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
