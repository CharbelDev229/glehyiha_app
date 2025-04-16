import 'package:glehiha/presentation/modules/auth/sign_in/sign_in_controller.dart';
import 'package:glehiha/presentation/modules/auth/sign_up/sign_up_controller.dart';
import 'package:glehiha/presentation/modules/chat/chat_screen.dart';
import 'package:glehiha/presentation/modules/expert/expert_screen.dart';
import 'package:glehiha/presentation/modules/market/market_screen.dart';
import 'package:glehiha/presentation/modules/parameters/parameters_screen.dart';
import 'package:glehiha/presentation/modules/photo/photo_screen.dart';

import 'package:go_router/go_router.dart';
import '../modules/onboarding/onboarding_screen_3.dart';
import '../modules/onboarding/onboarding_screen_2.dart';
import '../modules/welcome/welcome_screen.dart';
import 'package:glehiha/presentation/modules/auth/sign_in/sign_in_screen.dart';
import 'package:glehiha/presentation/modules/auth/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/modules/onboarding/onboarding_screen.dart';

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
        path: '/home',
        name: AppRoutesNames.home,
        pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 500), 
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, ); }, );},),

      GoRoute(
       path: '/splash',
       name: AppRoutesNames.splash,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child: const SplashScreen(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,); },); },),

       GoRoute(
        path: '/onboarding',
        name: 'onboarding',
       pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
      child: const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
         child: child,);}, );},),

      GoRoute(
        path: '/sign_in',
        name: AppRoutesNames.signIn,
        pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 500), 
        child:  SignInScreen(
          controller: SignInController(),),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,);},);},),

      GoRoute(
       path: '/sign_up',
       name: AppRoutesNames.signUp,
       pageBuilder: (BuildContext context, GoRouterState state) {
       return CustomTransitionPage(
       key: state.pageKey,
       transitionDuration: const Duration(milliseconds: 500), 
       child:  SignUpScreen(
        controller: SignUpController(),
       ),
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
       path: '/complement_info_encadreur',
       name: AppRoutesNames.encadreur,
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
       path: '/complement_info_vendeur',
       name: AppRoutesNames.vendeur,
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
       child: const MarketScreen(),
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child, );},);},),



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
