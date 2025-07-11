import 'package:flutter/cupertino.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import '../../../common/constants/storage_keys.dart';

class WelcomeController {void redirectInApp(BuildContext context) {
  final isFirstTime = prefs.getBool(StorageKeys.isFirstTimeKey) ?? true;
  final token = prefs.getString(StorageKeys.token);

  if (isFirstTime) {
    // Première ouverture -> onboarding
    context.goNamed(AppRoutesNames.onboarding1);
  } else if (token != null && token.isNotEmpty) {
    // Utilisateur connecté -> paramètres
    context.goNamed(AppRoutesNames.parameters);
  } else {
    // Pas connecté -> page de connexion
    context.goNamed(AppRoutesNames.signIn);
  }
}

}
