import 'package:glehiha/common/enums/commande_statut.dart';

import 'commands_items_dto.dart'; // importer l'enum

class CommandsDto {
  final String adresse_livraison;
  final String commentaire;
  final String phone_number;
  final List<CommandItemDto> details;
  final CommandeStatut statut; // ✅ enum au lieu de String

  CommandsDto({
    required this.adresse_livraison,
    required this.commentaire,
    required this.phone_number,
    required this.details,
    this.statut = CommandeStatut.enAttente, // valeur par défaut
  });

  Map<String, dynamic> toMap() {
    return {
      'adresse_livraison': adresse_livraison,
      'commentaire': commentaire,
      'phone_number': phone_number,
      'statut': statut.name, // ✅ converti en string pour l’API
      'details': details.map((item) => item.toMap()).toList(),
    };
  }

  factory CommandsDto.fromMap(Map<String, dynamic> map) {
    return CommandsDto(
      adresse_livraison: map['adresse_livraison'] ?? '',
      commentaire: map['commentaire'] ?? '',
      phone_number: map['phone_number'] ?? '',
      statut: CommandeStatutExtension.fromString(map['statut'] ?? 'en_attente'),
      details: (map['details'] as List)
          .map((e) => CommandItemDto.fromMap(e))
          .toList(),
    );
  }
}
