class Commande {
  final int id;
  final String adresseLivraison;
  final String phoneNumber;
  final double montantTotal;
  final String statut;
  final List<CommandeDetail> details;

  Commande({
    required this.id,
    required this.adresseLivraison,
    required this.phoneNumber,
    required this.montantTotal,
    required this.statut,
    required this.details,
  });

  factory Commande.fromMap(Map<String, dynamic> map) {
    return Commande(
      id: map['id'],
      adresseLivraison: map['adresse_livraison'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      montantTotal: (map['montant_total'] ?? 0).toDouble(),
      statut: map['statut'] ?? '',
      details: List<CommandeDetail>.from(
        (map['details'] as List<dynamic>? ?? []).map(
          (item) => CommandeDetail.fromMap(item),
        ),
      ),
    );
  }
}

class CommandeDetail {
  final int id;
  final int commandeId;
  final double prixUnitaire;
  final int quantite;
  final double sousTotal;
  final Produit produit;

  CommandeDetail({
    required this.id,
    required this.commandeId,
    required this.prixUnitaire,
    required this.quantite,
    required this.sousTotal,
    required this.produit,
  });

  factory CommandeDetail.fromMap(Map<String, dynamic> map) {
    return CommandeDetail(
      id: map['id'],
      commandeId: map['commande_id'],
      prixUnitaire: (map['prix_unitaire'] ?? 0).toDouble(),
      quantite: map['quantite'],
      sousTotal: (map['sous_total'] ?? 0).toDouble(),
      produit: Produit.fromMap(map['produit']),
    );
  }
}

class Produit {
  final String category;
  final String description;
  final String marque;
  final String name;
  final String dateExpiration;

  Produit({
    required this.category,
    required this.description,
    required this.marque,
    required this.name,
    required this.dateExpiration,
  });

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      marque: map['marque'] ?? '',
      name: map['name'] ?? '',
      dateExpiration: map['date_expiration'] ?? '',
    );
  }
}
