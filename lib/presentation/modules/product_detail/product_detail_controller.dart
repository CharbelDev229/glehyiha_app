import 'package:get/get.dart';
import '../../../data/models/product/products.dart';
import '../../../data/models/cart/cart_item_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  
  int get cartCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  void addToCart(Product product, int value, {int quantity = 1}) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      // Met à jour la quantité si le produit est déjà dans le panier
      final updatedItem = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + quantity,
      );
      cartItems[index] = updatedItem;
    } else {
      cartItems.add(
        CartItemModel(
          id: product.id,
          name: product.name,
          image: product.image,
          category: product.category,
          price: product.price,
          resume: product.resume,
          quantity: quantity,
          seller: product.seller,
        ),
      );
    }
  }
  
  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.id == productId);
  }
  
  void clearCart() {
    cartItems.clear();
  }
  
  double get total {
    return cartItems.fold(0, (sum, item) =>
        sum + double.parse(item.price) * item.quantity);
  }

  
}