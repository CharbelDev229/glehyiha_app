
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/auth/forgot_password.dart';
import 'package:glehiha/domain/usescases/auth/resent_code.dart';
import 'package:glehiha/domain/usescases/auth/resent_verification_code.dart';
import 'package:glehiha/domain/usescases/auth/reset_password.dart';
import 'package:glehiha/domain/usescases/auth/user_forgot_password.dart';
import 'package:glehiha/domain/usescases/auth/user_reset_password.dart';
import 'package:glehiha/domain/usescases/auth/verify_user_account.dart';

import '../../domain/usescases/auth/login.dart';
import '../../domain/usescases/auth/sign_up.dart';
import '../../domain/usescases/chat_room_message/delete_message_use_case.dart';
import '../../domain/usescases/chat_room_message/get_messages_use_case.dart.dart';
import '../../domain/usescases/chat_room_message/send_message_use_case.dart';
import '../../domain/usescases/user/change_password.dart';
import '../../domain/usescases/user/delete_account.dart';
import '../../domain/usescases/user/get_profile.dart';
import '../../domain/usescases/user/loyout.dart';
import '../../domain/usescases/user/update_profile.dart';

class DiUseCases {
  static void dependencies() {
    Get.lazyPut(() => SignUpUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => LoginUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(
      () => ForgotPasswordUseCase(repository: Get.find()),
      fenix: true,
    );
    
    Get.lazyPut(() => ResentCodeUseCase(repository: Get.find()),
        fenix: true);
    Get.lazyPut(
      () => ResentVerificationCodeUseCase(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => ResetPasswordUseCase(repository: Get.find()),
      fenix: true,
    );
     Get.lazyPut(
      () => VerifyUserAccountUseCase(repository: Get.find()),
      fenix: true,
    );
     Get.lazyPut(
      () => UserForgetPasswordUseCase(repository: Get.find()),
      fenix: true,
    );
     Get.lazyPut(
      () => UserResetPasswordUseCase(repository: Get.find()),
      fenix: true,
    );



     Get.lazyPut(
      () => ChangePasswordUseCase(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => UpdateProfileUseCase(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => LogoutUseCase(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => DeleteAccountUseCase(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(
      () => GetProfileUseCase(repository: Get.find()),
      fenix: true,
    );


    // ChatRoomMessage
    /// SendMessageUseCase
    Get.lazyPut(
      () => SendMessageUseCase(repository: Get.find()),
      fenix: true,
    );

    /// GetMessagesUseCase
    Get.lazyPut(
      () => GetMessagesUseCase(repository: Get.find()),
      fenix: true,
    );

    /// DeleteMessageUseCase
    Get.lazyPut(
      () => DeleteMessageUseCase(repository: Get.find()),
      fenix: true,
    );
   
  }}