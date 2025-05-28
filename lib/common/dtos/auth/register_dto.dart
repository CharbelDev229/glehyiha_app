import '../../enums/user_role.dart';

class RegisterDto {
  final String first_name;
  final String last_name;
  final String? email;
  final String password;
  final String phone_number;
  final UserRole userRole;
  final String? nom_boutique;
  final String? experience;
  final String? specialization;

  RegisterDto({
    required this.first_name,
    required this.last_name,
    this.email,
    required this.password,
    required this.phone_number,
    required this.userRole,
    this.nom_boutique,
    this.experience,
    this.specialization
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'firstname': first_name,
      'lastname': last_name,
      'email': email,
      'password': password,
      'phone_number': phone_number,
      'role': userRole.value,
      'specialization':specialization,
      'experience':experience,
    };

    if (userRole == UserRole.vendeur && nom_boutique != null) {
      map.addAll({'nom_boutique': nom_boutique});
    }

    if (userRole == UserRole.encadreur && experience != null&&specialization != null) {
      map.addAll({'experience': experience,'specialization': specialization});
    }

    return map;
  }
}
