import '../../../common/enums/product_category.dart';

class Product {
  final int id;
  final String name;
  final String image;
  final ProductCategory category;
  final double price; // prix_unitaire en double
  final String summary; // resume renommé en summary pour clarté
  final String quantity;
  final String seller;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.summary,
    required this.quantity,
    required this.seller,
    required this.description,
  });

  // Conversion JSON → Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      category: ProductCategory.values.firstWhere(
        (e) => e.name.toLowerCase() == json['category'].toString().toLowerCase(),
        orElse: () => ProductCategory.ALL,
      ),
      price: json['price'] is double
          ? json['price']
          : double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      summary: json['summary'] ?? json['resume'] ?? '',
      quantity: json['quantity'] ?? json['quantite'] ?? '',
      seller: json['seller'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // Conversion Product → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category.name,
      'price': price,
      'summary': summary,
      'quantity': quantity,
      'seller': seller,
      'description': description,
    };
  }
}
