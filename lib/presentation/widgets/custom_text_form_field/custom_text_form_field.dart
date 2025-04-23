import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon; // ✅ Ajouté
  final String? Function(String?)? validator;
  final bool isPhoneField;
  final int? maxLines;
  final int? minLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.icon,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon, // ✅ Ajouté
    this.validator,
    this.isPhoneField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: obscureText ? 1 : minLines,
      maxLines: obscureText ? 1 : maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: AppColors.black,
      decoration: _buildInputDecoration(),
      validator: validator,
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: AppColors.black),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      prefixIcon: prefixIcon ?? (icon != null ? Icon(icon, color: AppColors.black) : null), // ✅ Modifié
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.black, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.black),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}
