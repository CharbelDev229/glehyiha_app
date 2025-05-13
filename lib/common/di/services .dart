import 'package:get/get.dart';

import '../../presentation/service/app/app_service.dart';
import '../../presentation/service/product/product_service.dart';

class DiServices {
  static Future<void> dependencies() async {
    Get.lazyPut(() => AppService());
    Get.lazyPut(() => ProductService());
  }
}
