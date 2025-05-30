
import 'package:get/get.dart';


import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../data/data_source/auth/auth_remote_data_source.dart';
import '../../data/data_source/chat_room/chat_room_message_remote_data_source.dart';
import '../../data/data_source/commands/commands_local_data_source.dart';
import '../../data/data_source/commands/commands_remote_data_source.dart';
import '../../data/data_source/profile/user_local_data_source.dart';
import '../../data/data_source/profile/user_remote_data_source.dart';

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
    // Profile Data Sources
    Get.lazyPut<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(
      //  box: Get.find(),
        dioRequestManager: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(),
      fenix: true,
    );
    

      ///Chat room message
    Get.lazyPut<ChatRoomMessageRemoteDataSource>(
          () => ChatRoomMessageRemoteDataSourceImpl(
        dioRequestManager: Get.find(),
      ),
      fenix: true,
    );

    
   Get.lazyPut<CommandsLocalDataSource>(
      () => CommandsLocalDataSourceImpl(),
      fenix: true,
    );

    Get.lazyPut<CommandsRemoteDataSource>(
      () => CommandsRemoteDataSourceImpl(
        dioRequestManager: Get.find(),
      ),
      fenix: true,
    );

    

  }
  
}
