import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/dtos/commands/commands_dto.dart';
import 'package:glehiha/common/enums/product_category.dart';
import 'package:glehiha/common/utils/utils.dart';
import 'package:glehiha/domain/usescases/commands/commands_use_case.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/instances.dart';
import '../../modules/order_detail/user_controller.dart';


class OrderFormContentController {
   final CommandsUseCase commandsUseCase;
   
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'order_form_buttom_sheet',
  );
  // Contrôleurs de formulaire
  TextEditingController adresseController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();
  TextEditingController numController = TextEditingController();

  GlobalKey<FormState> numadresseFormKey = GlobalKey<FormState>(
    debugLabel: 'num_adresse',
  );
  GlobalKey<FormState> commentaireFormKey = GlobalKey<FormState>(
    debugLabel: 'commentaire',
  );
  
  // Variables observables
final Rx<ProductCategory> selectedProduct = ProductCategory.engrais.obs;
  RxBool isLoading = false.obs;
  RxBool autoValidate = false.obs;
  RxInt index = 1.obs;
 RxString selectedCountryCode = '+229'.obs;
   RxBool commandsInLoading = false.obs;

  OrderFormContentController({required this.commandsUseCase});


  String getCompletePhoneNumber() {
    return selectedCountryCode.value + numController.text.trim();
  }

  
  Future<bool> commande(BuildContext context) async {
    bool success = false;
    commandsInLoading.value = true;

    final send = await commandsUseCase.call(
      CommandsParams(
        dto: CommandsDto(
        adresse_livraison: adresseController.text, 
        commentaire: commentaireController.text, 
        phone_number: getCompletePhoneNumber(),)));
  
  
   send.fold(
      (failure) {
        Utils.snackError(context: context, message: failure.message);
      },
      (response) async {
        Utils.snackSuccess(context: context, message: 'Inscription réussie!');
        success = true;

         try {
          final userController = Get.find<UserController>();
          userController.setAddressAndComment(
            adress: adresseController.text.trim(),
            comment: commentaireController.text.trim(),
            phone: getCompletePhoneNumber(),
            
           );
         } catch (e) {
           logger.w('UserController non trouvé: $e');
         }

     if (context.mounted) {
          context.pushNamed(
            AppRoutesNames.orderDetail,
            extra: adresseController.text.trim(),
          );
        }
      },
    );
    commandsInLoading.value = false;
    return success;
  }

 
  }

