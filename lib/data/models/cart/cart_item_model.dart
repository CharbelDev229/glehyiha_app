import '../../../common/enums/product_category.dart';

class CartItemModel {
  final int product_id;
  final String name;
  final String image;
  final ProductCategory category;
  final double prix_unitaire;
  final String resume;
  final int quantite;
  final String seller;

  CartItemModel({
    required this.product_id,
    required this.name,
    required this.image,
    required this.category,
    required this.prix_unitaire,
    required this.resume,
    required this.quantite,
    required this.seller,
  });

  CartItemModel copyWith({
    int? product_id,
    String? name,
    String? image,
    ProductCategory? category,
    double? prix_unitaire,
    String? resume,
    int? quantite,
    String? seller,
  }) {
    return CartItemModel(
      product_id: product_id ?? this.product_id,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      prix_unitaire: prix_unitaire ?? this.prix_unitaire,
      resume: resume ?? this.resume,
      quantite: quantite ?? this.quantite,
      seller: seller ?? this.seller,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': product_id,
      'name': name,
      'image': image,
      'category': category.name,
      'prix_unitaire': prix_unitaire,
      'resume': resume,
      'quantite': quantite,
      'seller': seller,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      product_id: map['product_id'] is int ? map['product_id'] : int.tryParse(map['product_id'].toString()) ?? 0,
      name: map['name']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      category: ProductCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ProductCategory.ENGRAIS,
      ),
      prix_unitaire: map['prix_unitaire'] is double
          ? map['prix_unitaire']
          : double.tryParse(map['prix_unitaire'].toString()) ?? 0.0,
      resume: map['resume']?.toString() ?? '',
      quantite: _parseInt(map['quantite']),
      seller: map['seller']?.toString() ?? '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
