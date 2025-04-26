import 'package:flutter/cupertino.dart';
import 'package:glehiha/presentation/modules/onboarding/onboarding_screen_3.dart';

import 'package:go_router/go_router.dart';

class AppRoutesNames {
  static const welcome = 'welcome';
  static const signIn = 'sign_in';
  static const signUp = 'sign_up';
  static const expert = 'expert';
  static const parameters = 'parameters';
 
  static const photo = 'photo';
  static const market = 'market';

  static const chat = 'chat';
 
  static const onboarding1 = 'onboarding_1';
  static const onboarding2 = 'onboarding_2';
  static const onboarding3 = 'onboarding_3';
  static const encadreur = 'additional_info_encadreur';
  static const vendeur = 'additional_info_vendeur';
  static const code = 'verification_code';
  static const forgetpassword = 'forget_password';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  //fonction pour rediriger vers la page de connection
  void _redirecToLogin() {
    navigatorKey.currentContext?.goNamed(AppRoutesNames.signIn);
  }
}
