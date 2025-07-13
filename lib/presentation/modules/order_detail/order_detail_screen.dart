import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/order_detail/order_detail_controller.dart';
import '../../../common/constants/colors.dart';
import '../cart/cart_1_controller.dart';
import 'user_controller.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final Cart1Controller cartController = Get.put(Cart1Controller());
  final OrderDetailController orderDetailController = Get.put(OrderDetailController());
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
print('Nom utilisateur : ${userController.lastName.value}');
  print('Prénom utilisateur : ${userController.firstName.value}');
  print('Email utilisateur : ${userController.email.value}');



    // Synchroniser les produits du panier avec le résumé
    orderDetailController.cartItems.assignAll(cartController.cartItems.map((item) {
      return CartItem(
        name: item.name,
        resume: item.resume,
        image: item.image,
        quantity: item.quantite,
        price: item.prix_unitaire,
      );
    }).toList());

    orderDetailController.calculateTotal();

    // Récupérer toutes les commandes enregistrées
    cartController.getAllCommandes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Récapitulatif de la commande",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),
            const Divider(),

            // Informations personnelles
            const Text("Informations personnelles", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Obx(() => Text("Nom : ${userController.lastName.value}")),
            Obx(() => Text("Prénom : ${userController.firstName.value}")),
            Obx(() => Text("Email : ${userController.email.value}")),

            const Divider(),

            // Adresse
            const Text("Adresse de livraison", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Obx(() => Text(userController.adress.value)),

            const Divider(),

            // Téléphone
            const Text("Numéro de téléphone", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Obx(() => Text(userController.phone.value)),

            const Divider(),

            // Commentaire
            const Text("Commentaire", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Obx(() => Text(userController.comment.value)),

            const Divider(),

            // Liste des produits dans le panier
            const Text("Liste de la commande", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 15),
            Obx(() => Column(
              children: cartController.cartItems.map((item) {
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
                            Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 5),
                            Text(item.resume, maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text("Qté: ${item.quantite}"),
                                ),
                                Text(
                                  "${(item.prix_unitaire * item.quantite).toStringAsFixed(0)} F",
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
            )),

            const SizedBox(height: 20),

            // Résumé de la commande en cours
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
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        "${orderDetailController.totalPrice.value.toStringAsFixed(0)} F",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: appeler la méthode de commande
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Commander", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // // --- Affichage de toutes les commandes enregistrées ---
            // const Text(
            //   "Historique des commandes enregistrées",
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10),

            // Obx(() {
            //   if (cartController.isLoadingCommandes.value) {
            //     return const Center(child: CircularProgressIndicator());
            //   }

            //   if (cartController.allCommandes.isEmpty) {
            //     return const Text("Aucune commande enregistrée.");
            //   }

            //   return Column(
            //     children: cartController.allCommandes.map((commande) {
            //       final totalCommande = commande.details.fold(
            //         0.0,
            //         (sum, item) => sum + (item.prix_unitaire * item.quantite),
            //       );

            //       return Card(
            //         margin: const EdgeInsets.only(bottom: 10),
            //         child: ListTile(
            //           title: Text("Commande - ${commande.statut}"),
            //           subtitle: Text(
            //             "Adresse : ${commande.adresse_livraison}\nTéléphone : ${commande.phone_number}",
            //           ),
            //           trailing: Text(
            //             "${totalCommande.toStringAsFixed(0)} F",
            //             style: const TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: AppColors.primaryGreen,
            //             ),
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   );
            // }),

            // const SizedBox(height: 20),

            // Obx(() => Text(
            //   "💰 Total de toutes les commandes : ${cartController.totalCommandesPrice.toStringAsFixed(0)} F",
            //   style: const TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //     color: AppColors.primaryGreen,
            //   ),
            // )),
          ],
        ),
      ),
    );
  }
}
