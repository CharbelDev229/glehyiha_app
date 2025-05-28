import 'package:get/get.dart';

import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../data/data_source/auth/auth_remote_data_source.dart';
import '../../data/data_source/profile/user_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/chat_room_message_repository_impl.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/chat_room_message_repository.dart';
import '../../domain/repositories/user_repository.dart';

class DiRepositories {
  static void dependencies() {
     Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
          authLocalDataSource: Get.find<AuthLocalDataSource>(),
          authRemoteDataSource: Get.find<AuthRemoteDataSource>()),
      fenix: true,
    );
     // Profile Repository
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
          authLocalDataSource: Get.find<AuthLocalDataSource>(),
          userRemoteDataSource: Get.find<UserRemoteDataSource>()),
      fenix: true,
    );

    //Chat room message
    Get.lazyPut<ChatRoomMessageRepository>(
      () => ChatRoomMessageRepositoryImpl(
        chatRoomMessageRemoteDataSource: Get.find(),
        authLocalDataSource: Get.find(),
      ),
      fenix: true,
    );
  }
}
