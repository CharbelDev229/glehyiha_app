import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/constants/instances.dart';


class ComplemenEncadreurController extends GetxController {
  final formKey = GlobalKey<FormState>();


  TextEditingController specialisationController = TextEditingController();
  TextEditingController certificationController = TextEditingController();
 
  RxBool specialisation = false.obs;
  RxBool certification = false.obs;
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
