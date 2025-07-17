import 'package:get/get.dart';
import '../../../common/enums/product_category.dart';
import '../../../common/enums/user_role.dart';
import '../../../data/models/product/products.dart';
import '../../../common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/repositories/product_repository_impl.dart';

class ProductService extends GetxService {
  final RxList<Product> simpleProducts = <Product>[].obs;
  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> myProducts = <Product>[].obs;
  final Rx<UserRole> userRole = UserRole.agriculteur.obs;
  final ProductRepository productRepository;

  ProductService({required this.productRepository}) {
    init();
  }

  Future<ProductService> init() async {
    await loadAllProducts();
    await _loadManualProducts(); // 👈 ajoute ceci pour injecter les produits manuels
    return this;
  }

  Future<void> loadAllProducts() async {
    final result = await productRepository.getAllProducts();
    result.fold(
      (failure) => Get.snackbar("Erreur", failure.message),
      (data) {
        final products = data.map((e) => Product.fromJson(e)).toList();
        allProducts.assignAll(products);
        simpleProducts.assignAll(products);
      },
    );
  }

  Future<void> loadProductsBySeller(String sellerId) async {
    final result = await productRepository.getProductsBySeller(sellerId);
    result.fold(
      (failure) {
        Get.snackbar("Erreur", failure.message);
        myProducts.clear();
        simpleProducts.clear();
      },
      (data) {
        final products = data.map((e) => Product.fromJson(e)).toList();
        myProducts.assignAll(products);
        simpleProducts.assignAll(products);
      },
    );
    // ✅ Ajoute aussi les produits manuels pour les vendeurs
    if (userRole.value == UserRole.vendeur && myProducts.isEmpty) {
      _loadManualProducts(forSeller: true);
    }
  }

  Future<void> _loadManualProducts({bool forSeller = false}) async {
    // ✅ SUPPRIMÉ la condition qui bloquait les vendeurs
    // Maintenant tous les rôles peuvent voir les produits manuels
    
    final List<Product> manualProducts = [
      Product(
        id: 1,
        name: 'Engrais organique',
        image: 'assets/images/image1.png',
        category: ProductCategory.ENGRAIS,
        prix_unitaire: 5000,
        resume: 'Engrais naturel et biologique pour tous types de cultures.',
        quantite: '150 kg',
        seller: 'BIOPHYTO',
        description: 'AgroBio est un engrais biologique très efficace.',
      ),
      Product(
        id: 2,
        name: 'Insecticide Top Bio',
        image: 'assets/images/image2.png',
        category: ProductCategory.PESTICIDES,
        prix_unitaire: 2500,
        resume: 'Insecticide naturel à base de neem.',
        quantite: '150 kg',
        seller: 'BIOPHYTO',
        description: 'Protège vos plantes contre les nuisibles.',
      ),
       Product(
        id: 3,
        name: 'Huile de Neem',
        image: 'assets/images/image3.png',
        category: ProductCategory.ALL,
        prix_unitaire: 2500,
        resume:
            'Huile de neem agit comme un bio-pesticide à des niveaux et des modes différents.',
        quantite: '150 kg',
        seller: 'BIOPHYTO',
        description:
            'AgroBio est un engrais biologique qui apres épondage, corrige la texture et la structure du sol lui donnant une bonne capacité de rétention d\'eau et des minéraux et une fertilité maintenue durant une longue période.Il augmente le rendement  et facilite la conservation des récoltes.Il joue trois roles : c\'est un fertilisanr, nématicide(lutte contre les vers invisibles dans le sol et qui dévastent les productions)et unsimulateur de croissance.On l\'utilise par épondage en fumure d\'entretien et en fumure de fonds.',
      ),
       Product(
        id: 4,
        name: 'Insecticide Top Bio',
        image: 'assets/images/image8.png',
        category: ProductCategory.PESTICIDES,
        prix_unitaire: 2500,
        resume:
            'PulVérisateur',
        quantite: '150 kg',
        seller: 'BIOPHYTO',
        description:
            'AgroBio est un engrais biologique qui apres épondage, corrige la texture et la structure du sol lui donnant une bonne capacité de rétention d\'eau et des minéraux et une fertilité maintenue durant une longue période.Il augmente le rendement  et facilite la conservation des récoltes.Il joue trois roles : c\'est un fertilisanr, nématicide(lutte contre les vers invisibles dans le sol et qui dévastent les productions)et unsimulateur de croissance.On l\'utilise par épondage en fumure d\'entretien et en fumure de fonds.',
      ),
    ];

    // Ajoute les produits manuels pour tous les rôles
    simpleProducts.addAll(manualProducts);
  }

  Future<Either<Failure, String>> deleteProduct(dynamic id) {
    return productRepository.deleteProduct(id.toString());
  }

  void setUserRole(UserRole role) {
    userRole.value = role;
  }

  UserRole getUserRole() {
    return userRole.value;
  }

  void addProduct(Product product) {
    simpleProducts.add(product);
    if (userRole.value == UserRole.vendeur) {
      myProducts.add(product);
    }
  }
}