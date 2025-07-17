import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/domain/usescases/commands/commands_use_case.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/instances.dart';
import '../../../common/dtos/commands/commands_items_dto.dart';
import '../../../common/enums/commande_statut.dart';
import '../../modules/cart/cart_1_controller.dart';
import '../../modules/order_detail/user_controller.dart';

class OrderFormContentController extends GetxController {
  final CommandsUseCase commandsUseCase;

  /// Formulaire
  final formKey = GlobalKey<FormState>();

  /// Champs visibles
  final adresseController = TextEditingController();
  final commentaireController = TextEditingController();
  final phoneNumberController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool commandsInLoading = false.obs;
  RxString selectedCountryCode = '+229'.obs;
  RxBool autoValidate = false.obs;
final statut = CommandeStatut.enAttente.obs;
  /// Constructeur
  OrderFormContentController({required this.commandsUseCase});

  /// Obtenir le numéro complet
  String getCompletePhoneNumber() {
    return selectedCountryCode.value + phoneNumberController.text.trim();
  }

  /// Fonction principale d’envoi de commande
  Future<bool> commande(BuildContext context) async {
    bool success = false;
    commandsInLoading.value = true;

    // 🔎 On récupère le panier
    final cartController = Get.find<Cart1Controller>();
    final cartItems = cartController.cartItems;

    if (cartItems.isEmpty) {
      Utils.snackError(context: context, message: 'Aucun produit dans la commande.');
      commandsInLoading.value = false;
      return false;
    }

    // 🧾 Conversion en liste de CommandItemDto
    final items = cartItems.map((item) {
      return CommandItemDto(
        produit_id: item.product_id,
        quantite: item.quantite,
        prix_unitaire: item.prix_unitaire,
      );
    }).toList();

    // 🧾 Création du DTO de commande
    final dto = CommandsDto(
      adresse_livraison: adresseController.text.trim(),
      commentaire: commentaireController.text.trim(),
      phone_number: getCompletePhoneNumber(),
      statut: statut.value,
      details: items,
    );

    print("📦 Données de commande envoyées : ${dto.toMap()}");

    // 🔁 Appel de l’useCase
    final send = await commandsUseCase.call(CommandsParams(dto: dto));

    send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        Utils.snackSuccess(context: context, message: 'Commande envoyée avec succès !');
        success = true;

        // 🧠 Sauvegarde locale
        try {
          final userController = Get.find<UserController>();
          userController.setAddressAndComment(
            adress: adresseController.text.trim(),
            comment: commentaireController.text.trim(),
            phone: getCompletePhoneNumber(),
          );
        } catch (e) {
          logger.w('UserController non trouvé: $e');
        }

        // 🔁 Redirection
        if (context.mounted) {
          context.pushNamed(
            AppRoutesNames.orderDetail,
            extra: adresseController.text.trim(),
          );
        }

        // 🧹 On vide le panier
        cartController.clearCart();
      },
    );

    commandsInLoading.value = false;
    return success;
  }

  @override
  void onClose() {
    adresseController.dispose();
    commentaireController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
