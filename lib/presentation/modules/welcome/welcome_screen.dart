import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/background_decoration/background_decoration.dart';
import 'package:glehiha/common/constants/assets/logo_assets.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      // Code à exécuter après 2 secondes

       context.pushNamed(AppRoutesNames.home);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundDecoration(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                LogoAssets.frame1,
      height: 96,
                width: 203,
                fit: BoxFit.contain,
              ),

              Transform.translate(
                offset: Offset(0, -20),
                child: Image.asset(
                  LogoAssets.frame2,
                  height: 22,
                  width: 168,
fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}