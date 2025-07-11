import 'package:get/get.dart';
import '../../../data/models/cart/cart_item_model.dart';

class CartService extends GetxService {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  void addToCart(CartItemModel item) {
    final index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      final currentItem = cartItems[index];
      cartItems[index] = currentItem.copyWith(quantity: currentItem.quantity + 1);
    } else {
      cartItems.add(item);
    }
  }

  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((element) => element.id == item.id);
  }

  // ... autres méthodes similaires à celles du controller
}
