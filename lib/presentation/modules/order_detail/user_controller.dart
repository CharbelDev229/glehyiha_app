import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class UserController extends GetxController {
  // Champs utilisateur
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString adress = ''.obs;
  RxString comment = ''.obs;

  // Méthode pour enregistrer les infos
  void setUser({
    required String fName,
    required String lName,
    required String mail,
  }) {
    firstName.value = fName;
    lastName.value = lName;
    email.value = mail;
  }

  void setAddressAndComment({
    required String adress,
    required String comment,
    required String phone,
  }) {
    this.adress.value = adress;
    this.comment.value = comment;
    this.phone.value = phone;
  }
void setUserData(UserModel user) {
    email.value = user.email;
    firstName.value = user.firstName;
    lastName.value = user.lastName;
    
  }


  
}
