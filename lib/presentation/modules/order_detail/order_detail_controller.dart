import 'package:get/get.dart';
import 'package:glehiha/common/dtos/commands/commande_detail_dto.dart';
import '../../../common/dtos/commands/commande_dto.dart';
import '../../../domain/usescases/commands/get_all_commande_use_case.dart';

class CartItem {
  final String name;
  final String resume;
  final String image;
  final int quantity;
  final double price;

  CartItem({
    required this.name,
    required this.resume,
    required this.image,
    required this.quantity,
    required this.price,
  });
}

class OrderDetailController extends GetxController {
  // -------------------- 🛒 PANIER --------------------
  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxDouble totalPrice = 0.0.obs;

  void calculateTotal() {
    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }

  void addItem(CartItem item) {
    cartItems.add(item);
    calculateTotal();
  }

  void clearCart() {
    cartItems.clear();
    calculateTotal();
  }

  // -------------------- 📦 COMMANDES ENREGISTRÉES --------------------
  final RxList<Commande> allCommandes = <Commande>[].obs;
  final RxBool isLoadingCommandes = false.obs;

  final GetAllCommandesUseCase getAllCommandesUseCase = Get.find();

  Future<void> getAllCommandes() async {
    try {
      isLoadingCommandes.value = true;

      final result = await getAllCommandesUseCase.call();

      result.fold(
        (failure) {
          print('❌ Erreur récupération commandes : ${failure.message}');
        },
        (commandes) {
          allCommandes.assignAll(commandes as Iterable<Commande>); // ✅ Correction ici
          print('✅ ${commandes.length} commandes récupérées');
        },
      );
    } catch (e) {
      print('❌ Exception : $e');
    } finally {
      isLoadingCommandes.value = false;
    }
  }

  // 🔢 Total général de toutes les commandes enregistrées
  double get totalCommandesPrice {
    return allCommandes.fold(
      0.0,
      (sum, commande) => sum + (commande.montantTotal ?? 0),
      
    );
  }
}
