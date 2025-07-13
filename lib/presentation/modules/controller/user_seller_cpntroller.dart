import 'package:get/get.dart';
import '../../../common/enums/user_role.dart';

class UserSellerController extends GetxController {
  final Rx<UserRole> role = UserRole.vendeur.obs;

  UserRole getRole() {
    return role.value;
  }

  void setRole(UserRole newRole) {
    role.value = newRole;
  }

  String? getUserId() {
    return "current_seller_id"; // à remplacer plus tard par la vraie valeur
  }
}
