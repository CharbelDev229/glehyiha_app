import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/utils/failure.dart';
import 'package:glehiha/common/utils/usecase.dart';

import '../../../common/dtos/commands/commands_dto.dart';
import '../../../common/dtos/commands/commands_items_dto.dart';
import '../../../common/enums/commande_statut.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../../data/models/product/products.dart';
import '../../../domain/usescases/commands/commands_use_case.dart';
import '../../../domain/usescases/commands/delete_commads_use_case.dart';
import '../../../domain/usescases/commands/get_all_commande_use_case.dart';
import '../../../domain/usescases/commands/get_commands_by_id_use_case.dart';
import '../../../domain/usescases/commands/update_commande_use_case.dart';

class Cart1Controller extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxList<CommandsDto> allCommandes = <CommandsDto>[].obs;
  final RxBool isLoadingCommandes = false.obs;
  final statut = CommandeStatut.enAttente.obs;

  final CommandsUseCase sendCommandUseCase = Get.find();
  final UpdateCommandeUseCase updateCommandUseCase = Get.find();
  final DeleteCommandeUseCase deleteCommandUseCase = Get.find();
  final GetCommandeByIdUseCase getCommandUseCase = Get.find();
  final GetAllCommandesUseCase getAllCommandesUseCase = Get.find();

  final Rxn<CartItemModel> selectedCartItem = Rxn<CartItemModel>();

  void setSelectedCartItem(CartItemModel item) {
    selectedCartItem.value = item;
  }

  void init() {
    getAllCommandes();
  }

  int get cartCount => cartItems.fold(0, (sum, item) => sum + item.quantite);

  double get totalPrice => cartItems.fold(
    0.0,
    (sum, item) => sum + item.prix_unitaire * item.quantite,
  );

  double get totalCommandesPrice {
    return allCommandes.fold(0.0, (total, commande) {
      return total + commande.details.fold(
        0.0,
        (subtotal, item) => subtotal + (item.prix_unitaire * item.quantite),
      );
    });
  }

  Future<void> addToCart(Product product, {int quantity = 1}) async {
    if (product.id == 0 || product.name.isEmpty || product.prix_unitaire == 0.0) {
      print('❌ Produit invalide, ajout refusé');
      return;
    }

    final index = cartItems.indexWhere((item) => item.product_id == product.id);

    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(
        quantite: cartItems[index].quantite + quantity,
      );
    } else {
      cartItems.add(
        CartItemModel(
          product_id: product.id,
          name: product.name,
          image: product.image,
          category: product.category,
          prix_unitaire: product.prix_unitaire,
          resume: product.resume,
          quantite: quantity,
          seller: product.seller,
        ),
      );
    }

    print('🛒 Produit ajouté: ${product.name}');
  }

  void removeFromCart(CartItemModel item) {
    cartItems.removeWhere((cartItem) => cartItem.product_id == item.product_id);
  }

  void incrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((i) => i.product_id == item.product_id);
    if (index >= 0) {
      cartItems[index] = cartItems[index].copyWith(
        quantite: cartItems[index].quantite + 1,
      );
    }
  }

  void decrementQuantity(CartItemModel item) {
    final index = cartItems.indexWhere((i) => i.product_id == item.product_id);
    if (index >= 0) {
      if (cartItems[index].quantite > 1) {
        cartItems[index] = cartItems[index].copyWith(
          quantite: cartItems[index].quantite - 1,
        );
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  Future<Either<Failure, String>> sendCommand(
    String adresse,
    String commentaire,
    String phone,
  ) async {
    final dto = CommandsDto(
      adresse_livraison: adresse,
      commentaire: commentaire,
      phone_number: phone,
      statut: statut.value,
      details: cartItems.map((e) {
        return CommandItemDto(
          produit_id: e.product_id,
          quantite: e.quantite,
          prix_unitaire: e.prix_unitaire,
        );
      }).toList(),
    );

    print("📦 Données de commande envoyée : ${dto.toMap()}");

    final send = await sendCommandUseCase.call(CommandsParams(dto: dto));

    send.fold(
      (failure) {
        print('❌ Erreur lors de l\'envoi: ${failure.message}');
        Get.snackbar('Erreur', 'Échec de la commande: ${failure.message}');
      },
      (success) {
        print('✅ Commande envoyée avec succès: $success');
        clearCart();
        getAllCommandes();
        Get.snackbar('Succès', 'Commande enregistrée !');
      },
    );

    return send;
  }

  Future<void> getAllCommandes() async {
    try {
      isLoadingCommandes.value = true;
      final send = await getAllCommandesUseCase.call();

      send.fold(
        (failure) {
          print('❌ Erreur récupération commandes: ${failure.message}');
        },
        (commandes) {
          print('✅ ${commandes.length} commandes récupérées');
          allCommandes.assignAll(commandes);
        },
      );
    } catch (e) {
      print('❌ Exception: $e');
    } finally {
      isLoadingCommandes.value = false;
    }
  }
}
