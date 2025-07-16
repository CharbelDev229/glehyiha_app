import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/controller/user_seller_cpntroller.dart';
import 'common/di/index.dart';
import 'presentation/modules/add_product/add_product_controller.dart';
import 'presentation/modules/cart/cart_1_controller.dart';
import 'presentation/modules/market/market_controller.dart';
import 'presentation/modules/order_detail/user_controller.dart';
import 'presentation/router/go_router.dart';
import 'common/constants/colors.dart';
import 'presentation/widgets/bottom_navigation_bar/navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔄 1. Injecter les usecases d'abord
  await Di.init(); // doit appeler DiUseCases.dependencies()

  // ✅ 2. Ensuite injecter les controllers (ils utilisent les usecases)
  Get.put(NavigationController());
  Get.put(Cart1Controller(), permanent: true);
  Get.put(UserController());
 Get.put(UserSellerController(), permanent: true);
 Get.lazyPut(() => AddProductController(
    createProductUseCase: Get.find(), getAllProductsUseCase: Get.find(),
  ), fenix: true);
  Get.put(MarketController());






  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoute.router,
        title: 'Glehyiha App',
        theme: ThemeData(
          primarySwatch: AppColors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
