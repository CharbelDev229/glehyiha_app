import 'package:get/get.dart';

import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../data/data_source/auth/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';

class DiRepositories {
  static void dependencies() {
     Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
          authLocalDataSource: Get.find<AuthLocalDataSource>(),
          authRemoteDataSource: Get.find<AuthRemoteDataSource>()),
      fenix: true,
    );
  }
}
