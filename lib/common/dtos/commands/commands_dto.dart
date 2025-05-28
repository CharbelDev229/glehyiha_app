import '../../enums/user_role.dart';

class CommandsDto {
   final String adresse_livraison;
  final String commentaire;
  final String  phone_number;
 
  CommandsDto({
    required this.adresse_livraison,
    required this.commentaire,
    required this.phone_number,
   
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'adresse_livraison': adresse_livraison,
      'commentaire': commentaire,
      'phone_number': phone_number,
      
    };

    

    return map;
  }
}
