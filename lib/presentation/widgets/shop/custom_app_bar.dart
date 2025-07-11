import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final Color color;
  

  const CustomAppBar({
    Key? key,
    required this.text,
    required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: color,
        title: Text(
        text,
        style:  TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
