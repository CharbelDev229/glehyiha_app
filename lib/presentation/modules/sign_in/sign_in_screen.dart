import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/sign_in/sign_in_controller.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController controller = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryGreen,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Container(
                    width: constraints.maxWidth,
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 150,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
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
                          child: Divider(thickness: 2, color: AppColors.black),
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
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: controller.nomController,
                                labelText: "Nom",
                                suffixIcon: Icon(Icons.person, color: AppColors.black),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Veuillez entrer votre nom';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomTextFormField(
                                controller: controller.prenomController,
                                labelText: "Prénom",
                                suffixIcon: Icon(Icons.person, color: AppColors.black),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Veuillez entrer votre prénom';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              IntlPhoneField(
                                controller: controller.numController,
                                decoration: InputDecoration(
                                  labelText: 'Numéro',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                                onChanged: (phone) {
                                  controller.phoneNumber.value = phone.completeNumber;
                                },
                              ),
                              const SizedBox(height: 20),

                             
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() => DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: controller.selectedRole.value,
                                          hint: Text('Sélectionnez votre rôle'),
                                          items: controller.roles.map((String role) {
                                            return DropdownMenuItem<String>(
                                              value: role,
                                              child: Text(role),
                                            );
                                          }).toList(),
                                          onChanged: controller.setRole,
                                        ),
                                      )),
                                    ),
                                    
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                            
                              CustomTextFormField(
                                controller: controller.addressController,
                                labelText: "Adresse",
                                suffixIcon: Icon(Icons.location_on, color: AppColors.black),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre adresse';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),
                              CustomTextFormField(
                                controller: controller.emailController,
                                labelText: "Email",
                                suffixIcon: Icon(Icons.email, color: AppColors.black),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Veuillez entrer votre email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                             Obx(() =>  CustomTextFormField(
                                controller: controller.passwordController,
                                labelText: "Mot de passe",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.black,
                                  ),
                                  onPressed: () {
                                    controller.togglePasswordVisibility;
                                  },
                                ),
                                obscureText: !controller.isPasswordVisible.value,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Veuillez entrer votre mot de passe';
                                  }
                                  return null;
                                },
                              ),),
                              const SizedBox(height: 20),
                              Obx(() => CustomTextFormField(
                                    controller: controller.confirmPasswordController,
                                    labelText: "Confirmez le mot de passe",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isConfirmPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.black,
                                      ),
                                      onPressed:
                                          controller.toggleConfirmPasswordVisibility,
                                    ),
                                    obscureText:
                                        !controller.isConfirmPasswordVisible.value,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Veuillez confirmer votre mot de passe';
                                      }
                                      if (value != controller.passwordController.text) {
                                        return 'Les mots de passe ne correspondent pas';
                                      }
                                      return null;
                                    },
                                  )),
                              const SizedBox(height: 25),
                              Center(
                                child:Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                   Obx(
                                    () => Checkbox(
                                      value: controller.isChecked.value,
                                      onChanged: controller.toggleCheckbox,
                                      activeColor: const Color.fromARGB(255, 43, 131, 68),
                                      side: const BorderSide(
                                        color: AppColors.primaryGreen,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(fontSize: 16),
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: "Je suis d'accord avec ",
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "les termes et condition\n d'utilisation",
                                            style: const TextStyle(
                                              color: AppColors.primaryGreen,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),),
                              const SizedBox(height: 35),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      context.pushNamed(AppRoutesNames.parameters);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Valider",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w400,
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
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.pushNamed(AppRoutesNames.signUp);
                                        },
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
