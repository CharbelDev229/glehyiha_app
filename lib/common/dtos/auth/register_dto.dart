import '../../enums/user_role.dart';

class RegisterDto {
  final String firstname;
  final String lastname;
  final String? email;
  final String password;
  final String phoneNumber;
  final UserRole userRole;
  final String? shopName;
  final String? experience;
  final String? specialisation;

  RegisterDto({
    required this.firstname,
    required this.lastname,
    this.email,
    required this.password,
    required this.phoneNumber,
    required this.userRole,
    this.shopName,
    this.experience,
    this.specialisation
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'role': userRole.value,
      'specialization':specialisation,
      'experience':experience,
    };

    if (userRole == UserRole.vendeur && shopName != null) {
      map.addAll({'nom_boutique': shopName});
    }

    if (userRole == UserRole.encadreur && experience != null&&specialisation != null) {
      map.addAll({'experience': experience,'specialization': specialisation});
    }

    return map;
  }
}
