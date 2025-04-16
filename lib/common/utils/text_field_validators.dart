import 'package:glehiha/presentation/router/routes.dart';

class TextFieldValidators {
  // Validation for a required field
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis';
    }
    return null;
  }
   // Validation for a required field
  static String? validConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis';
    }
    return null;
  }
  static String? validCheckbox(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis';
    }
    return null;
  }

  // Validation for a valid email
  static String? validEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis';
    }
    // Regular expression to validate an email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  // Validation for a strong password
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis';
    }
    // Check if the password contains at least 5 letters and 1 digit
    String pattern = r'^(?=(.*[A-Za-z]){5,})(?=.*\d).*$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Ce champs est requis';
    }
    return null;
  }

  // Validation for password confirmation
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis';
    }
    if (value != originalPassword) {
      return 'Le mots de passe ne correspondent pas .';
    }
    return null;
  }

  // Validation for a referral code
  static String? validReferralCode(String? value) {
    // Check if the field is empty
    if (value == null || value.isEmpty) {
      return '\n\nCe champ est requis.';
    }
    // Check if the referral code length is exactly 6 characters
    if (value.length != 6) {
      return '\n\nLe code doit contenir exactement 6 caracteres.';
    }
    return null;
  }

  // Validation for a forget password verification code
  static String? validVerificationCode(String? value) {
    // Check if the field is empty
    if (value == null || value.isEmpty) {
      return '\n\nCe champs est requis.';
    }
    // Check if the referral code length is exactly 6 characters
    if (value.length != 6) {
      return '\n\nLe code de vérification doit contenir 6 chiffres.';
    }
    return null;
  }
}
