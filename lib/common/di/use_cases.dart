
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
  }}