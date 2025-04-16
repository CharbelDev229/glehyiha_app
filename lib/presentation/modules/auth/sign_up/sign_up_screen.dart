import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:glehiha/presentation/modules/auth/sign_up/sign_up_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/common/utils/text_field_validators.dart';

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
    child:Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 131, 68),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 400),
            Container(
              padding: const EdgeInsets.all(30.0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 90,
                    child: Divider(thickness: 2, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Connexion",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Veuillez entrer vos informations",
                    style: TextStyle(
                      color: Colors.black,
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
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                          ),
                          initialCountryCode: 'BJ',
                          showDropdownIcon: false,
                          disableLengthCheck: true,
                          flagsButtonPadding: EdgeInsets.zero,
                          showCountryFlag: true,
                          invalidNumberMessage: 'Numéro invalide',
                          style: const TextStyle(fontSize: 14),
                          dropdownTextStyle: const TextStyle(fontSize: 14),
                          keyboardType: TextInputType.number,
                          onChanged: (phone) {
                            controller.phoneNumber.value = phone.number;
                          },
                          validator: (value) {
                            if (value == null || value.number.isEmpty) {
                              return 'Veuillez entrer votre numéro';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => CustomTextFormField(
                            controller: controller.passwordController,
                            labelText: "Mot de passe",
                            validator: TextFieldValidators.strongPassword,
                            suffixIcon: IconButton(
                                    onPressed: (){
                                        controller.isPasswordVisible.value =
                                          !controller.isPasswordVisible.value;
                                    },
                                      icon: Obx((){
                                    return  Icon(
                                        color: AppColors.black,
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off);})))),
                           
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                // Navigue vers l'écran suivant après validation
                                context.push('/parameters_screen');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 43, 131, 68),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Se connecter",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                context.pushNamed('sign_in_screen');
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.green,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Créer un compte",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
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
     ) );
  }
}
