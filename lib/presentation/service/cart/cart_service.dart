import 'package:get/get.dart';
import 'package:glehiha/data/models/product_detail/product_model.dart';
import '../../../common/enums/user_role.dart';
import '../../../common/enums/product_category.dart';
import '../../../data/models/cart/cart_item_model.dart';

class CartService extends GetxService {
  // Liste observable des produits disponibles
  final RxList<ProductModel> products = <ProductModel>[].obs;

  // Liste observable du panier
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  // Rôle utilisateur observable
  final Rx<UserRole> userRole = UserRole.agriculteur.obs;

  CartService() {
    init();
  }

  /// Initialisation
  Future<CartService> init() async {
    await loadProducts();
    return this;
  }

  /// Charger les produits simulés
  Future<void> loadProducts() async {
    final List<ProductModel> loadedProducts = [
      ProductModel(
        id: '1',
        name: 'Engrais organique AgroBio',
        image: 'assets/images/image1.png',
        category: ProductCategory.engrais,
        price: '5000',
        description:
            'Engrais naturel et biologique pour tous', 
       quantity: '1', 
       seller: 'buiik',
      ),
      // Tu peux ajouter d'autres produits ici
    ];

    products.assignAll(loadedProducts);
  }

  /// Récupérer un produit par ID
  ProductModel? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Ajouter un produit au panier
  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  /// Changer le rôle utilisateur
  void setUserRole(UserRole role) {
    userRole.value = role;
  }

  UserRole getUserRole() => userRole.value;
}
