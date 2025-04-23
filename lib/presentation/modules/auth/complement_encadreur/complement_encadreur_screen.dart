import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/modules/auth/complement_encadreur/complement_encadreur_controller.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:glehiha/presentation/widgets/custom_button.dart';

import 'package:go_router/go_router.dart';

class ComplementEncadreurScreen extends StatefulWidget {
  const ComplementEncadreurScreen({super.key, required this.controller});

  final ComplemenEncadreurController controller;

  @override
  State<ComplementEncadreurScreen> createState() =>
      _ComplementEncadreurScreenState();
}

class _ComplementEncadreurScreenState extends State<ComplementEncadreurScreen> {
  bool _autoValidate = false;
  late ComplemenEncadreurController controller;

  
  @override
  void initState() {
    controller = widget.controller;
    super.initState();
    
  }

  void _onSubmit() {
    final isFormValid = widget.controller.formKey.currentState!.validate();

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
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 150),
                Container(
                  width: 392,
                  height: 280,
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
                    key: widget.controller.formKey,
                    autovalidateMode:
                        _autoValidate
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 90,
                          child: Divider(thickness: 2, color: AppColors.black),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "Complétez vos informations",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Veuillez entrer vos informations",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CustomTextFormField(
                          controller:
                              widget.controller.specialisationController,
                          labelText: "Spécialisation",
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Veuillez remplir ce champ'
                                      : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: widget.controller.certificationController,
                          labelText: "Certification",
                          suffixIcon: const Icon(
                            Icons.person,
                            color: AppColors.black,
                          ),
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Veuillez entrer votre certification'
                                      : null,
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => CustomButton(
                            isLoading: controller.isLoading.value,
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
