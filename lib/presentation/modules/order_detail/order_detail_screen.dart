import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/order_detail/order_detail_controller.dart';

import '../../../common/constants/colors.dart';
import '../product_detail/product_detail_controller.dart';
import 'user_controller.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final CartController cartController = Get.put(CartController());
  final OrderDetailController orderDetailController = Get.put(
    OrderDetailController(),
  );

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    orderDetailController.calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Récapitulatif de la commande",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryGreen,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Veuillez vérifier vos informations avant le paiement",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Dash(
              direction: Axis.horizontal,
              length: MediaQuery.of(context).size.width - 32,
              dashLength: 5,
              dashColor: Colors.grey,
            ),
            const SizedBox(height: 10),

            // Informations personnelles
            const Text(
              "Informations personnelles",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text("Nom : ${userController.lastName.value}"),
            const SizedBox(height: 10),
            Text("Prénom : ${userController.firstName.value}"),
            const SizedBox(height: 10),
            Text("Email : ${userController.email.value}"),
            const SizedBox(height: 10),
            Dash(
              direction: Axis.horizontal,
              length: MediaQuery.of(context).size.width - 32,
              dashLength: 5,
              dashColor: Colors.grey,
            ),
            const SizedBox(height: 10),

            // Adresse de livraison
            const Text(
              "Adresse de livraison",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Obx(() => Text(userController.adress.value)),
            const SizedBox(height: 10),
            Dash(
              direction: Axis.horizontal,
              length: MediaQuery.of(context).size.width - 32,
              dashLength: 5,
              dashColor: Colors.grey,
            ),
            const SizedBox(height: 10),

            // Téléphone
            const Text(
              "Numéro de téléphone",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(userController.phone.value),
            const SizedBox(height: 10),
            Dash(
              direction: Axis.horizontal,
              length: MediaQuery.of(context).size.width - 32,
              dashLength: 5,
              dashColor: Colors.grey,
            ),
            const SizedBox(height: 10),

            // Commentaire
            const Text(
              "Commentaire",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Obx(() => Text(userController.comment.value)),
            const SizedBox(height: 10),
            Dash(
              direction: Axis.horizontal,
              length: MediaQuery.of(context).size.width - 32,
              dashLength: 5,
              dashColor: Colors.grey,
            ),
            const SizedBox(height: 10),

            // Liste des produits
            const Text(
              "Liste de la commande",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),

            Obx(
              () => Column(
                children:
                    cartController.cartItems.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item.resume,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text("Qté: ${item.quantity}"),
                                      ),
                                      Text(
                                        "${(double.parse(item.price.toString()) * int.parse(item.quantity.toString())).toStringAsFixed(0)} F",
                                        style: TextStyle(
                                          color: AppColors.primaryGreen,
                                          fontWeight: FontWeight.bold,
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
                    }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Résumé de la commande
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 211, 208, 208),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 8),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      Obx(() => Text(
                     "${orderDetailController.totalPrice.value.toStringAsFixed(0)} F",
                       style: const TextStyle(
                       fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                               ),
                                 ),
                                    )   ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Commander",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
