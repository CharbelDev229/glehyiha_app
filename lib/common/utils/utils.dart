
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Utils {
  static deviceW(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static deviceH(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static proportionalWidthSize(
      {required BuildContext context, required double width}) {
    return deviceW(context) > 430 ? width : deviceW(context) * width / 600;
  }

  static proportionalHeightSize(
      {required BuildContext context, required double height}) {
    return deviceH(context) > 932 ? height : deviceW(context) * height / 932;
  }

  static snackError({required BuildContext context, required String message}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        backgroundColor: AppColors.danger,
        message: message,
        icon: const SizedBox(),
      ),
      displayDuration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 300),
    );
  }

  static snackSuccess(
      {required BuildContext context, required String message}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        backgroundColor: AppColors.success,
        message: message,
        icon: const SizedBox(),
      ),
      displayDuration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 300),
    );
  }

  static snackInfo({required BuildContext context, required String message}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        backgroundColor: AppColors.secondaryColor,
        message: message,
        icon: const SizedBox(),
      ),
      displayDuration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 300),
    );
  }

  static snackWarning(
      {required BuildContext context, required String message}) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        backgroundColor: AppColors.black.withOpacity(0.6),
        message: message,
        icon: const SizedBox(),
      ),
      displayDuration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 300),
    );
  }



}
