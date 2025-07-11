import 'package:get/get.dart';

class CartItem {
  final String name;
  final String resume;
  final String image;
  final int quantity;
  final double price;

  CartItem({
    required this.name,
    required this.resume,
    required this.image,
    required this.quantity,
    required this.price,
  });
}

class OrderDetailController  {
  // Liste observable des produits dans le panier
  RxList<CartItem> cartItems = <CartItem>[].obs;

  // Total observable (double)
  RxDouble totalPrice = 0.0.obs;

  // Calcule le total en fonction des items et leurs quantités
  void calculateTotal() {
    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }

  
  void addItem(CartItem item) {
    cartItems.add(item);
    calculateTotal();
  }

  // Vider le panier
  void clearCart() {
    cartItems.clear();
    calculateTotal();
  }
}
