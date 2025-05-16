import 'package:flutter/material.dart';
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
              '${product.price} F',
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
          "Quantité disponible : ${product.quantity}",
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
