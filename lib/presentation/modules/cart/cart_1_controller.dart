import  'package:get/get.dart';
import '../../../data/models/product/products.dart';
import '../../../data/models/cart/cart_item_model.dart';

// Renommé en Cart1Controller pour correspondre à votre import
class Cart1Controller extends GetxController {
  // Instance singleton accessible globalement
  static Cart1Controller get to => Get.find<Cart1Controller>();
  
  // Assurez-vous que c'est une variable observable
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  
  // Getter pour le nombre total d'articles dans le panier
  int get cartCount => 
      cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  // Calcul du prix total
  double get totalPrice => 
      cartItems.fold(0.0, (sum, item) => sum + (double.tryParse(item.price) ?? 0) * item.quantity);
  
  // Méthode pour ajouter un produit au panier
  void addToCart(Product product, {int quantity = 1}) {
    try {
      final index = cartItems.indexWhere((item) => item.id == product.id);
      
      if (index >= 0) {
        // Met à jour la quantité si le produit est déjà dans le panier
        final updatedItem = cartItems[index].copyWith(
          quantity: cartItems[index].quantity + quantity,
        );
        cartItems[index] = updatedItem;
      } else {
        // Ajoute un nouveau produit au panier
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
      
      // Log pour le débogage
      print('Panier mis à jour: ${cartItems.length} articles, total: $totalPrice');
      
      // Forcer une mise à jour de l'interface
      update();
    } catch (e) {
      print('Erreur lors de l\'ajout au panier: $e');
      rethrow;
    }
  }
  
  // Supprimer un article du panier
  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((cartItem) => cartItem.id == item.id);
    update();
  }
  
  // Augmenter la quantité d'un article
  void incrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index >= 0) {
      final updatedItem = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
      cartItems[index] = updatedItem;
      update();
    }
  }
  
  // Diminuer la quantité d'un article
  void decrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        final updatedItem = cartItems[index].copyWith(
          quantity: cartItems[index].quantity - 1,
        );
        cartItems[index] = updatedItem;
      } else {
        // Si la quantité est 1, on supprime l'article
        cartItems.removeAt(index);
      }
      update();
    }
  }
  
  // Vider complètement le panier
  void clearCart() {
    cartItems.clear();
    update();
  }
}