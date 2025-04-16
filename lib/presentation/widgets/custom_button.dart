import 'package:flutter/material.dart';
import '../../../common/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
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
  // final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final BoxBorder? border;
  final Gradient? gradient;
  final Color? disabledBackgroundColor;
  final Color? foregroundColor;
  final OutlinedBorder? shape;
  final bool isDisabled;
  final BorderSide? side;

  // final double borderWidth;
  // final Color borderColor;
  // final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      // height: height,
      // constraints: const BoxConstraints(maxWidth: 430),
      decoration: BoxDecoration(
        // shape: shape == CircleBorder() ? BoxShape.circle : BoxShape.rectangle,
        // color: isLoading
        //     ? AppColors.secondaryColor
        //     : backgroundColor ?? Theme.of(context).primaryColor,
        // borderRadius: shape == null ? borderRadius : null,
        //   boxShadow: shadow,
          border: border,
          gradient: gradient,
        borderRadius: borderRadius
        // border: hasBorder ? Border.all(color: borderColor, width: borderWidth) : null
      ),
      child: ElevatedButton(
        onPressed: !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          disabledBackgroundColor: disabledBackgroundColor ?? AppColors.grey.withValues(alpha: .3),
          overlayColor: AppColors.grey.withValues(alpha: 0.1),
          minimumSize: Size(width ?? 0.0, height ?? 0.0),
          elevation: elevation,
          shadowColor: AppColors.grey,
          foregroundColor: foregroundColor ?? Theme.of(context).textTheme.bodyMedium?.color,
          backgroundColor: gradient != null ? Colors.transparent : isLoading
              ? AppColors.grey
              : backgroundColor ?? Theme.of(context).primaryColor,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
          shape: shape ?? RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: side ??
                  BorderSide.none
          ),
        ),
        child: !isLoading
            ? child
            : const SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
