import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/cart/cart_controller_1.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/colors.dart';
import '../../router/routes.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/order_form_bottom_sheet/order_form_bottom_sheet.dart';

class CartScreen extends StatelessWidget {
  final CartController1 controller = Get.find<CartController1>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Panier",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text("Votre panier est vide."));
        }

        return Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          item.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.black),
                                onPressed: () => controller.removeFromCart(item),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => controller.decrementQuantity(item),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    onPressed: () => controller.incrementQuantity(item),
                                    icon: const Icon(Icons.add),
                                  ),
                                  const SizedBox(width: 8),
                                  Text("${item.price} FCFA"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.pushNamed(AppRoutesNames.market);
                },
                child: const Text(
                  "Continuer votre achat",
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total :",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Text(
                    "${controller.totalPrice.toStringAsFixed(0)} F",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: CustomButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => const Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
                      child: OrderFormBottomSheet(),
                    ),
                  );
                },
                child: const Text(
                  "Commander",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
