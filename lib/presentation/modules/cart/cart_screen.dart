import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';


import '../../../domain/usescases/commands/commands_use_case.dart';
import '../../widgets/order_form_bottom_sheet/order_form_bottom_controller.dart';
import '../../widgets/order_form_bottom_sheet/order_form_bottom_sheet.dart';
import '../product_detail/product_detail_1 controller.dart';
import 'cart_1_controller.dart';

class CartScreen extends StatelessWidget {
  final Cart1Controller cartController = Get.put(Cart1Controller());
  final ProductDetailController productController = Get.put(
    ProductDetailController(),
  );

  final OrderFormContentController controller;

  CartScreen({Key? key})
    : controller = Get.put(
        OrderFormContentController(
          commandsUseCase: _getCommandsUseCase(),
        ),
      ),
      super(key: key);

  static CommandsUseCase _getCommandsUseCase() {
    try {
      return Get.find<CommandsUseCase>();
    } catch (e) {
      // Si CommandsUseCase n'est pas trouvé, lancez une erreur explicite
      throw Exception(
        'CommandsUseCase n\'est pas enregistré. '
        'Veuillez l\'enregistrer dans votre fichier d\'initialisation des dépendances '
        'avec Get.put(CommandsUseCase(...)) ou Get.lazyPut(() => CommandsUseCase(...))'
      );
    }
  }

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
        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text("Votre panier est vide."));
        }

        return Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 211, 208, 208),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.image,
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                    onPressed:
                                        () =>
                                            cartController.removeFromCart(item),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.resume,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed:
                                              productController.decrement,
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Obx(
                                        () => Text(
                                          productController.quantity.value
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed:
                                              productController.increment,
                                          icon: const Icon(
                                            Icons.add,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${item.price} F",
                                    style: TextStyle(
                                      color: AppColors.primaryGreen,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
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
            const SizedBox(height: 30),
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
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 208, 208),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
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
                        Text(
                          "${cartController.totalPrice.toStringAsFixed(0)} F",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder:
                              (context) =>
                                  OrderFormContent(controller: controller),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Commander",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}