import 'package:get/get.dart';
import '../../../data/models/product/products.dart';
import '../../../data/models/cart/cart_item_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  int get cartCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantite);

  void addToCart(Product product, int value, {int quantity = 1}) {
    final index = cartItems.indexWhere((item) => item.product_id == product.id);
    if (index >= 0) {
      // Met à jour la quantité si le produit est déjà dans le panier
      final updatedItem = cartItems[index].copyWith(
        quantite: cartItems[index].quantite + quantity,
      );
      cartItems[index] = updatedItem;
    } else {
      cartItems.add(
        CartItemModel(
          product_id: product.id, // ✅ Corrigé : product.id est un int
          name: product.name,
          image: product.image,
          category: product.category,
          prix_unitaire: product.prix_unitaire, // ✅ Doit être un double
          resume: product.resume,
          quantite: quantity, // ✅ On prend le paramètre "quantity"
          seller: product.seller,
        ),
      );
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product_id == productId);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get total {
    return cartItems.fold(
      0,
      (sum, item) => sum + item.prix_unitaire * item.quantite,
    );
  }
}
