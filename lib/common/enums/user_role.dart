enum UserRole { agriculteur, encadreur, vendeur }

extension UserRoleExtension on UserRole {


  String get value {
    switch (this) {
      case UserRole.agriculteur:
        return 'agriculteur';
      case UserRole.encadreur:
        return 'encadreur';
      case UserRole.vendeur:
        return 'vendeur';
    }
  }

  static UserRole fromString(String role) {
    switch (role) {
      case 'agriculteur':
        return UserRole.agriculteur;
      case 'encadreur':
        return UserRole.encadreur;
      case 'vendeur':
        return UserRole.vendeur;
      default:
        throw Exception('Unknown UserRole: $role');
    }
  }
}