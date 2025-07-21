import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/common/enums/product_category.dart';
import 'package:glehiha/common/utils/text_field_validators.dart';
import 'package:glehiha/presentation/modules/add_product/add_product_controller.dart';
import '../../widgets/custom_text_form_field/custom_text_form_field.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final controller = Get.find<AddProductController>();
  final _formKey = GlobalKey<FormState>(); // ✅ Clé locale

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetForm(); // ✅ Efface les anciens champs à chaque ouverture
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            autovalidateMode:
                controller.autoValidate.value
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
            child: Column(
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
                    labelText: "Description du produit",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value!.isEmpty
                              ? 'Veuillez entrer une description'
                              : null,
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
                  value: controller.selectedCategory.value,
                  decoration: const InputDecoration(
                    labelText: "Catégorie",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value != null)
                      controller.selectedCategory.value = value;
                  },
                  items:
                      ProductCategory.values
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)),
                          )
                          .toList(),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value:
                      controller.unitController.text.isEmpty
                          ? null
                          : controller.unitController.text,
                  decoration: const InputDecoration(
                    labelText: "Unité",
                    border: OutlineInputBorder(),
                  ),
                  items:
                      ['kg', 'L', 'g', 'bag']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) {
                    controller.unitController.text = val!;
                  },
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Choisir une unité'
                              : null,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.stockController,
                  validator: TextFieldValidators.required,
                  labelText: "Quantité en stock",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.image),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            controller.pickedImage.value?.name ??
                                "Choisir une photo du produit",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed:
                      controller.createproductinLoading.value
                          ? null
                          : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              controller.createProduct(context);
                            } else {
                              controller.autoValidate.value = true;
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      controller.createproductinLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "Soumettre",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
