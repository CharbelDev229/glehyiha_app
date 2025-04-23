import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:glehiha/common/constants/instances.dart';

class ComplementVendeurController extends GetxController {

  final formKey = GlobalKey<FormState>();

 
  TextEditingController certificationController = TextEditingController();
  TextEditingController nomboutiqueController = TextEditingController();

  RxBool specialisation = false.obs;
   RxBool nomboutique = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    logger.w('\nSignupController onClose\n\n');
    super.onInit();
  }

  @override
  void onClose() {
    logger.w('\nSignupController onClose\n\n');
    super.onClose();
  }
}
