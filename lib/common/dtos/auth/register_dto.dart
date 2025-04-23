
class RegisterDto {
  final String? firstname;
  final String? lastname;
  final String email;
  final String? birthDate;
  final String password;
  final String pseudo;
  final String? sex;
  final String? bonusCode;

  RegisterDto({
    this.firstname,
    this.lastname,
    required this.email,
    this.birthDate,
    required this.password,
    required this.pseudo,
    this.sex,
    this.bonusCode,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'email': email,
      'password': password,
      'pseudo': pseudo,
    };
    if (bonusCode != null && (bonusCode?.isNotEmpty ?? false)) {
      map['parent_code'] = bonusCode;
    }
    return map;
  }
}
