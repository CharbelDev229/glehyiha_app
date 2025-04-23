import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';

class AppRoutesNames {
  static const welcome = 'welcome';
  static const login = 'login';
  static const signIn = 'sign_in';
  static const expert = 'expert';
  static const parameters = 'parameters';
  static const home = 'home';
  static const photo = 'photo';
  static const market = 'market';
  static const entrance = 'entrance';
  static const chat = 'chat';
  static const splash = 'splash';
  static const onboarding = 'onboarding';
  static const encadreur = 'complement_encadreur';
  static const vendeur = 'complement_vendeur';
  static const code = 'verification_code';
  static const forgetpassword = 'forget_password';
  
  

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  //fonction pour rediriger vers la page de connection
  void _redirecToLogin() {
    navigatorKey.currentContext?.goNamed(AppRoutesNames.signIn);
  }
}
