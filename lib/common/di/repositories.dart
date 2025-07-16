import 'package:get/get.dart';
import 'package:glehiha/data/data_source/commands/commands_local_data_source.dart';
import 'package:glehiha/data/data_source/expert/expert_remote_data_source.dart';
import 'package:glehiha/data/repositories/commands_repository.dart';
import 'package:glehiha/data/repositories/expert_repository.dart';

import '../../data/data_source/auth/auth_local_data_source.dart';
import '../../data/data_source/auth/auth_remote_data_source.dart';
import '../../data/data_source/chat_room/chat_room_message_remote_data_source.dart';
import '../../data/data_source/commands/commands_remote_data_source.dart';
import '../../data/data_source/profile/user_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/chat_room_message_repository_impl.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/chat_room_message_repository.dart';
import '../../domain/repositories/commands_repositories.dart';
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
        remoteDataSource: Get.find<ChatRoomMessageRemoteDataSource>(),
        authLocalDataSource: Get.find<AuthLocalDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut<CommandsRepository>(
      () => CommandsRepositoryImpl(
        commandsRemoteDataSource: Get.find<CommandsRemoteDataSource>(),
        commandsLocalDataSource: Get.find<CommandsLocalDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut<ExpertRepository>(
      () => ExpertRepositoryImpl(
        expertRemoteDataSource: Get.find<ExpertRemoteDataSource>(),
      ),
      fenix: true,
    );

  }
}
