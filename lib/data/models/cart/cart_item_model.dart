import '../../../common/enums/product_category.dart';

class CartItemModel {
  final String id;
  final String name;
  final String image;
  final ProductCategory category;
  final String price;
  final String description;
  final int quantity; // <-- changer en int
  final String seller;

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.description,
    required this.quantity,
    required this.seller,
  });

  
  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      name: name,
      image: image,
      category: category,
      price: price,
      description: description,
      quantity: quantity ?? this.quantity,
      seller: seller,
    );
  }
}
