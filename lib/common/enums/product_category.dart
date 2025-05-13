enum ProductCategory {
   all,
  pesticide,
  engrais,
}

// Extension pour faciliter l'affichage du nom des catégories
extension ProductCategoryExtension on ProductCategory {
  String get displayName {
    switch (this) {
      case ProductCategory.all:
        return 'Tous les produits';
      case ProductCategory.pesticide:
        return 'Pesticides';
      case ProductCategory.engrais:
        return 'Engrais';
      
    }
  }
}