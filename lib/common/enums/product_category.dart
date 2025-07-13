enum ProductCategory {
  ALL, 
  PESTICIDES,
  ENGRAIS,
  SEMENCES,
  //EQUIPEMENTS,
  // ✅ Correction : nom en majuscules comme les autres
}

extension ProductCategoryExtension on ProductCategory {
  String get displayName {
    switch (this) {
      case ProductCategory.PESTICIDES:
        return "Pesticides";
      case ProductCategory.ENGRAIS:
        return "Engrais";
      case ProductCategory.SEMENCES:
        return "Semences";
    //  case ProductCategory.EQUIPEMENTS:
       // return "Équipements";
      case ProductCategory.ALL:
        return "Tous les produits"; // ✅ Correction de nom logique
    }
  }

  String get value {
    switch (this) {
      case ProductCategory.PESTICIDES:
        return 'pesticides';
      case ProductCategory.ENGRAIS:
        return 'fertilizers'; // ✅ logique de backend
      case ProductCategory.SEMENCES:
        return 'seeds';
      //case ProductCategory.EQUIPEMENTS:
     //   return 'equipments';
      case ProductCategory.ALL:
        return 'all'; // ✅ valeur backend correcte
    }
  }

  static ProductCategory fromString(String value) {
    switch (value) {
      case 'pesticides':
        return ProductCategory.PESTICIDES;
      case 'fertilizers':
        return ProductCategory.ENGRAIS;
      case 'seeds':
        return ProductCategory.SEMENCES;
      //case 'equipments':
       // return ProductCategory.EQUIPEMENTS;
      case 'all':
        return ProductCategory.ALL;
      default:
        throw Exception('Unknown ProductCategory: $value');
    }
  }
}
