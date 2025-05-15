
import 'package:get/get.dart';
import 'package:glehiha/domain/usescases/auth/sign_up.dart';
import 'package:glehiha/presentation/modules/add_product/add_product.dart';
import 'package:glehiha/presentation/modules/expert_page/expert_page_screen.dart';
import 'package:go_router/go_router.dart';import '../modules/auth/forget_password/forget_password_controller.dart';
import '../modules/auth/forget_password/forget_password_screen.dart';
import '../modules/auth/sign_in/sign_in_controller.dart';
import '../modules/auth/sign_in/sign_in_screen.dart';
import '../modules/auth/sign_up/sign_up_controller.dart';
import '../modules/auth/sign_up/sign_up_screen.dart';
import '../modules/auth/verification_code/verification_code_controller.dart';
import '../modules/auth/verification_code/verification_code_screen.dart';
import '../modules/chat/chat_screen.dart';
import '../modules/expert/expert_screen.dart';
import '../modules/market/market_screen.dart';
import '../modules/onboarding/onboarding_screen_3.dart';
import '../modules/onboarding/onboarding_screen_1.dart';
import '../modules/onboarding/onboarding_screen_2.dart';
import '../modules/parameters/parameters_screen.dart';
import '../modules/photo/photo_screen.dart';
import '../modules/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

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
       child: const WelcomeScreen(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,); }, );},),

      GoRoute(
        path: '/onboarding1',
        name: AppRoutesNames.onboarding1,
        pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 500), 
        child:  OnboardingScreen1(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, ); }, );},),

      GoRoute(
       path: '/onboarding2',
       name: AppRoutesNames.onboarding2,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child: OnboardingScreen2(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,); },); },),

       GoRoute(
        path: '/onboarding3',
        name: AppRoutesNames.onboarding3,
       pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 100), 
      child: OnboardingScreen3(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
         child: child,);}, );},),

      GoRoute(
        path: '/sign_up',
        name: AppRoutesNames.signUp,
        pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 500),
        child:  SignUpScreen(
          controller: SignUpController(signUpUseCase: Get.find<SignUpUseCase>(),),),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,);},);},),

      GoRoute(
       path: '/sign_in',
       name: AppRoutesNames.signIn,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child:  SignInScreen(
        controller: SignInController(loginUseCase: Get.find(), ),),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, );},);},),

      GoRoute(
        path: '/parameters',
        name: AppRoutesNames.parameters,
        pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 500), 
        child: const ParametersScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,);}, );},),
     
      GoRoute(
       path: '/chat',
       name: AppRoutesNames.chat,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child:  ChatScreen(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, );},);},),

     GoRoute(
       path: '/expert',
       name: AppRoutesNames.expert,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child: const ExpertScreen(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, );},);},),

     GoRoute(
       path: '/photo',
       name: AppRoutesNames.photo,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child: const PhotoScreen(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, );},);},),

    GoRoute(
       path: '/market',
       name: AppRoutesNames.market,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child: const MarketScreen(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, );},);},),


  
       GoRoute(
       path: '/verification_code',
       name: AppRoutesNames.code,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child: VerificationCodeScreen(controller: VerificationCodeController()),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, );},);},),

      GoRoute(
        path: '/forget_password',
        name: AppRoutesNames.forgetpassword,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 500),
            child: ForgetPasswordScreen(controller: ForgetPasswordController()),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child, );},);},),


        GoRoute(
        path: '/add_product',
        name: AppRoutesNames.addProduct,
        pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 500), 
        child:  AddProduct(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, ); }, );},),

           GoRoute(
        path: '/expert_page',
        name: AppRoutesNames.expertPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 500), 
        child:  ExpertPageScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, ); }, );},),




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
