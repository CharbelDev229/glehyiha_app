import 'package:flutter/material.dart';
//
// class CustomAssetImage extends StatelessWidget {
//   final String assetPath;
//   final Color? color;
//   final double? width;
//   final double? height;
//   final BoxFit? fit;
//
//   const CustomAssetImage({
//     Key? key,
//     required this.assetPath,
//     this.color,
//     this.width,
//     this.height,
//     this.fit,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       assetPath,
//       color: color,
//       width: width,
//       height: height,
//       fit: fit,
//     );
//   }
// }

class CustomImageAsset extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlendMode;
  final BorderRadius? borderRadius;
  final Border? border;

  const CustomImageAsset({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.colorBlendMode,
    this.borderRadius,
    this.border
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          assetName,
          width: width,
          height: height,
          fit: fit ?? BoxFit.fill,
          color: color,
          colorBlendMode: colorBlendMode,
        ),
      ),
    );
  }
}
