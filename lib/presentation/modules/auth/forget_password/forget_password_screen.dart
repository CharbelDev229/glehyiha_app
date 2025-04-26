import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/widgets/background_decoration/background_deco.dart';
import 'package:go_router/go_router.dart';

import 'package:glehiha/presentation/router/routes.dart';

import 'package:glehiha/presentation/modules/auth/forget_password/forget_password_controller.dart';

import '../../../../common/utils/text_field_validators.dart';
import '../../../../common/utils/utils.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/custom_text_form_field/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key, required this.controller});
  final ForgetPasswordController controller;

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordController controller;
  bool _autoValidate = false;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  void _onSubmit() {
    final isFormValid = controller.formKey.currentState!.validate();

    if (isFormValid) {
      context.pushNamed(
        AppRoutesNames.code,
      ); // ou context.pushNamed(...) si tu utilises go_router
    } else {
      setState(() {
        _autoValidate = true;
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
                                const Text(
                                  "Mot de passe oublié",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Veuillez entrer votre numéros de téléphone utilisé pour l'inscription",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
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

                                const SizedBox(height: 40),
                                Obx(
                                  () => CustomButton(
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
