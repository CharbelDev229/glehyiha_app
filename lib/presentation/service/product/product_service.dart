import 'package:get/get.dart';

import '../../../common/enums/product_category.dart';
import '../../../common/enums/user_role.dart';
import '../../../data/models/product/products.dart';

class ProductService extends GetxService {
  // Liste observable des produits simples
  final RxList<Product> simpleProducts = <Product>[].obs;

  // Rôle utilisateur observable
  final Rx<UserRole> userRole = UserRole.agriculteur.obs;

  ProductService() {
    init();
  }

  // Initialisation (chargement des produits)
  Future<ProductService> init() async {
    await loadProducts();
    return this;
  }

  // Chargement manuel des produits (sera remplacé par API plus tard)
  Future<void> loadProducts() async {
    final List<Product> loadedProducts = [
      Product(
        id: '1',
        name: 'Engrais organique',
        image: 'assets/images/image1.png',
        category: ProductCategory.engrais,
        price: '5000',
        resume:
            'Engrais naturel et biologique pour tous type de cultures.',
        quantity: '150 kg',
        seller: 'BIOPHYTO',
        description:
            'AgroBio est un engrais biologique qui apres épondage, corrige la texture et la structure du sol lui donnant une bonne capacité de rétention d\'eau et des minéraux et une fertilité maintenue durant une longue période.Il augmente le rendement  et facilite la conservation des récoltes.Il joue trois roles : c\'est un fertilisanr, nématicide(lutte contre les vers invisibles dans le sol et qui dévastent les productions)et unsimulateur de croissance.On l\'utilise par épondage en fumure d\'entretien et en fumure de fonds.',
      ),
      Product(
        id: '2',
        name: 'Insecticide Top Bio',
        image: 'assets/images/image2.png',
        category: ProductCategory.pesticide,
        price: '2500',
        resume:
            'Top bio est un concentré émulssionnable à action insecticide, insectifuge et fongicide.',
        quantity: '150 kg',
        seller: 'BIOPHYTO',
        description:
            'AgroBio est un engrais biologique qui apres épondage, corrige la texture et la structure du sol lui donnant une bonne capacité de rétention d\'eau et des minéraux et une fertilité maintenue durant une longue période.Il augmente le rendement  et facilite la conservation des récoltes.Il joue trois roles : c\'est un fertilisanr, nématicide(lutte contre les vers invisibles dans le sol et qui dévastent les productions)et unsimulateur de croissance.On l\'utilise par épondage en fumure d\'entretien et en fumure de fonds.',
      ),
       Product(
        id: '3',
        name: 'Huile de Neem',
        image: 'assets/images/image3.png',
        category: ProductCategory.all,
        price: '2500',
        resume:
            'Huile de neem agit comme un bio-pesticide à des niveaux et des modes différents.',
        quantity: '150 kg',
        seller: 'BIOPHYTO',
        description:
            'AgroBio est un engrais biologique qui apres épondage, corrige la texture et la structure du sol lui donnant une bonne capacité de rétention d\'eau et des minéraux et une fertilité maintenue durant une longue période.Il augmente le rendement  et facilite la conservation des récoltes.Il joue trois roles : c\'est un fertilisanr, nématicide(lutte contre les vers invisibles dans le sol et qui dévastent les productions)et unsimulateur de croissance.On l\'utilise par épondage en fumure d\'entretien et en fumure de fonds.',
      ),
       Product(
        id: '4',
        name: 'Insecticide Top Bio',
        image: 'assets/images/image8.png',
        category: ProductCategory.pesticide,
        price: '2500',
        resume:
            'PulVérisateur',
        quantity: '150 kg',
        seller: 'BIOPHYTO',
        description:
            'AgroBio est un engrais biologique qui apres épondage, corrige la texture et la structure du sol lui donnant une bonne capacité de rétention d\'eau et des minéraux et une fertilité maintenue durant une longue période.Il augmente le rendement  et facilite la conservation des récoltes.Il joue trois roles : c\'est un fertilisanr, nématicide(lutte contre les vers invisibles dans le sol et qui dévastent les productions)et unsimulateur de croissance.On l\'utilise par épondage en fumure d\'entretien et en fumure de fonds.',
      ),
     
    ];
    simpleProducts.assignAll(loadedProducts);
  }

  // Gestion du rôle utilisateur
  void setUserRole(UserRole role) {
    print('Rôle défini : $role');
    userRole.value = role;
  }

  UserRole getUserRole() {
    return userRole.value;
  }

  // Filtrer les produits selon catégorie et recherche
  List<Product> getFilteredProducts(ProductCategory category, String searchTerm) {
    return simpleProducts.where((product) {
      final matchesCategory = category == ProductCategory.all || product.category == category;
      final matchesSearch = product.name.toLowerCase().contains(searchTerm.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Chercher un produit par ID
  Product? getProductById(String id) {
    try {
      return simpleProducts.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Ajouter un produit (utile pour le vendeur)
  void addProduct(Product product) {
    simpleProducts.add(product);
  }
}
