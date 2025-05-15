

import 'package:get/get.dart';
import 'package:glehiha/data/models/product_detail/product_model.dart';
import '../../../common/enums/user_role.dart';

import '../../../common/enums/product_category.dart';



class ProductDetailService extends GetxService {
  // Observable list of products
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final Rx<UserRole> userRole = UserRole.agriculteur.obs; // Ou autre valeur par défaut
ProductDetailService() {
    init(); // Appelé dès que le service est instancié
  }
  // Méthode d'initialisation appelée au démarrage de l'application
  Future<ProductDetailService> init() async {
    // Chargement des produits (en dur pour l'instant)
    await loadProducts();
    return this;
  }
  
  // Simuler un chargement depuis une API ou une base de données
  Future<void> loadProducts() async {
    // Simule un délai de chargement (à supprimer en production)
   //flutter await Future.delayed(const Duration(milliseconds: 300));
    
    final List<ProductModel> loadedProducts = [
      ProductModel(
        id: '1',
        name: 'Engrais organique AgroBio',
        quantity: '120 kg',
        seller: 'BIOPHYTO',
        image: 'assets/images/image1.png',
        category: ProductCategory.engrais,
        price: '5000',
        description: 'AgroBio est un engrais biologique qui après épandage, corrige la texture et la structure du sol lui donnant une bonne capacité de rétention d\'eau et des minéraux et une fertilité maintenue durant une longue période.Il augmente le rendement et facilite la conservation des récoltes . Il joue trois roles: c\'est un fertilisant nématicide(lutte contre des vers invisibles dans le sol et qui dévastent les productions) et un stimulateur de croissance.On utilise par épondage en fumure d\'entretien et en fumure de fonds.',
      ),
      // Product(
      //   id: '2',
      //   name: 'Insecticide Top Bio',
      //   image: 'assets/images/image2.png',
      //   category: ProductCategory.pesticide,
      //   price: '2500',
      //   description: 'Répulsif anti-insectes écologique qui protège les plantes sans produits chimiques nocifs',
      // ),
      // Product(
      //   id: '3',
      //   name: 'Huile de Neem',
      //   image: 'assets/images/image3.png',
      //   category: ProductCategory.pesticide,
      //   price: '3000',
      //   description: ' L\'huile de neem agit comme un bio pesticide à des niveaux et des modes différents.',
      // ),
      //  Product(
      //    id: '4',
      //    name: 'Pulérisateur 15L',
      //    image: 'assets/images/image8.png',
      //    category: ProductCategory.pesticide,
      //    price: '13000',
      //    description: 'Pulvérisateur',
      //  ),
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


  
  
  // Obtenir un produit par son ID
  ProductModel? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
  
  



  
 
}