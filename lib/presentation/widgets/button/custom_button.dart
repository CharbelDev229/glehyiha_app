import 'package:flutter/material.dart';
import '../../../common/constants/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.height,
    this.padding,
    this.isLoading = false,
    this.borderRadius = BorderRadius.zero,
    this.width,
    this.elevation = 0,
    this.gradient,
    this.disabledBackgroundColor,
    this.foregroundColor,
    this.shape,
    this.isDisabled = false,
    this.side = BorderSide.none,
    this.border,
    this.shadow,
  });

  final void Function()? onPressed;
  final Widget? child;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final BorderRadiusGeometry borderRadius;
  final double elevation;
  final List<BoxShadow>? shadow;
  final BoxBorder? border;
  final Gradient? gradient;
  final Color? disabledBackgroundColor;
  final Color? foregroundColor;
  final OutlinedBorder? shape;
  final bool isDisabled;
  final BorderSide? side;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 317,
      height: 51,
      decoration: BoxDecoration(
        border: border,
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
        boxShadow: shadow,
      ),
      child: ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          disabledBackgroundColor:
              disabledBackgroundColor ?? AppColors.grey.withOpacity(0.3),
          overlayColor: AppColors.primaryGreen.withOpacity(0.1),
          minimumSize: Size(width ?? 0.0, height ?? 0.0),
          elevation: elevation,
          shadowColor: AppColors.primaryGreen,
          foregroundColor:
              foregroundColor ?? Theme.of(context).textTheme.bodyMedium?.color,
          backgroundColor:
              gradient != null
                  ? Colors.transparent
                  : isLoading
                  ? AppColors.primaryGreen
                  : backgroundColor ?? Theme.of(context).primaryColor,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: side ?? BorderSide.none,
              ),
        ),
        child:
            !isLoading
                ? child
                : const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
      ),
    );
  }
}
