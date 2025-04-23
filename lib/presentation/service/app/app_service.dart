import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../common/constants/instances.dart';
import '../../../common/constants/storage_keys.dart';
import '../../router/routes.dart';

class AppService extends GetxService {
  

  AppService();

  Future<AppService> init() async {

    return this;
  }

 // bool get isFirstTime => box.read(StorageKeys.isFirstTimeKey) ?? true;



  void redirectUserForTokenExpire(){
    prefs.remove(StorageKeys.token);
   // AppRoutesNames.navigatorKey.currentContext?.goNamed(AppRoutesNames.signIn,);
  }
}
