import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/market/market_controller.dart';
import 'package:glehiha/presentation/modules/market/product_list_item.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:go_router/go_router.dart';
import '../../../common/enums/user_role.dart';
import '../../router/routes.dart';
import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';
import '../../../common/enums/product_category.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketController controller = Get.put(MarketController());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const HeaderWidget(),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                color: AppColors.primaryGreen,
                child: const Text(
                  'Marketplace',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),

              // Barre de recherche et bouton "Ajouter un produit" côte à côte
              Row(
                children: [
                  // Barre de recherche
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: (value) => controller.updateSearch(value),
                      cursorColor: AppColors.black,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un produit...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  // Bouton "Ajouter un produit" uniquement pour les vendeurs
                  const SizedBox(width: 10),
                  Obx(() => Visibility(
                    visible: controller.selectedRole.value == UserRole.vendeur,
                    child: ElevatedButton(
                      onPressed: () {
                        // Utiliser GoRouter pour la navigation
                        context.pushNamed(AppRoutesNames.addProduct);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_a_photo_outlined, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Ajouter',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),

              const SizedBox(height: 20),

              // Boutons de catégorie avec GetX
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ProductCategory.values.map((category) {
                    final isSelected =
                        controller.selectedCategory.value == category;
                    return ElevatedButton(
                      onPressed: () => controller.changeCategory(category),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? AppColors.yellow : AppColors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: AppColors.grey),
                        ),
                      ),
                      child: Text(
                        category.displayName,
                        style: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Liste de produits reactive avec GetX
              Expanded(
                child: Obx(() {
                  final filteredProducts = controller.filteredProducts;

                  if (filteredProducts.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucun produit trouvé',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductListItem(
                        product: product,
                        onTap: () => controller.selectProduct(product),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}