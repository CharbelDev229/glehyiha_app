import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../modules/my_profile/my_profile_controller.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: AssetImage("assets/logo/logo.png"),
            width: 94,
            height: 22,
          ),

          GestureDetector(
            onTap: () => context.pushNamed(AppRoutesNames.myprofile),

            child: CircleAvatar(
              radius: 29,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
