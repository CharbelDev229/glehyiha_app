import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/data/models/product/products.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/product_detail_card/product_detail_card.dart';
import 'product_detail_controller.dart';
import 'product_detail_1 controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen({super.key, required this.product});

  final ProductDetailController controller = Get.put(ProductDetailController());
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boutique', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryGreen,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                right: 9,
                top: 6,
                child: Obx(() {
                  final cartCount = Get.find<CartController>().cartCount;
                  return cartCount > 0
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.green,
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
          children: [
            ProductDetailCard(product: product),
            const SizedBox(height: 30),

            // Ajout panier
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => Row(
                      children: [
                        IconButton(
                          onPressed: controller.decrement,
                          icon: const Icon(Icons.remove_circle, color: Colors.blue),
                        ),
                        Text(
                          controller.quantity.value.toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: controller.increment,
                          icon: const Icon(Icons.add_circle, color: Colors.blue),
                        ),
                      ],
                    )),
                const Spacer(),
                ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "Ajouter au panier",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
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
