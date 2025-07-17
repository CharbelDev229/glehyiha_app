import 'package:get/get.dart';

// Data Sources
import 'package:glehiha/data/data_source/commands/commands_local_data_source.dart';
import 'package:glehiha/data/data_source/commands/commands_remote_data_source.dart';
import 'package:glehiha/data/data_source/expert/expert_remote_data_source.dart';
import 'package:glehiha/data/data_source/produit/produit_local_data_source.dart';
import 'package:glehiha/data/data_source/produit/produit_remote_data_source.dart';
import 'package:glehiha/data/data_source/auth/auth_local_data_source.dart';
import 'package:glehiha/data/data_source/auth/auth_remote_data_source.dart';
import 'package:glehiha/data/data_source/chat_room/chat_room_message_remote_data_source.dart';
import 'package:glehiha/data/data_source/profile/user_remote_data_source.dart';

// Repositories Impl
import 'package:glehiha/data/repositories/auth_repository.dart';
import 'package:glehiha/data/repositories/chat_room_message_repository_impl.dart';
import 'package:glehiha/data/repositories/commands_repository.dart';
import 'package:glehiha/data/repositories/expert_repository.dart';
import 'package:glehiha/data/repositories/product_repository.dart';
import 'package:glehiha/data/repositories/user_repository.dart';

// Domain Repositories Interfaces
import 'package:glehiha/domain/repositories/auth_repository.dart';
import 'package:glehiha/domain/repositories/chat_room_message_repository.dart';
import 'package:glehiha/domain/repositories/commands_repositories.dart';
import 'package:glehiha/domain/repositories/product_repository_impl.dart';
import 'package:glehiha/domain/repositories/user_repository.dart';

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

    // Chat room message Repository
    Get.lazyPut<ChatRoomMessageRepository>(
      () => ChatRoomMessageRepositoryImpl(
        chatRoomMessageRemoteDataSource: Get.find<ChatRoomMessageRemoteDataSource>(),
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

    // Expert Repository
    Get.lazyPut<ExpertRepository>(
      () => ExpertRepositoryImpl(
        expertRemoteDataSource: Get.find<ExpertRemoteDataSource>(),
      ),
      fenix: true,
    );
  }
}
