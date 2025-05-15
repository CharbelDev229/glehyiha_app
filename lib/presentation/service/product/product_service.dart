

import 'package:get/get.dart';
import '../../../common/enums/user_role.dart';
import '../../../data/models/product/products.dart';
import '../../../common/enums/product_category.dart';

class ProductService extends GetxService {
  // Observable list of products
  final RxList<Product> products = <Product>[].obs;
  final Rx<UserRole> userRole = UserRole.agriculteur.obs; // Ou autre valeur par défaut

  ProductService() {
    init(); // Appelé dès que le service est instancié
  }
  // Méthode d'initialisation appelée au démarrage de l'application
  Future<ProductService> init() async {
    // Chargement des produits (en dur pour l'instant)
    await loadProducts();
    return this;
  }
  
  // Simuler un chargement depuis une API ou une base de données
  Future<void> loadProducts() async {
    // Simule un délai de chargement (à supprimer en production)
   //flutter await Future.delayed(const Duration(milliseconds: 300));
    
    final List<Product> loadedProducts = [
      Product(
        id: '1',
        name: 'Engrais organique',
        image: 'assets/images/image1.png',
        category: ProductCategory.engrais,
        price: '5000',
        description: 'Engrais naturel et biologique pour tous type de cultures.Améliore la structure du sol etfavorise une croissance saine.',
      ),
      Product(
        id: '2',
        name: 'Insecticide Top Bio',
        image: 'assets/images/image2.png',
        category: ProductCategory.pesticide,
        price: '2500',
        description: 'Répulsif anti-insectes écologique qui protège les plantes sans produits chimiques nocifs',
      ),
      Product(
        id: '3',
        name: 'Huile de Neem',
        image: 'assets/images/image3.png',
        category: ProductCategory.pesticide,
        price: '3000',
        description: ' L\'huile de neem agit comme un bio pesticide à des niveaux et des modes différents.',
      ),
       Product(
         id: '4',
         name: 'Pulérisateur 15L',
         image: 'assets/images/image8.png',
         category: ProductCategory.pesticide,
         price: '13000',
         description: 'Pulvérisateur',
       ),
    ];
    
    products.assignAll(loadedProducts);
  }

// Méthode pour mettre à jour le rôle
  void setUserRole(UserRole role) {
     print('Rôle défini : $role'); 
    userRole.value = role;
  }

  // Méthode pour obtenir le rôle de l'utilisateur
  UserRole getUserRole() {
 //   print('Setting user role to: $role');  
    return userRole.value;
  }


  


  
  // Obtenir les produits filtrés par catégorie et terme de recherche
  List<Product> getFilteredProducts(ProductCategory category, String searchTerm) {
    return products.where((product) {
      final matchesCategory = category == ProductCategory.all || product.category == category;
      final matchesSearch = product.name.toLowerCase().contains(searchTerm.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
  
  // Obtenir un produit par son ID
  Product? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Ajouter un nouveau produit
   void addProduct(Product product) {
     products.add(product);
   }

//   Future<void> addProduct(Product product) async {
//   try {
//     final response = await apiService.addProductToServer(product); // Appel API pour ajouter le produit
//     if (response.success) {
//       products.add(product); // Ajouter localement après la réussite de l'API
//     }
//   } catch (e) {
//     print("Erreur lors de l'ajout du produit: $e");
//   }
// }

  
  // Mettre à jour un produit existant
  void updateProduct(Product updatedProduct) {
    final index = products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
    }
  }
  
  // Supprimer un produit
  void deleteProduct(String productId) {
    products.removeWhere((product) => product.id == productId);
  }
}