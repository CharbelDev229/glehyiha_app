import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';


class TextFieldValidators {
  // Validation for a required field
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis';
    }
    return null;
  }
 static String? requiredForRule(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champs est requis pour le role que vous avez choisi';
    }String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }
  static String? validSexe(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez sélectionner votre sexe';
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



    
    if (value == null || value.trim().isEmpty) {
      // Champ vide accepté
      return null;
    }

    // Expression régulière pour valider un email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return 'Veuillez entrer un email valide';
    }

    return null; // Email valide
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }

    if (value.length < 6) {
      return 'Le code doit contenir au moin 5 caractères';
    }

    return null;
  }
  static String? code(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est requis';
    }

    if (value.length < 6) {
      return 'Le code doit contenir au moin 6 chiffres';
    }

    return null;
  }

  static String? validatePhoneNumber({
    String? value,
    required BuildContext context,
  }) {
    if (value == null || value.isEmpty) {
      return 'Ce chmaps est requis ';
    }
    // // Regular expression to validate a phone number (e.g., +1234567890 or 123-456-7890)
    // String pattern = r'^(?:\+?\d{1,3}[-.\s]?)?(?:\(?\d{1,4}\)?[-.\s]?)?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$';
    // RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(value)) {
    //   return AppLocalizations.of(context)!.please_enter_a_valid_phone_number;
    // }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Veuillez entrer un numéro de téléphone valide';
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
