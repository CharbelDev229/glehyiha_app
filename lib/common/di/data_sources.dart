
import 'package:get/get.dart';

import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../data/data_source/auth/auth_remote_data_source.dart';

class DiDataSources {
  static void dependencies() {

 Get.lazyPut<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
      fenix: true,
    );

    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        dioRequestManager: Get.find(),
      ),
      fenix: true,
    );
    
  }
}
