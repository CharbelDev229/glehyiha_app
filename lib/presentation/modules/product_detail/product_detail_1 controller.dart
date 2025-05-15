import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  // Quantité sélectionnée
  RxInt quantity = 1.obs;

  // Incrémenter
  void increment() {
    quantity.value++;
  }

  // Décrémenter
  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // Réinitialiser si besoin
  void reset() {
    quantity.value = 1;
  }
}
