import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';

import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/custom_button.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:glehiha/presentation/modules/auth/verificaton_code/verification_code_controller.dart';
import 'package:go_router/go_router.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.controller});
  final VerificationCodeController controller;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late VerificationCodeController controller;
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
        AppRoutesNames.parameters,
      ); // ou context.pushNamed(...) si tu utilises go_router
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
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
                          child: Divider(thickness: 2, color: AppColors.black),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Complétez vos informations",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Veuillez entrer votre code",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CustomTextFormField(
                          controller: controller.codeController,
                          labelText: "code",
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Veuillez entrer le nom de votre boutique'
                                      : null,
                        ),

                        const SizedBox(height: 30),
                        Obx(
                          () => CustomButton(
                            backgroundColor: Color.fromARGB(255, 43, 131, 68),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
