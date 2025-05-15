import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/common/enums/product_category.dart';
import 'package:glehiha/common/enums/user_role.dart';
import 'package:glehiha/common/utils/text_field_validators.dart';

import 'package:glehiha/presentation/modules/add_product/add_product_controller.dart';


import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


import '../../../common/utils/utils.dart';
import '../../router/routes.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form_field.dart';
import '../../widgets/custom_text_form_field/custom_text_form_field_1.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final controller = AddProductController(); // Utilisation directe du contrôleur global

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryGreen,
          title: const Text(
            'Ajouter un produit',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(
              () => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: controller.autoValidate.value
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: controller.nomController,
                        validator: TextFieldValidators.required,
                        labelText: "Nom",
                      //  suffixIcon: const Icon(Icons.person, color: AppColors.black),
                      ),
                      const SizedBox(height: 20),
                     TextFormField(
                         controller: controller.descriptionController,
                           maxLines: 5, // ou plus si besoin
                            decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                             alignLabelWithHint: true, // pour centrer le label en haut
                                ),
                                    validator: (value) {
                               if (value == null || value.isEmpty) {
                               return 'Veuillez entrer une description';
                                    }
                                   return null;
                                         },
                                           ),

                          const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: controller.marqueController,
                        validator: TextFieldValidators.required,
                        labelText: "Marque",
                        //suffixIcon: const Icon(Icons.person, color: AppColors.black),
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        controller: controller.marqueController,
                        validator: TextFieldValidators.required,
                        labelText: "Prix",
                        //suffixIcon: const Icon(Icons.person, color: AppColors.black),
                      ),
                      const SizedBox(height: 20),

                   DropdownButtonFormField<ProductCategory>(
                   dropdownColor: AppColors.white,
                    value: controller.selectedProduct.value,
                    decoration: InputDecoration(
                     labelText: "Catégorie",
                     border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                       borderSide: const BorderSide(color: Colors.grey),
                           ),
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            ),
                       isExpanded: true,
                       onChanged: (newValue) {
                       if (newValue != null) {
                          controller.selectedProduct.value = newValue;
                                 }
                                  },
                            items: ProductCategory.values.map((category) {
                            return DropdownMenuItem<ProductCategory>(
                              value: category,
                                 child: Text(
                                 category.name,
                                   style: const TextStyle(fontSize: 12),
                                     ),
                                       );
                                        }).toList(),
                                      ),
                        const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                         value: controller.uniteController.text.isEmpty ? null : controller.uniteController.text,
                         decoration: const InputDecoration(
                          labelText: 'Unité',
                           border: OutlineInputBorder(),
                                    ),
                                   items: ['kg', 'litre', 'tonne', 'sachet', 'pièce'].map((unite) {
                                  return DropdownMenuItem<String>(
                                value: unite,
                               child: Text(unite),
                               );
                                }).toList(),
                                 onChanged: (value) {
                                 controller.uniteController.text = value!;
                                   },
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                return 'Veuillez choisir une unité';
                                      }
                            return null;
                              },
                              ),


                      const SizedBox(height: 20),
                      Obx(() => GestureDetector(
                         onTap: () => controller.pickImage(),
                          child: Container(
                         padding: const EdgeInsets.all(16),
                         decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                              ),
                         child: Row(
                      children: [
                    const Icon(Icons.image, color: AppColors.black),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                      controller.pickedImage.value != null
                       ? controller.pickedImage.value!.name
                      : "Choisir une photo du produit",
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  ),
)),
const SizedBox(height: 20),
                     CustomTextFormField(
                        controller: controller.marqueController,
                        validator: TextFieldValidators.required,
                        labelText: "Date de faabrication",
                      //  suffixIcon: const Icon(Icons.person, color: AppColors.black),
                      ),
                      const SizedBox(height: 20),
                     CustomTextFormField(
                        controller: controller.marqueController,
                        validator: TextFieldValidators.required,
                        labelText: "Date de péremption",
                       // suffixIcon: const Icon(Icons.person, color: AppColors.black),
                      ),
                      const SizedBox(height: 20),

                         Obx(
                                  () => CustomButton(
                                    isLoading: controller.isLoading.value,
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      43,
                                      131,
                                      68,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    onPressed:
                                        controller.isLoading.value
                                            ? null
                                            : () {
                                              if (controller
                                                      .formKey
                                                      .currentState
                                                      ?.validate() ??
                                                  false) {
                                                context.pushNamed(
                                                  AppRoutesNames.expert,
                                                );
                                              } else {
                                                // logger.w(
                                                //   controller
                                                //       .formKey
                                                //       .currentState,
                                                // );
                                                Utils.snackInfo(
                                                  context: context,
                                                  message:
                                                      'Une erreur est dans le formulaire',
                                                );
                                              }
                                            },

                                    child:
                                        controller.isLoading.value
                                            ? const CircularProgressIndicator()
                                            : const Text(
                                              "Soumettre",
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
            );
          },
        ),
      ),
    );
  }
}
