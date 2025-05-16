import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/cart/cart_controller_1.dart';
import 'common/di/index.dart';
import 'presentation/modules/product_detail/product_detail_controller.dart';
import 'presentation/router/go_router.dart';
import 'common/constants/colors.dart';
import 'presentation/service/product/product_service.dart'; // <== 🔥 IMPORT À AJOUTER
import 'common/enums/user_role.dart';
import 'presentation/widgets/bottom_navigation_bar/navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationController());
  Get.put(CartController());
  await Di.init();
  final productService = Get.find<ProductService>();
  productService.setUserRole(UserRole.vendeur); // 🔄 Change ici selon le test

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
