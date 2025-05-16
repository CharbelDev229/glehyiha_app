import 'package\:get/get.dart';

class ProductDetailController extends GetxController {
final RxInt quantity = 1.obs;

void increment() {
quantity.value++;
}

void decrement() {
if (quantity.value > 1) {
quantity.value--;
}
}
} 