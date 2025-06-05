import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/auth/forgot_password.dart';
import 'package:glehiha/domain/usescases/auth/resent_verification_code.dart';
import 'package:glehiha/domain/usescases/auth/sign_up.dart';
import 'package:glehiha/domain/usescases/auth/verify_user_account.dart';
import 'package:glehiha/presentation/modules/add_product/add_product.dart';
import 'package:glehiha/presentation/modules/cart/cart_screen.dart';
import 'package:glehiha/presentation/modules/chat/chat_controller.dart';
import 'package:glehiha/presentation/modules/expert_page/expert_page_screen.dart';
import 'package:glehiha/presentation/modules/modify/modify_controller.dart';
import 'package:glehiha/presentation/modules/onboarding/onboarding_controller.dart';
import 'package:glehiha/presentation/modules/order_detail/order_detail_screen.dart';
import 'package:glehiha/presentation/modules/product_detail/product_detail_screen.dart';
import 'package:glehiha/presentation/modules/my_profile/my_profile_controller.dart';
import 'package:glehiha/presentation/modules/my_profile/my_profile_sreen.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/product/products.dart';
import '../../domain/usescases/auth/reset_password.dart';
import '../modules/auth/forget_password/forget_password_controller.dart';
import '../modules/auth/forget_password/forget_password_screen.dart';
import '../modules/auth/reset_password/reset_password_controller.dart';
import '../modules/auth/reset_password/reset_password_screen.dart';
import '../modules/auth/sign_in/sign_in_controller.dart';
import '../modules/auth/sign_in/sign_in_screen.dart';
import '../modules/auth/sign_up/sign_up_controller.dart';
import '../modules/auth/sign_up/sign_up_screen.dart';
import '../modules/auth/verification_code/verification_code_controller.dart';
import '../modules/auth/verification_code/verification_code_screen.dart';
import '../modules/chat/chat_screen.dart';
import '../modules/expert/expert_screen.dart';
import '../modules/market/market_screen.dart';
import '../modules/modify/modify_screen.dart';
import '../modules/onboarding/onboarding_screen_3.dart';
import '../modules/onboarding/onboarding_screen_1.dart';
import '../modules/onboarding/onboarding_screen_2.dart';
import '../modules/parameters/parameters_controller.dart';
import '../modules/parameters/parameters_screen.dart';
import '../modules/welcome/welcome_controller.dart';
import '../modules/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/edit_personnal_info/edit_personnal_info_controller.dart';
import 'routes.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutesNames.welcome,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: WelcomeScreen(controller: WelcomeController()),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/onboarding1',
        name: AppRoutesNames.onboarding1,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: OnboardingScreen1(controller: OnboardingController()),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/onboarding2',
        name: AppRoutesNames.onboarding2,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: OnboardingScreen2(controller: OnboardingController()),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/onboarding3',
        name: AppRoutesNames.onboarding3,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 100),
            child: OnboardingScreen3(controller: OnboardingController()),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/sign_up',
        name: AppRoutesNames.signUp,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: SignUpScreen(
              controller: SignUpController(
                signUpUseCase: Get.find<SignUpUseCase>(),
              ),
            ),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/sign_in',
        name: AppRoutesNames.signIn,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: SignInScreen(
              controller: SignInController(loginUseCase: Get.find()),
            ),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/parameters',
        name: AppRoutesNames.parameters,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: ParametersScreen(controller: ParametersController()),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    
     GoRoute(
        path: '/my_profile',
        name: AppRoutesNames.myprofile,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: MyProfileScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },),

        GoRoute(
        path: '/modify',
        name: AppRoutesNames.modify,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: ModifyScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },),



      GoRoute(
        path: '/chat',
        name: AppRoutesNames.chat,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: ChatScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/expert',
        name: AppRoutesNames.expert,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: const ExpertScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/market',
        name: AppRoutesNames.market,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: const MarketScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/forget_password',
        name: AppRoutesNames.forgetpassword,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final forgotPasswordUseCase = Get.find<ForgotPasswordUseCase>();

          final controller = ForgetPasswordController(
            forgotPasswordUseCase: forgotPasswordUseCase,
          );

          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: ForgetPasswordScreen(controller: controller),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/reset_password',
        name: AppRoutesNames.resetcode,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final resetPasswordUseCase = Get.find<ResetPasswordUseCase>();

          final controller = ResetPasswordController(
            resetPasswordUseCase: resetPasswordUseCase,
          );

          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: ResetPasswordScreen(controller: controller),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/add_product',
        name: AppRoutesNames.addProduct,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: AddProduct(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/expert_page',
        name: AppRoutesNames.expertPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const ExpertPageScreen(name: 'name'),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/product_detail',
        name: AppRoutesNames.productDetail,
        pageBuilder: (context, state) {
          final product = state.extra as Product;
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: ProductDetailScreen(product: product),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/cart',
        name: AppRoutesNames.cart,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: CartScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/order_detail',
        name: AppRoutesNames.orderDetail,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: OrderDetailScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },

        routes: [
          GoRoute(
            path: 'verification_code',
            name: AppRoutesNames.code,
            pageBuilder: (BuildContext context, GoRouterState state) {
              final String email = state.extra as String;
              return CustomTransitionPage(
                key: state.pageKey,
                child: VerificationCodeScreen(
                  controller: Get.put(
                    VerificationCodeController(
                      resentVerificationCodeUseCase:
                          Get.find<ResentVerificationCodeUseCase>(),
                      email: email,
                      verfyUserAccountUseCase:
                          Get.find<VerifyUserAccountUseCase>(),
                    ),
                  ),
                ),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  // Animation lors de la transition vers la page VerificationCode
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),
          // GoRoute(
          //   path: 'reset_password',
          //   name: AppRoutesNames.resetPassword,
          //   pageBuilder: (BuildContext context, GoRouterState state) {
          //     final ResetPasswordExtra extra =
          //         state.extra as ResetPasswordExtra;
          //     return CustomTransitionPage(
          //       key: state.pageKey,
          //       child: ResetPasswordScreen(
          //         controller: Get.put(ResetPasswordController(
          //             resetPasswordExtra: extra,
          //             reInitPasswordUseCase: Get.find())),
          //       ),
          //       transitionsBuilder:
          //           (context, animation, secondaryAnimation, child) {
          //         // Animation lors de la transition vers la page ResetPassword
          //         return FadeTransition(
          //           opacity: animation,
          //           child: child,
          //         );
          //       },
        ],
      ),
    ],
  );

  static popUtil({required BuildContext context, required String page}) {
    final router = GoRouter.of(context);
    final GoRouterDelegate delegate = router.routerDelegate;
    final routes = delegate.currentConfiguration.routes;
    for (var i = 0; i < routes.length; i++) {
      final route = routes[i] as GoRoute;
      if (route.name == page) break;
      GoRouter.of(context).pop();
    }
  }
}
