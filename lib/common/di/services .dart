import 'package:get/get.dart';
import 'package:glehiha/presentation/service/profile%20service%20.dart';

import '../../presentation/service/app/app_service.dart';
import '../../presentation/service/cart/cart_service.dart';
import '../../presentation/service/product/product_service.dart';


class DiServices {
  static Future<void> dependencies() async {
    Get.lazyPut(() => AppService());
    Get.lazyPut(() => ProductService());
    Get.lazyPut(() => CartService());
     Get.lazyPut(() => ProfileService(
      getProfileUseCase: Get.find(), 
      logoutUseCase: Get.find(), 
      deleteAccountUseCase: Get.find(), 
      changePasswordUseCase: Get.find(), 
      updateProfileUseCase: Get.find(),),
       fenix: true,);
    

  
  }
}
