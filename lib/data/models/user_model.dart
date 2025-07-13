class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '', // ✅ récupère l'ID de la map
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
    );
  }

  // ✅ Constructeur vide pour éviter les erreurs de valeur nulle
  factory UserModel.empty() {
    return UserModel(
      id: '',
      email: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
    );
  }
}
