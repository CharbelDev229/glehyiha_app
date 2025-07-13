import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:glehiha/common/enums/product_category.dart';
import 'package:glehiha/common/services/location_service.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/domain/usescases/product/create_product.dart';

import '../../../common/dtos/product/add_product_dto.dart';
import '../../../common/enums/user_role.dart';
import '../../router/routes.dart';
import '../../service/product/product_service.dart';
import '../market/market_controller.dart';

class AddProductController extends GetxController {
  final CreateProductUseCase createProductUseCase;

  AddProductController({required this.createProductUseCase});

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final resumeController = TextEditingController();
  final marqueController = TextEditingController();
  final priceController = TextEditingController();
  final unitController = TextEditingController();
  final fabricationDateController = TextEditingController();
  final expirationDateController = TextEditingController();
  final stockController = TextEditingController();

  final Rx<ProductCategory> selectedCategory = ProductCategory.ENGRAIS.obs;
  final Rx<XFile?> pickedImage = Rxn<XFile>();
  final ImagePicker imagePicker = ImagePicker();

  final RxBool createproductinLoading = false.obs;
  final RxBool autoValidate = false.obs;

  final RxString latitude = ''.obs;
  final RxString longitude = ''.obs;

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = image;
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        latitude.value = position.latitude.toString();
        longitude.value = position.longitude.toString();
      }
    } catch (e) {
      logger.e("Erreur localisation : $e");
    }
  }

  Future<void> createProduct(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      Utils.snackInfo(context: context, message: "Veuillez corriger les erreurs du formulaire.");
      autoValidate.value = true;
      return;
    }

    if (pickedImage.value == null) {
      Utils.snackError(context: context, message: "Veuillez sélectionner une image.");
      return;
    }

    createproductinLoading.value = true;

    try {
      await getCurrentLocation();
      final Uint8List bytes = await pickedImage.value!.readAsBytes();

      DateTime? fabricationDate;
      DateTime? expirationDate;

      if (fabricationDateController.text.contains('/')) {
        final parts = fabricationDateController.text.split('/');
        fabricationDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }

      if (expirationDateController.text.contains('/')) {
        final parts = expirationDateController.text.split('/');
        expirationDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }

      final dto = AddProductDto(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        resume: resumeController.text.trim(),
        marque: marqueController.text.trim(),
        price: double.tryParse(priceController.text.trim()) ?? 0.0,
        stock: int.tryParse(stockController.text.trim()) ?? 0,
        category: selectedCategory.value,
        unit: unitController.text.trim(),
        imageBytes: bytes,
        filename: pickedImage.value!.name,
        dateFabrication: fabricationDate!.toIso8601String(),
        datePeremption: expirationDate!.toIso8601String(),
        latitude: latitude.value,
        longitude: longitude.value,
      );

      final result = await createProductUseCase.call(CreateProductParams(dto: dto));

      result.fold(
        (failure) {
          Utils.snackError(context: context, message: failure.message);
        },
        (message) async {
          Utils.snackSuccess(context: context, message: "Produit ajouté avec succès !");
          final marketController = Get.find<MarketController>();

          // Ajout local immédiat
          final newProduct = marketController.convertDtoToProduct(dto);
          final role = marketController.selectedRole.value;
          if (role == UserRole.vendeur) {
            marketController.productService.myProducts.add(newProduct);
          } else {
            marketController.productService.simpleProducts.add(newProduct);
          }

          await marketController.refreshAfterProductCreated();

          if (context.mounted) {
            context.pushNamed(AppRoutesNames.market);
          }
        },
      );
    } catch (e) {
      Utils.snackError(context: context, message: "Erreur : $e");
    }

    createproductinLoading.value = false;
  }

 

  void changeCategory(ProductCategory category) {
    selectedCategory.value = category;
  }
}
