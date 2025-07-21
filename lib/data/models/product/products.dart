import '../../../common/enums/product_category.dart';

class Product {
  final int id;
  final String name;
  final String image; // URL de l'image principale
  final ProductCategory category;
  final double prix_unitaire;
  final String resume;
  final String quantite;
  final String seller;
  final String description;
  final String? marque;
  final int? stock;
  final String? unite;
  final List<ProductImage>? images; // Liste des images

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
    this.marque,
    this.stock,
    this.unite,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Récupérer la première image ou une image par défaut
    String imageUrl = 'assets/images/placeholder.png';
    List<ProductImage> productImages = [];
    
    if (json['images'] != null && json['images'] is List) {
      productImages = (json['images'] as List)
          .map((img) => ProductImage.fromJson(img))
          .toList();
      
      if (productImages.isNotEmpty) {
        imageUrl = productImages.first.imgUrl;
      }
    }

    return Product(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      image: imageUrl,
      category: _getCategoryFromString(json['category']),
      prix_unitaire: json['price'] is double
          ? json['price']
          : double.tryParse(json['price'].toString()) ?? 0.0,
      resume: json['description'] ?? '', // API utilise 'description' comme résumé
      quantite: '${json['stock'] ?? 0} ${json['unite'] ?? 'unité'}',
      seller: json['user_id']?.toString() ?? '',
      description: json['description'] ?? '',
      marque: json['marque'],
      stock: json['stock'],
      unite: json['unite'],
      images: productImages,
    );
  }

  static ProductCategory _getCategoryFromString(String? category) {
    switch (category?.toLowerCase()) {
      case 'fertilizers':
        return ProductCategory.ENGRAIS;
      case 'pesticides':
        return ProductCategory.PESTICIDES;
      case 'seeds':
        return ProductCategory.SEMENCES;
      default:
        return ProductCategory.ALL;
    }
  }
}

class ProductImage {
  final int id;
  final String imgName;
  final String imgUrl;
  final int produitId;

  ProductImage({
    required this.id,
    required this.imgName,
    required this.imgUrl,
    required this.produitId,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] ?? 0,
      imgName: json['img_name'] ?? '',
      imgUrl: json['img_url'] ?? '',
      produitId: json['produit_id'] ?? 0,
    );
  }
}
