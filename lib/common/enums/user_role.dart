enum UserRole { agriculteur, vendeur, encadreur}

extension UserRoleExtension on UserRole {


  String get value {
    switch (this) {
      case UserRole.agriculteur:
        return 'farmer';
      case UserRole.encadreur:
        return 'trainer';
      case UserRole.vendeur:
        return 'seller';
    }
  }

  static UserRole fromString(String role) {
    switch (role) {
      case 'farmer':
        return UserRole.agriculteur;
      case 'trainer':
        return UserRole.encadreur;
      case 'seller':
        return UserRole.vendeur;
      default:
        throw Exception('Unknown UserRole: $role');
    }
  }
}