
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'custom_image_asset.dart';
// import 'custom_image_network.dart';

// class CustomAvatar extends StatelessWidget {
//   const CustomAvatar(
//       {super.key,
//       required this.imageUrl,
//       required this.width,
//       this.withBorder = true,
//       this.borderRadius,
//       this.border,
//       this.height,
//       this.fit});

//   final String? imageUrl;
//   final double? width;
//   final double? height;
//   final bool withBorder;
//   final BorderRadius? borderRadius;
//   final Border? border;

//   final BoxFit? fit;

//   @override
//   Widget build(BuildContext context) {
//     return (imageUrl != null && (imageUrl?.isNotEmpty ?? false))
//         ? CustomImageNetwork(
//             fit: fit,
//             imageUrl: imageUrl!,
//             height: height,
//             width: width,
//             borderRadius: borderRadius ?? BorderRadius.zero,
//             border: border,
//           )
//        : Container(
//           height: height,
//           width: width,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: borderRadius ?? BorderRadius.circular(8),
//             border: border,
//           ),
//           child: Icon(
//             Icons.person,
//             size: height != null ? height! * 0.6 : 24,
//             color: Colors.grey,
//           ));
        
// }
//   }

