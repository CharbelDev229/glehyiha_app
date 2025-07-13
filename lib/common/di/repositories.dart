import 'package:get/instance_manager.dart';

import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../data/data_source/auth/auth_remote_data_source.dart';
import '../../data/data_source/chat_room/chat_room_message_remote_data_source.dart';
import '../../data/data_source/commands/commands_local_data_source.dart';
import '../../data/data_source/commands/commands_remote_data_source.dart';
import '../../data/data_source/produit/produit_local_data_source.dart';
import '../../data/data_source/produit/produit_remote_data_source.dart';
import '../../data/data_source/profile/user_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/chat_room_message_repository_impl.dart';
import '../../data/repositories/commands_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/chat_room_message_repository.dart';
import '../../domain/repositories/commands_repositories.dart';
import '../../domain/repositories/product_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';

class DiRepositories {
  static void dependencies() {
    // Auth Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        authLocalDataSource: Get.find<AuthLocalDataSource>(),
        authRemoteDataSource: Get.find<AuthRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Profile Repository
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(
        authLocalDataSource: Get.find<AuthLocalDataSource>(),
        userRemoteDataSource: Get.find<UserRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Chat room message - FIX: Spécifier le type explicitement
    Get.lazyPut<ChatRoomMessageRepository>(
      () => ChatRoomMessageRepositoryImpl(
        chatRoomMessageRemoteDataSource: Get.find<ChatRoomMessageRemoteDataSource>(), // Spécifier le type
        authLocalDataSource: Get.find<AuthLocalDataSource>(),
      ),
      fenix: true,
    );

    // Commands Repository
    Get.lazyPut<CommandsRepository>(
      () => CommandsRepositoryImpl(
        commandsLocalDataSource: Get.find<CommandsLocalDataSource>(),
        commandsRemoteDataSource: Get.find<CommandsRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Product Repository
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        productLocalDataSource: Get.find<ProductLocalDataSource>(),
        productRemoteDataSource: Get.find<ProductRemoteDataSource>(),
      ),
      fenix: true,
    );
  }
}
