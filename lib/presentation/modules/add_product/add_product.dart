import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/enums/user_role.dart';
import '../../service/app/app_service.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
void initState() {
  
  final userRole = Get.find<AppService>();
  if (userRole != UserRole.vendeur) {
    Get.back(); // Empêche l’accès si ce n’est pas un vendeur
   // Get.snackbar("Accès refusé", "Seuls les vendeurs peuvent ajouter des produits");
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
