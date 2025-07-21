import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/custom_image_asset.dart';
import 'package:glehiha/presentation/widgets/image_network/custom_image_network.dart';
import '../../../common/constants/colors.dart';
import '../../../data/models/product/products.dart';

class ProductDetailCard extends StatelessWidget {
  final Product product;

  const ProductDetailCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            product.image,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),

        // Nom + Prix
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 50),
            Text(
              '${product.prix_unitaire} F',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Text(
          "Quantité disponible : ${product.quantite}",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Vendeur : ${product.seller}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "Catégorie : ${product.category.name}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          product.description,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ProductImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ProductImageWidget({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Si c'est une URL complète
    if (imageUrl.startsWith('http')) {
      return CustomImageNetwork(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
      );
    }
    
    // Si c'est un asset local
    return CustomImageAsset(
      assetName: imageUrl,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
