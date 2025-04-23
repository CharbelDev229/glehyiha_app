enum UserRole {
  agriculteur,
  encadreur,
  vendeur,
  expert,
  admin;

  String toJson() {
    return name.toLowerCase();
  }
}
