import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/widgets/order_form_bottom_sheet/order_form_buttom_sheet_controller.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils/text_field_validators.dart';
import '../../router/routes.dart';
import '../button/custom_button.dart';
import '../custom_text_form_field/custom_text_form_field.dart';

class OrderFormBottomSheet extends StatefulWidget {
  const OrderFormBottomSheet({super.key});

  @override
  State<OrderFormBottomSheet> createState() => _OrderFormBottomSheetState();
}

class _OrderFormBottomSheetState extends State<OrderFormBottomSheet> {
  final controller = OrderFormButtomSheetController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Form(
              key: controller.formKey,
              autovalidateMode:
                  controller.autoValidate.value
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Barre de glissement au-dessus
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const Text(
                    'Remplisser ces information pour valider la commande',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  CustomTextFormField(
                    controller: controller.adresseController,
                    validator: TextFieldValidators.required,
                    labelText: "Adresse de livraison",
                    //  suffixIcon: const Icon(Icons.person, color: AppColors.black),
                  ),

                  const SizedBox(height: 15),

                  CustomTextFormField(
                    controller: controller.numController,
                    validator: TextFieldValidators.required,
                    labelText: "Nom",
                    //  suffixIcon: const Icon(Icons.person, color: AppColors.black),
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: controller.commentaireController,
                    maxLines: 5, // ou plus si besoin
                    decoration: const InputDecoration(
                      labelText: 'Commentaire',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true, // pour centrer le label en haut
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une commentaire';
                      }
                      return null;
                    },
                  ),

                  const Spacer(),

                  CustomButton(
                    onPressed: () {
                      context.pushNamed(AppRoutesNames.orderDetail);
                    },
                    child: const SizedBox(
                      child: Center(child: Text('Continuer')),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
