import '../../../common/enums/product_category.dart';

class ProductModel {
  final String id;
  final String name;
  final String image;
  final ProductCategory category;
  final String price;
  final String description;
  final String quantity;
  final String seller;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
     required this.description,
    required this .quantity,
    required this.seller,
  });

  
   }