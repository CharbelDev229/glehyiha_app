enum CommandeStatut {
  enAttente,
  confirme,
  liree,
  annulee,
  enlivraison,
}

extension CommandeStatutExtension on CommandeStatut {
  String get name {
    switch (this) {
      case CommandeStatut.enAttente:
        return 'on_hold';
      case CommandeStatut.confirme:
        return 'confirmed';
         case CommandeStatut.enlivraison:
        return 'delivered';
      case CommandeStatut.liree:
        return 'oer';
      case CommandeStatut.annulee:
        return 'cancelled';
    }
  }

  static CommandeStatut fromString(String value) {
    switch (value) {
      case 'on_hold':
        return CommandeStatut.enAttente;
      case 'confirmed':
        return CommandeStatut.confirme;
        case 'delivered':
        return CommandeStatut.enlivraison;
      case 'oer':
        return CommandeStatut.liree;
      case 'cancelled':
        return CommandeStatut.annulee;
      default:
        return CommandeStatut.enAttente;
    }
  }
}
