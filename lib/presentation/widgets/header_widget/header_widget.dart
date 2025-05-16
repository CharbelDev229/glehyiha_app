import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/logo/logo.png", width: 94, height: 22),
          SizedBox(height: 5),
          Image.asset("assets/images/account.png", width: 66, height: 58),
        ],
      ),
    );
  }
}
