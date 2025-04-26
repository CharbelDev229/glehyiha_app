import 'package:get/get.dart';

import '../../presentation/service/app/app_service.dart';

class DiServices {
  static dependencies() async {
   Get.lazyPut(
      () => AppService(
       
      ),
    );

   
  }
}
