import 'package:get/get.dart';
import '../../../data/models/product/products.dart';
import '../../../data/models/cart/cart_item_model.dart';

class Cart1Controller {
  // Liste observable des articles du panier
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  // Nombre total d'articles
  int get cartCount => 
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Prix total du panier
  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) =>
          sum + (double.tryParse(item.price) ?? 0) * item.quantity);

  // Ajouter un article au panier
  void addToCart(Product product, {int quantity = 1}) {
    final index = cartItems.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + quantity,
      );
    } else {
      cartItems.add(CartItemModel(
        id: product.id,
        name: product.name,
        image: product.image,
        category: product.category,
        price: product.price,
        resume: product.resume,
        quantity: quantity,
        seller: product.seller,
      ));
    }
  }

  // Supprimer un article
  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((cartItem) => cartItem.id == item.id);
  }

  // Incrémenter la quantité
  void incrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
    }
  }

  // Décrémenter la quantité
  void decrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity - 1,
        );
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  // Vider le panier
  void clearCart() {
    cartItems.clear();
  }
}
