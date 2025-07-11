// import 'package:flutter/material.dart';

// import '../../common/constants/colors.dart';

// class CustomImageNetwork extends StatelessWidget {
//   final String imageUrl;
//   final double? width;
//   final double? height;
//   final BoxFit? fit;
//   final AlignmentGeometry alignment;
//   final ImageRepeat repeat;
//   final Color? color;
//   final BlendMode? colorBlendMode;
//   final FilterQuality filterQuality;
//   final bool matchTextDirection;
//   final bool gaplessPlayback;
//   final BorderRadiusGeometry borderRadius;
//   final Border? border; // Ajout du paramètre border
//   final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
//   final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
//   Widget Function(BuildContext, String, dynamic)? errorWidget;

//   CustomImageNetwork({
//     super.key,
//     required this.imageUrl,
//     this.width,
//     this.height,
//     this.fit,
//     this.alignment = Alignment.center,
//     this.repeat = ImageRepeat.noRepeat,
//     this.color,
//     this.colorBlendMode,
//     this.filterQuality = FilterQuality.low,
//     this.matchTextDirection = false,
//     this.gaplessPlayback = false,
//     this.loadingBuilder,
//     this.errorBuilder,
//     this.borderRadius = BorderRadius.zero,
//     this.border, // Initialisation du paramètre border
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: borderRadius,
//         border: border,
//       ),
//       child: ClipRRect(
//         borderRadius: borderRadius,
//         child: CachedNetworkImage(
//           imageUrl: imageUrl,
//           width: width,
//           height: height,
//           fit: fit ?? BoxFit.fill,
//           repeat: repeat,
//           color: color,
//           colorBlendMode: colorBlendMode,
//           filterQuality: filterQuality,
//           matchTextDirection: matchTextDirection,
//           errorWidget: errorWidget ??
//               (context, url, error) {
//                 debugPrint(
//                     "cached network image error : ${error.toString()} \n l'url : $url");
//                 return Container(
//                     height: height,
//                     width: width,
//                     color: AppColors.grey.withOpacity(0.2),
//                     child: const Icon(Icons.error));
//               },
//           placeholder: (context, url) => Container(
//             color: AppColors.grey.withOpacity(0.1),
//           ),
//           // progressIndicatorBuilder: (context, url, downloadProgress) =>
//           //     CircularProgressIndicator(value: downloadProgress.progress),
//         ),
//       ),
//     );
//   }
// }
