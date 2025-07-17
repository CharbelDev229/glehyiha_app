
import 'package:get/get.dart';
import 'package:glehiha/data/data_source/commands/commands_local_data_source.dart';
import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../data/data_source/auth/auth_remote_data_source.dart';
import '../../data/data_source/chat_room/chat_room_message_remote_data_source.dart';
import '../../data/data_source/commands/commands_remote_data_source.dart';
import '../../data/data_source/produit/produit_local_data_source.dart';
import '../../data/data_source/produit/produit_remote_data_source.dart';
import '../../data/data_source/profile/user_remote_data_source.dart';
import '../helpers/request_manager.dart';



class DiDataSources {
  static void dependencies() {
    // Auth Data Sources
    Get.lazyPut<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
      fenix: true,
    );
    
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        dioRequestManager: Get.find<DioRequestManager>(),
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


    // Commands Data Sources
    Get.lazyPut<CommandsLocalDataSource>(
      () => CommandsLocalDataSourceImpl(),
      fenix: true,
    );
    
    Get.lazyPut<CommandsRemoteDataSource>(
      () => CommandsRemoteDataSourceImpl(
        dioRequestManager: Get.find<DioRequestManager>(),
      ),
      fenix: true,
    );

    // Product Data Sources
    Get.lazyPut<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(),
      fenix: true,
    );
    
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
        dioRequestManager: Get.find<DioRequestManager>(),
      ),
      fenix: true,
    );

    // User Data Source
    Get.lazyPut<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(
        dioRequestManager: Get.find<DioRequestManager>(),
      ),
      fenix: true,
    );

    // Chat Room Message Data Source
    Get.lazyPut<ChatRoomMessageRemoteDataSource>(
      () => ChatRoomMessageRemoteDataSourceImpl(
        dioRequestManager: Get.find<DioRequestManager>(),
      ),
      fenix: true,
    );
  }
}

