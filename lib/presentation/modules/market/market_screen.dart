import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:glehiha/common/constants/colors.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'Tous';
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> allProducts = [
    {
      'name': 'Tomate',
      'image': 'assets/images/tomate.png',
      'category': 'Tous'
    },
    {
      'name': 'Engrais Bio',
      'image': 'assets/images/engrais.png',
      'category': 'Engrais'
    },
    {
      'name': 'Pesticide X',
      'image': 'assets/images/pesticide.png',
      'category': 'Pesticides'
    },
    {
      'name': 'Oignon',
      'image': 'assets/images/oignon.png',
      'category': 'Tous'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = allProducts
        .where((product) =>
            (_selectedCategory == 'Tous' ||
                product['category'] == _selectedCategory) &&
            product['name']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            HeaderWidget(),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color:  AppColors.primaryGreen,
              child: Text(
                'Marketplace',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),

            // Barre de recherche
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              cursorColor: AppColors.black,
              decoration: InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: Icon(Icons.search),
                  filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.black),
                ),
               enabledBorder: OutlineInputBorder( 
               borderRadius: BorderRadius.circular(12),
               borderSide: BorderSide(color: AppColors.black),),
               focusedBorder: OutlineInputBorder( 
               borderRadius: BorderRadius.circular(12),
               borderSide: BorderSide(color: AppColors.black, width: 1), ),),
             
               style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400, ), ),
            
            SizedBox(height: 10),

            // Boutons de catégorie
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Tous', 'Engrais', 'Pesticides'].map((category) {
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 20,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.yellow
                          : AppColors.grey,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // Liste de produits
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (_, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      // Tu peux afficher un snackbar ou ouvrir une fiche produit ici
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product['name']} sélectionné')),
                      );
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              product['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              product['name']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(), );
    
  }
}
