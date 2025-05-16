import 'package:get/get.dart';

import '../../../data/models/cart/cart_item_model.dart';

class CartController1 extends GetxController {
  var cartItems = <CartItemModel>[].obs;

  void addToCart(CartItemModel item) {
    final index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      // Incrémente la quantité en remplaçant l'item
      final currentItem = cartItems[index];
      cartItems[index] = currentItem.copyWith(quantity: currentItem.quantity + 1);
    } else {
      cartItems.add(item);
    }
  }

  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((element) => element.id == item.id);
  }

  void incrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      final currentItem = cartItems[index];
      cartItems[index] = currentItem.copyWith(quantity: currentItem.quantity + 1);
    }
  }

  void decrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1 && cartItems[index].quantity > 1) {
      final currentItem = cartItems[index];
      cartItems[index] = currentItem.copyWith(quantity: currentItem.quantity - 1);
    }
  }

  double get totalPrice => cartItems.fold(0, (sum, item) {
    final price = double.tryParse(item.price) ?? 0;
    return sum + (price * item.quantity);
  });
}
