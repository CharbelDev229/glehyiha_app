class CommandItemDto {
  final int produit_id;
  final int quantite;
  final double prix_unitaire;

  CommandItemDto({
    required this.produit_id,
    required this.quantite,
    required this.prix_unitaire,
  });

  Map<String, dynamic> toMap() {
    return {
      'produit_id': produit_id, // ✔️ conforme Swagger
      'quantite': quantite,
      'prix_unitaire': prix_unitaire,
    };
  }

  factory CommandItemDto.fromMap(Map<String, dynamic> map) {
    return CommandItemDto(
      produit_id: map['produit_id'] ?? 0,
      quantite: _parseInt(map['quantite']),
      prix_unitaire: _parseDouble(map['prix_unitaire']),
    );
  }

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
}
