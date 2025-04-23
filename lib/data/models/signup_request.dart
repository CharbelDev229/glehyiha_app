class SignupRequest {
  final String? email;
  final String firstName;
  final String lastName;
  final String? latitude;
  final String? longitude;
  final String password;
  final String? phoneNumber;
  final String role;
  final String sexe;
  final String address;

  SignupRequest({
    this.email,
    required this.firstName,
    required this.lastName,
    this.latitude,
    this.longitude,
    required this.password,
    this.phoneNumber,
    required this.role,
    required this.sexe,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'latitude': latitude,
      'longitude': longitude,
      'password': password,
      'phone_number': phoneNumber,
      'role': role,
      'sexe': sexe,
      'address': address,
    };
  }
}
