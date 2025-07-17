import 'package:get/get.dart';

// UseCases pour le profil
import '../../domain/usescases/user/change_password.dart';
import '../../domain/usescases/user/delete_account.dart';
import '../../domain/usescases/user/get_profile.dart';
import '../../domain/usescases/user/loyout.dart';
import '../../domain/usescases/user/update_profile.dart';

// Services
import '../../presentation/service/app/app_service.dart';
import '../../presentation/service/cart/cart_service.dart';
import '../../presentation/service/product/product_service.dart';
import '../../presentation/service/profile_service.dart';

// Repositories (pour injection dans les services)
import '../../domain/repositories/product_repository_impl.dart';

class DiServices {
  static Future<void> dependencies() async {
    // App Service
    Get.lazyPut(() => AppService());

    // Product Service, dépend du ProductRepository
    Get.lazyPut(() => ProductService(
          productRepository: Get.find<ProductRepository>(),
        ));

    // Cart Service
    Get.lazyPut(() => CartService());

    // Profile Service avec tous les UseCases injectés
    Get.lazyPut(
      () => ProfileService(
        getProfileUseCase: Get.find<GetProfileUseCase>(),
        logoutUseCase: Get.find<LogoutUseCase>(),
        deleteAccountUseCase: Get.find<DeleteAccountUseCase>(),
        changePasswordUseCase: Get.find<ChangePasswordUseCase>(),
        updateProfileUseCase: Get.find<UpdateProfileUseCase>(),
      ),
      fenix: true,
    );
  }
}
