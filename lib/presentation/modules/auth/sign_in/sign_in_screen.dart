import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/background_decoration/background_deco.dart';

import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/auth/sign_in/sign_in_controller.dart';

import 'package:glehiha/common/utils/text_field_validators.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';

import '../../../../common/utils/utils.dart';
import '../../../widgets/button/custom_button.dart';

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
    child: BackgroundDeco(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(
              () => Column(
                children: [
                  SizedBox(height: Utils.deviceH(context) * 0.33),
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
                             Text(
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
                            const SizedBox(height: 25),

                            // Phone Field
                     
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
                            // Password Field
                            CustomTextFormField(
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
                              ),
                            
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
                            const SizedBox(height: 5),

                            // Submit Button
                            Obx(() =>
                               CustomButton(
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
                              ),
                            ),

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
                                        : (){context.pushNamed(AppRoutesNames.signUp);},
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
             ) );
          },
        ),
      ),
  ));
  }
}
