import '../../../common/enums/product_category.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final ProductCategory category;
  final String price;
  final String resume;
  final String quantity;
  final String seller;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.resume,
    required this .description,
    required this.quantity,
    required this.seller,
  });

  // Factory constructor pour créer un Product à partir d'un Map (utile pour JSON)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? ProductCategory.all,
      price: map['price'] ?? '0',
      resume: map['description'] ?? '',
      description: map['description1']?? '',
      seller: map['seller']?? '',
      quantity: map['quantity']?? '',
    );
  }

  // Méthode pour convertir le Product en Map (utile pour JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category,
      'price': price,
      'reume': resume,
      'quantity': quantity,
      'seller': seller,
      'description1':description,
    };
  }
}
