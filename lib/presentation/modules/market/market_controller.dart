import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../common/enums/product_category.dart';
import '../../../common/enums/user_role.dart';
import '../../../common/dtos/product/add_product_dto.dart';
import '../../../data/models/product/products.dart';
import '../../router/routes.dart';
import '../../service/product/product_service.dart';
import '../add_product/add_product.dart';
import '../controller/user_seller_cpntroller.dart'; // <- pour récupérer le vrai sellerId

class MarketController extends GetxController {
  final ProductService productService = Get.find<ProductService>();

  final Rx<ProductCategory> selectedCategory = ProductCategory.ALL.obs;
  final RxString searchTerm = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final Rx<UserRole> selectedRole = UserRole.vendeur.obs;
 void _loadProductsBasedOnRole() {
    if (selectedRole.value == UserRole.vendeur) {
      getMyProducts();
    } else {
      getAllProducts();
    }
  }
  @override
  void onInit() {
    super.onInit();
    ever(productService.userRole, (role) {
      selectedRole.value = role;
      _loadProductsBasedOnRole();
    });

    selectedRole.value = productService.userRole.value;
    _loadProductsBasedOnRole();
  }

  void changeCategory(ProductCategory category) {
    selectedCategory.value = category;
  }

  void updateSearch(String value) {
    searchTerm.value = value;
  }

  void selectProduct(BuildContext context, Product product) {
    context.pushNamed(AppRoutesNames.productDetail, extra: product);
  }

  void addNewProduct() {
    if (selectedRole.value == UserRole.vendeur) {
      Get.to(() => AddProduct())?.then((_) {
        refreshAfterProductCreated();
      });
    } else {
      Get.snackbar("Accès refusé", "Seuls les vendeurs peuvent ajouter des produits");
    }
  }

  List<Product> get filteredProducts {
    final sourceProducts = selectedRole.value == UserRole.vendeur
        ? productService.myProducts
        : productService.simpleProducts;

    return sourceProducts.where((product) {
      final matchCategory = selectedCategory.value == ProductCategory.ALL ||
          product.category == selectedCategory.value;

      final matchSearch = searchTerm.value.isEmpty ||
          product.name.toLowerCase().contains(searchTerm.value.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();
  }

  Future<void> refreshAfterProductCreated() async {
    if (selectedRole.value == UserRole.vendeur) {
      await getMyProducts();
    } else {
      await getAllProducts();
    }
  }

  Future<void> getAllProducts() async {
    await productService.loadAllProducts();
  }

  Future<void> getMyProducts() async {
    final sellerId = _getCurrentSellerId();
    if (sellerId != null) {
      await productService.loadProductsBySeller(sellerId);
    } else {
      Get.snackbar("Erreur", "Impossible de récupérer l'ID du vendeur");
    }
  }

  Product convertDtoToProduct(AddProductDto dto) {
    return Product(
      id: DateTime.now().millisecondsSinceEpoch,
      name: dto.name,
      image: dto.filename,
      category: dto.category,
      prix_unitaire: dto.price,
      resume: dto.resume,
      quantite: '${dto.stock} ${dto.unit}',
      seller: _getCurrentSellerId() ?? "vendeur inconnu",
      description: dto.description,
    );
  }

  String? _getCurrentSellerId() {
    final controller = Get.find<UserSellerController>();
    return controller.getUserId(); // 🔧 Remplace avec le vrai ID vendeur
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}