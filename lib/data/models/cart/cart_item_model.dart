import '../../../common/enums/product_category.dart';

class CartItemModel {
  final int productId;
  final String name;
  final String image;
  final ProductCategory category;
  final double price;
  final String resume;
  final int quantity;
  final String seller;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.resume,
    required this.quantity,
    required this.seller,
  });

  /// Permet de copier en modifiant certaines valeurs (ex: la quantité)
  CartItemModel copyWith({
    int? productId,
    String? name,
    String? image,
    ProductCategory? category,
    double? price,
    String? resume,
    int? quantity,
    String? seller,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      price: price ?? this.price,
      resume: resume ?? this.resume,
      quantity: quantity ?? this.quantity,
      seller: seller ?? this.seller,
    );
  }

  /// Convertir en map pour l’envoyer à l’API
  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'name': name,
      'image': image,
      'category': category.name, // enum → string
      'price': price,
      'resume': resume,
      'quantity': quantity,
      'seller': seller,
    };
  }

  /// Créer à partir d’une map reçue depuis l’API
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: _parseInt(map['product_id']),
      name: map['name']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      category: _parseCategory(map['category']),
      price: _parseDouble(map['price']),
      resume: map['resume']?.toString() ?? '',
      quantity: _parseInt(map['quantity']),
      seller: map['seller']?.toString() ?? '',
    );
  }

  /// Helpers internes pour convertir dynamiquement
  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static ProductCategory _parseCategory(dynamic value) {
    if (value == null) return ProductCategory.ENGRAIS;
    try {
      return ProductCategory.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toString().toLowerCase(),
        orElse: () => ProductCategory.ENGRAIS,
      );
    } catch (_) {
      return ProductCategory.ENGRAIS;
    }
  }
}
