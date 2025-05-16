import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import '../../../common/enums/product_category.dart';
import '../../../common/enums/user_role.dart';
import '../../../data/models/product/products.dart';
import '../../service/product/product_service.dart';
import '../add_product/add_product.dart';

class MarketController extends GetxController {
  // Dépendances
  final ProductService _productService = Get.find<ProductService>();

  // État observable
  final Rx<ProductCategory> selectedCategory = ProductCategory.all.obs;
  final RxString searchTerm = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // Rôle de l'utilisateur
  Rx<UserRole> selectedRole = UserRole.vendeur.obs;

  // Initialisation
  @override
  void onInit() {
    super.onInit();

    // Écouter les changements de rôle
    ever(_productService.userRole, (role) {
      selectedRole.value = role;
      print('Rôle mis à jour : $role');
    });

    // Initialiser avec le rôle actuel du service
    selectedRole.value = _productService.userRole.value;
  }

  // Obtenir les produits filtrés
  List<Product> get filteredProducts => _productService.getFilteredProducts(
    selectedCategory.value,
    searchTerm.value,
  );

  // Méthodes de manipulation d'état
  void changeCategory(ProductCategory category) {
    selectedCategory.value = category;
  }

  void updateSearch(String value) {
    searchTerm.value = value;
  }

  void selectProduct(BuildContext context, Product product) {
    Get.snackbar(
      'Produit sélectionné',
      'Vous avez sélectionné ${product.name}',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
    

    context.pushNamed(AppRoutesNames.productDetail, extra: Product);
  }

  // Méthode pour ajouter un nouveau produit
  void addNewProduct() {
    // Vérifier si l'utilisateur est un vendeur
    if (selectedRole.value == UserRole.vendeur) {
      // Naviguer vers l'écran d'ajout de produit
      Get.to(() => AddProduct());
    } else {
      Get.snackbar(
        'Accès refusé',
        'Seuls les vendeurs peuvent ajouter des produits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
