import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glehiha/domain/repositories/commands_repositories.dart';
import 'package:glehiha/presentation/service/profile%20service%20.dart';
import 'common/di/index.dart';
import 'domain/usescases/commands/commands_use_case.dart';
import 'presentation/modules/cart/cart_1_controller.dart';
import 'presentation/modules/order_detail/user_controller.dart';
import 'presentation/modules/my_profile/my_profile_controller.dart';
import 'presentation/router/go_router.dart';
import 'common/constants/colors.dart';
import 'presentation/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'presentation/widgets/order_form_bottom_sheet/order_form_bottom_controller.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Injecter les controllers et use cases
  Get.put(NavigationController());
  Get.put(Cart1Controller(), permanent: true);
  Get.put(UserController());
  

  // Injecter CommandsUseCase
  //Get.put(CommandsUseCase());

  // Injecter OrderFormContentController avec l’instance CommandsUseCase récupérée
 // final commandsUseCase = Get.find<CommandsUseCase>();
 // Get.put(OrderFormContentController(commandsUseCase: commandsUseCase));

  await Di.init();

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
