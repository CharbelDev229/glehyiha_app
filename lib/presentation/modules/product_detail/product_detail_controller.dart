import 'package:get/get.dart';
import '../../../data/models/product_detail/product_model.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;

  void addToCart(ProductModel product) {
    cartItems.add(product);
  }

  int get cartCount => cartItems.length;
}
