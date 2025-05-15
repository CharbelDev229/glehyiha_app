import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/product_category.dart';




class OrderFormButtomSheetController {
  
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );
  RxInt index = 1.obs;
  // final SignUpUseCase signUpUseCase;
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'order_form_buttom_sheet',
  );

  // Contrôleurs de formulaire
  TextEditingController adresseController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();
  TextEditingController numController = TextEditingController();
  
 

  // Variables observables
final Rx<ProductCategory> selectedProduct = ProductCategory.engrais.obs;
 
  RxBool isLoading = false.obs;
  RxBool autoValidate = false.obs;
  
  
  
 
  }

