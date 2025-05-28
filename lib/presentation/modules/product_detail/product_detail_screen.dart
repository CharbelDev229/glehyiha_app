import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/colors.dart';
import '../../../data/models/product/products.dart';
import '../../router/routes.dart';
import '../../widgets/product_detail_card/product_detail_card.dart';
import '../cart/cart_1_controller.dart';
import 'product_detail_1 controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  late final ProductDetailController productController;
  late final Cart1Controller cartController;

  @override
  void initState() {
    super.initState();

    // Si le contrôleur n'existe pas encore, on le crée
    if (!Get.isRegistered<Cart1Controller>()) {
      cartController = Get.put(Cart1Controller(), permanent: true);
    } else {
      cartController = Get.find<Cart1Controller>();
    }

    // Pareil pour productController
    if (!Get.isRegistered<ProductDetailController>()) {
      productController = Get.put(ProductDetailController());
    } else {
      productController = Get.find<ProductDetailController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si le contrôleur n'est pas encore prêt, on affiche un loader ou un placeholder
    if (!Get.isRegistered<Cart1Controller>()) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boutique', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryGreen,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  context.pushNamed(AppRoutesNames.cart);
                },
              ),
              Positioned(
                right: 9,
                top: 6,
                child: Obx(() {
                  final cartCount = cartController.cartCount;
                  return cartCount > 0
                      ? Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
            ProductDetailCard(product: widget.product),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: productController.decrement,
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Obx(
                      () => Text(
                        productController.quantity.value.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: productController.increment,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    try {
                      cartController.addToCart(
                        widget.product,
                        quantity: productController.quantity.value,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${productController.quantity.value} ${widget.product.name} ajouté(s) au panier",
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );

                      context.pushNamed(AppRoutesNames.cart);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Erreur: $e"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Ajouter au panier",
                    style: TextStyle(
                      fontSize: 16,
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
