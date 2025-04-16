import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/modules/auth/complement_info/complement_info_controller.dart';
import 'package:glehiha/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';

class ComplementInfoEncadreurScreens extends StatelessWidget {
  const ComplementInfoEncadreurScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplementInfoController());

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
                    key: controller.formKeyEncadreur,
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
                          controller: controller.specialisationController,
                          labelText: "Spécialisation",
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Veuillez remplir ce champ'
                                      : null,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: controller.certificationController,
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
                          () => ElevatedButton(
                            onPressed: () {
                              controller.onSubmitEncadreur();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child:
                                controller.certification.value
                                    ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Text(
                                      "S'inscrire",
                                      style: TextStyle(
                                        fontSize: 16,
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

class ComplementInfoVendeurScreens extends StatelessWidget {
  const ComplementInfoVendeurScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplementInfoController());

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
                    key: controller.formKeyVendeur,
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
                        SizedBox(height: 25),
                        CustomTextFormField(
                          controller: controller.nomboutiqueController,
                          labelText: "Nom de votre boutique",
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Veuillez entrer le nom de votre boutique'
                                      : null,
                        ),
                        CustomTextFormField(
                          controller: controller.specialisationController,
                          labelText: "Spécialisation",
                          validator:
                              (value) =>
                                  value == null || value.trim().isEmpty
                                      ? 'Veuillez remplir le champs'
                                      : null,
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              controller.onsubmitVendeur();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child:
                                controller.certification.value
                                    ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Text(
                                      "S'inscrire",
                                      style: TextStyle(
                                        fontSize: 16,
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
