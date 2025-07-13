import 'package:get/get.dart';
import '../../../common/enums/user_role.dart';
import '../../service/product/product_service.dart';

class UserSellerController extends GetxController {
  // Rôle de l'utilisateur (vendeur par défaut)
  final Rx<UserRole> role = UserRole.vendeur.obs;

  // Récupère le rôle actuel
  UserRole getRole() {
    return role.value;
  }

  // Simule la récupération de l'ID de l'utilisateur connecté
  String? getUserId() {
    // Remplace cette valeur si tu as un système d'authentification réel
    return "current_seller_id";
  }

  // Initialisation du vendeur : charge ses produits
  Future<void> initVendeur() async {
    try {
      final productService = Get.find<ProductService>();
      final sellerId = getUserId();

      if (sellerId != null) {
        productService.setUserRole(UserRole.vendeur); // Définit le rôle
        await productService.loadProductsBySeller(sellerId); // Charge les produits du vendeur
      } else {
        print("❌ Aucun ID vendeur trouvé");
      }
    } catch (e) {
      print("❌ Erreur lors de l'init du vendeur : $e");
    }
  }

  // Permet de changer le rôle
  void setRole(UserRole newRole) {
    role.value = newRole;
  }
}
