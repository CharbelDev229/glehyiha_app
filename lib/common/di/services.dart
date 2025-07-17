import 'package:get/get.dart';

import '../../presentation/service/app/app_service.dart';
import '../../presentation/service/cart/cart_service.dart';
import '../../presentation/service/product/product_service.dart';
import '../../presentation/service/profile_service.dart';



class DiServices {
  static Future<void> dependencies() async {
    Get.lazyPut(() => AppService());
    Get.lazyPut(() => ProductService(productRepository: Get.find()));
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