import 'package:get/get.dart';

import '../../../data/models/cart/cart_item_model.dart';
import '../../../data/models/product_detail/product_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  void removeFromCart(ProductModel product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
  }

  void incrementQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) cartItems[index].quantity++;
  }

  void decrementQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
  }

   double get totalPrice => cartItems.fold(0, (sum, item) {
    final price = double.tryParse(item.product.price) ?? 0;
    return sum + (price * item.quantity);
  });
}
