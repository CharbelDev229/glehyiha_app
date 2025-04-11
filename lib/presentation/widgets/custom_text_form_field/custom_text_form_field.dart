import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:glehiha/common/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isPhoneField;
 
  

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.isPhoneField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPhoneField) {
      return IntlPhoneField(
        controller: controller,
        cursorColor: AppColors.black,
        dropdownDecoration: const BoxDecoration(
          border: Border(),
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: AppColors.black),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
        ),
        initialCountryCode: 'BJ',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
        flagsButtonMargin: const EdgeInsets.only(left: 8),
      );
    }

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.black),
        prefixIcon: icon != null ? Icon(icon, color: AppColors.black) : null,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppColors.black, width: 2),
        ),
      ),
     
    );
  }
}
