import 'package:flutter/material.dart';


import '../../../common/constants/colors.dart'; // adapte le chemin selon ton projet

class CustomButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const CustomButtonWithIcon({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.primaryGreen,
    this.icon = Icons.arrow_forward_ios,
    this.iconBgColor = AppColors.primaryGreen,
    this.iconColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
