import 'package:get/get.dart';
import '../../../data/models/product/products.dart';

class CartController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  
  // Méthode pour obtenir le nombre d'articles dans le panier
  int get cartCount => cartItems.length;
  
  // Méthode pour ajouter un produit au panier
  void addToCart(Product product) {
    cartItems.add(product);
  }
  
  // Méthode pour retirer un produit du panier
  void removeFromCart(Product product) {
    cartItems.remove(product);
  }
  
  // Méthode pour vider le panier
  void clearCart() {
    cartItems.clear();
  }
  
  // Méthode pour calculer le total du panier
  double get total {
    double sum = 0;
    for (var item in cartItems) {
      sum += double.parse(item.price);
    }
    return sum;
  }
}