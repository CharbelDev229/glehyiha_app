class CommandeDetailDto {
  final int produitId;
  final int quantite;
  final int prixUnitaire;

  CommandeDetailDto({
    required this.produitId,
    required this.quantite,
    required this.prixUnitaire,
  });

  Map<String, dynamic> toMap() {
    return {
      "produit_id": produitId,
      "quantite": quantite,
      "prix_unitaire": prixUnitaire,
    };
  }
}
