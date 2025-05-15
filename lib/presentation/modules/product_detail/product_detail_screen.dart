import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/colors.dart';
import '../../../data/models/product_detail/product_model.dart';
import '../../widgets/button/custom_button.dart';
import 'product_detail_1 controller.dart';
import 'product_detail_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  ProductDetailScreen({super.key, required this.product});
  final ProductDetailController controller = Get.put(ProductDetailController());
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Boutique',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              // Badge compteur GetX
              Positioned(
                right: 6,
                top: 6,
                child: Obx(() {
                  final cartCount = Get.find<CartController>().cartCount;
                  return cartCount > 0
                      ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                      : const SizedBox();
                }),
              ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image en haut
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Nom du produit
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
                SizedBox(width: 50),
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
              "Quantite disponible : ${product.quantity}",
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
              "Catégorie : ${product.category}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),
            // Description

            // if (product.description != null)
            Text(
              product.description!,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => Row(
                    children: [
                      IconButton(
                        onPressed: controller.decrement,
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        controller.quantity.value.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: controller.increment,
                        icon: const Icon(Icons.add_circle, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                CustomButton(
                  onPressed: () {
                    for (int i = 0; i < controller.quantity.value; i++) {
                      cartController.addToCart(product);
                    }
                    Get.snackbar(
                      "Succès",
                      "${controller.quantity.value} ${product.name} ajouté(s) au panier",
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                    context.pushNamed(AppRoutesNames.cart);
                  },
                  child: const Text(
                    "Ajouter au panier",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
