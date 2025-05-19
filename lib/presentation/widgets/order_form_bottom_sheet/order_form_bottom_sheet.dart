import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:go_router/go_router.dart';
import '../../../common/utils/text_field_validators.dart';
import '../../router/routes.dart';
import '../custom_text_form_field/custom_text_form_field.dart';
import 'order_form_buttom_sheet_controller.dart';

class OrderFormContent extends StatefulWidget {
  const OrderFormContent({super.key});

  @override
  State<OrderFormContent> createState() => _OrderFormContentState();
}

class _OrderFormContentState extends State<OrderFormContent>
    with SingleTickerProviderStateMixin {
  final controller = OrderFormButtomSheetController();

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width:
              MediaQuery.of(context).size.width *
              0.9, // Moins que toute la largeur
          height: MediaQuery.of(context).size.height * 0.6,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Obx(
            () => Form(
              key: controller.formKey,
              autovalidateMode:
                  controller.autoValidate.value
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      child: SizedBox(
                        width: 90,
                        child: Divider(thickness: 2, color: AppColors.black),
                      ),
                    ),
                  ),
                  Text(
                    'Remplissez ces informations pour valider la commande',
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
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    controller: controller.numController,
                    validator: TextFieldValidators.required,
                    labelText: "Nom",
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: controller.commentaireController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Commentaire',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un commentaire';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed(AppRoutesNames.orderDetail);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Continuer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
