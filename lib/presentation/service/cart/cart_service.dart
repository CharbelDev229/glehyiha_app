import 'package:get/get.dart';
import '../../../data/models/cart/cart_item_model.dart';

class CartService extends GetxService {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  void addToCart(CartItemModel item) {
    final index = cartItems.indexWhere((element) => element.product_id == item.product_id);
    if (index != -1) {
      final currentItem = cartItems[index];
      cartItems[index] = currentItem.copyWith(
        quantite: currentItem.quantite + item.quantite,
      );
    } else {
      cartItems.add(item);
    }
  }

  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((element) => element.product_id == item.product_id);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + item.prix_unitaire * item.quantite,
    );
  }

  int get totalItems {
    return cartItems.fold(
      0,
      (sum, item) => sum + item.quantite,
    );
  }
}
