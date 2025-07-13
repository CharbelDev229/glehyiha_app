import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/common/enums/product_category.dart';
import 'package:glehiha/common/utils/text_field_validators.dart';
import 'package:glehiha/presentation/modules/add_product/add_product_controller.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form_field.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryGreen,
          title: const Text(
            'Ajouter un produit',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(
              () => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  key: controller.formKey,
                  autovalidateMode: controller.autoValidate.value
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: controller.nameController,
                        validator: TextFieldValidators.required,
                        labelText: "Nom du produit",
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: controller.descriptionController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Description du produit',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Veuillez entrer une description' : null,
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        controller: controller.resumeController,
                        validator: TextFieldValidators.required,
                        labelText: "Résumé du produit",
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        controller: controller.marqueController,
                        validator: TextFieldValidators.required,
                        labelText: "Marque",
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        controller: controller.priceController,
                        validator: TextFieldValidators.required,
                        labelText: "Prix (en FCFA)",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),

                      DropdownButtonFormField<ProductCategory>(
                        dropdownColor: AppColors.white,
                        value: controller.selectedCategory.value,
                        decoration: InputDecoration(
                          labelText: "Catégorie",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        ),
                        isExpanded: true,
                        onChanged: (newValue) {
                          if (newValue != null) {
                            controller.selectedCategory.value = newValue;
                          }
                        },
                        items: ProductCategory.values
                            .map((category) => DropdownMenuItem<ProductCategory>(
                                  value: category,
                                  child: Text(category.name),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),

                      DropdownButtonFormField<String>(
                        value: controller.unitController.text.isEmpty
                            ? null
                            : controller.unitController.text,
                        decoration: const InputDecoration(
                          labelText: 'Unité',
                          border: OutlineInputBorder(),
                        ),
                        items: ['kg', 'L', 'g', 'bag']
                            .map((unite) => DropdownMenuItem<String>(
                                  value: unite,
                                  child: Text(unite),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.unitController.text = value!;
                        },
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Choisir une unité' : null,
                      ),
                      const SizedBox(height: 20),

                      CustomTextFormField(
                        controller: controller.stockController,
                        validator: TextFieldValidators.required,
                        labelText: "Quantité en stock",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),

                      Obx(() => GestureDetector(
                            onTap: controller.pickImage,
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),

                      // 📅 Date de fabrication
                      TextFormField(
                        controller: controller.fabricationDateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Date de fabrication",
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            controller.fabricationDateController.text =
                                "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                          }
                        },
                      ),
                      const SizedBox(height: 20),

                      // 📅 Date de péremption
                      TextFormField(
                        controller: controller.expirationDateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Date de péremption",
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            controller.expirationDateController.text =
                                "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                          }
                        },
                      ),
                      const SizedBox(height: 20),

                      Obx(
                        () => CustomButton(
                          isLoading: controller.createproductinLoading.value,
                          backgroundColor: const Color(0xFF2B8344),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          onPressed: controller.createproductinLoading.value
                              ? null
                              : () {
                                  if (controller.formKey.currentState?.validate() ?? false) {
                                    controller.createProduct(context);
                                  }
                                },
                          child: controller.createproductinLoading.value
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Soumettre",
                                  style: TextStyle(fontSize: 20, color: Colors.white),
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
