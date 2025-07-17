import 'package:get/get.dart';

// AUTH
import 'package:glehiha/domain/usescases/auth/login.dart';
import 'package:glehiha/domain/usescases/auth/sign_up.dart';
import 'package:glehiha/domain/usescases/auth/forgot_password.dart';
import 'package:glehiha/domain/usescases/auth/resent_code.dart';
import 'package:glehiha/domain/usescases/auth/resent_verification_code.dart';
import 'package:glehiha/domain/usescases/auth/reset_password.dart';
import 'package:glehiha/domain/usescases/auth/user_forgot_password.dart';
import 'package:glehiha/domain/usescases/auth/user_reset_password.dart';
import 'package:glehiha/domain/usescases/auth/verify_user_account.dart';

// USER
import 'package:glehiha/domain/usescases/user/change_password.dart';
import 'package:glehiha/domain/usescases/user/delete_account.dart';
import 'package:glehiha/domain/usescases/user/get_profile.dart';
import 'package:glehiha/domain/usescases/user/loyout.dart';
import 'package:glehiha/domain/usescases/user/update_profile.dart';

// CHAT ROOM MESSAGE
import 'package:glehiha/domain/usescases/chat_room_message/send_message_use_case.dart';
import 'package:glehiha/domain/usescases/chat_room_message/send_image_message_use_case.dart';
import 'package:glehiha/domain/usescases/chat_room_message/get_messages_use_case.dart.dart';
import 'package:glehiha/domain/usescases/chat_room_message/delete_message_use_case.dart';

// COMMANDS
import 'package:glehiha/domain/usescases/commands/commands_use_case.dart';
import 'package:glehiha/domain/usescases/commands/get_all_commande_use_case.dart';
import 'package:glehiha/domain/usescases/commands/delete_commads_use_case.dart';
import 'package:glehiha/domain/usescases/commands/get_commands_by_id_use_case.dart';
import 'package:glehiha/domain/usescases/commands/update_commande_status_use_case.dart';
import 'package:glehiha/domain/usescases/commands/update_commande_use_case.dart';

// PRODUCTS
import 'package:glehiha/domain/usescases/product/create_product.dart';
import 'package:glehiha/domain/usescases/product/get_all_products_use_case.dart';
import 'package:glehiha/domain/usescases/product/get_product_by_id_use_case.dart';
import 'package:glehiha/domain/usescases/product/update_product_use_case.dart';
import 'package:glehiha/domain/usescases/product/delete_product_use_case.dart';

class DiUseCases {
  static void dependencies() {
    // 🔐 AUTH
    Get.lazyPut(() => SignUpUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => LoginUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => ForgotPasswordUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => ResentCodeUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => ResentVerificationCodeUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => ResetPasswordUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => VerifyUserAccountUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => UserForgetPasswordUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => UserResetPasswordUseCase(repository: Get.find()), fenix: true);

    // 👤 USER
    Get.lazyPut(() => ChangePasswordUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => UpdateProfileUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => LogoutUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => DeleteAccountUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => GetProfileUseCase(repository: Get.find()), fenix: true);

    // 💬 CHAT ROOM MESSAGE
    Get.lazyPut(() => SendMessageUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => SendImageMessageUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => GetMessagesUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => DeleteMessageUseCase(repository: Get.find()), fenix: true);

    // 📦 COMMANDS
    Get.lazyPut(() => CommandsUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => GetAllCommandesUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => DeleteCommandeUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => GetCommandeByIdUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => UpdateCommandeStatusUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => UpdateCommandeUseCase(repository: Get.find()), fenix: true);

    // 🛒 PRODUCTS
    Get.lazyPut(() => CreateProductUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => GetAllProductsUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => GetProductByIdUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => UpdateProductUseCase(repository: Get.find()), fenix: true);
    Get.lazyPut(() => DeleteProductUseCase(repository: Get.find()), fenix: true);
  }
}
