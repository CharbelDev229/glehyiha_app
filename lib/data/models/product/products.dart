import '../../../common/enums/product_category.dart';

class Product {
  final int id;
  final String name;
  final String image;
  final ProductCategory category;
  final double prix_unitaire;
  final String resume;
  final String quantite;
  final String seller;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.prix_unitaire,
    required this.resume,
    required this.quantite,
    required this.seller,
    required this.description,
  });

  // ✅ Conversion JSON → Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      category: ProductCategory.values.firstWhere(
        (e) => e.name.toLowerCase() == json['category'].toString().toLowerCase(),
        orElse: () => ProductCategory.ALL,
      ),
      prix_unitaire: json['prix_unitaire'] is double
          ? json['prix_unitaire']
          : double.tryParse(json['prix_unitaire'].toString()) ?? 0.0,
      resume: json['resume'] ?? '',
      quantite: json['quantite'] ?? '',
      seller: json['seller'] ?? '',
      description: json['description'] ?? '',
    );
  }

  // (facultatif) Pour envoyer au backend (Product → JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category.name,
      'prix_unitaire': prix_unitaire,
      'resume': resume,
      'quantite': quantite,
      'seller': seller,
      'description': description,
    };
  }
}
