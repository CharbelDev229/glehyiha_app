import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/auth/sign_in/sign_in_controller.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/common/utils/text_field_validators.dart';
import 'package:glehiha/presentation/widgets/custom_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.controller});
final SignInController controller;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late SignInController controller ;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 40.0,
                    ),
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
                       
                              CustomTextFormField(
                                controller: controller.nomController,
                                labelText: "Nom",
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.black,
                                ),
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
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.black,
                                ),
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
                                  contentPadding: EdgeInsets.symmetric(
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
                                style: TextStyle(fontSize: 14),
                                dropdownTextStyle: TextStyle(fontSize: 14),
                                initialValue: "+229",
                                keyboardType: TextInputType.number,
                                onChanged: (phone) {
                                  controller.phoneNumber.value = phone.number;
                                },
                                validator: (value) {
                                  if (value == null || value.number.isEmpty) {
                                    return 'Veuillez entrer votre numéro';
                                  }
                                  if (!value.isValidNumber()) {
                                    return 'Numéro invalide';
                                  }
                                  return null;
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
                                      child: Obx(
                                        () => DropdownButton<UserRole>(
                                          
                                          value: controller.selectedRole.value,
                                          onChanged: (UserRole? newValue) {
                                            
                                          },
                                          items:
                                              UserRole.values.map((
                                                UserRole role,
                                              ) {
                                                return DropdownMenuItem<
                                                  UserRole
                                                >(
                                                  value: role,
                                                  child: Text(role.name),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              CustomTextFormField(
                                controller: controller.addressController,
                                labelText: "Adresse",
                                suffixIcon: Icon(
                                  Icons.location_on,
                                  color: AppColors.black,
                                ),
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
                                keyboardType: TextInputType.emailAddress,
                                validator: TextFieldValidators.validEmail,
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: AppColors.black,
                                ),),
      
                              
                              const SizedBox(height: 20),
                              Obx(
                                () => CustomTextFormField(
                                  controller: controller.passwordController,
                                  labelText: "Mot de passe",
                                  validator: TextFieldValidators.strongPassword,
                                  maxLines: 1,
                                  obscureText:
                                      !controller.isPasswordVisible.value,
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
                             SizedBox(height: 20),
                              Obx(
                                () => CustomTextFormField(
                                  controller:
                                      controller.confirmPasswordController,
                                  labelText: "Confirmez le mot de passe",
                                   validator: TextFieldValidators.validConfirmPassword,
                                  maxLines: 1,
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.isPasswordVisible.value =
                                          !controller.isPasswordVisible.value;
                                    },
                                    icon: Obx((){
                                 return   Icon(
                                    color: AppColors.black,
                                      controller.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,);})))),
                                    
                                    
                               SizedBox(height: 25),
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      value: controller.isChecked.value,
                                      onChanged: (newValue){
                                        controller.isChecked.value = newValue!;
                                      },
                                      activeColor: AppColors.primaryGreen,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "J'accepte les conditions d'utilisation",
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
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
                              "Valider",
                              style: TextStyle(
                                fontSize: 16,
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
                                                AppRoutesNames.signUp,
                                              );
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                ))]));})));
         
              
                
              
            
    
  }
}
