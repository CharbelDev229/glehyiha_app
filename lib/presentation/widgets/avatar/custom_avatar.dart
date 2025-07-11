import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../image_network/custom_image_network.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.imageUrl,
    required this.width,
    this.withBorder = true,
    this.borderRadius,
    this.border,
    this.height,
    this.fit,
    this.onTap, // 👈 Nouveau
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final bool withBorder;
  final BorderRadius? borderRadius;
  final Border? border;
  final BoxFit? fit;
  final VoidCallback? onTap; // 👈 Nouveau

  @override
  Widget build(BuildContext context) {
    final avatar = (imageUrl != null && (imageUrl?.isNotEmpty ?? false))
        ? CustomImageNetwork(
            fit: fit,
            imageUrl: imageUrl!,
            height: height,
            width: width,
            borderRadius: borderRadius ?? BorderRadius.zero,
            border: border,
          )
        : Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          );

    
    return GestureDetector(
      onTap: onTap,
      child: avatar,
    );
  }
}
