import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import '../../../common/utils/text_field_validators.dart';
import '../custom_text_form_field/custom_text_form_field.dart';
import 'order_form_bottom_controller.dart'; // Remplace par le chemin correct de ton controller

class OrderFormContent extends StatefulWidget {
  final OrderFormContentController controller;
  const OrderFormContent({super.key, required this.controller});

  @override
  State<OrderFormContent> createState() => _OrderFormContentState();
}

class _OrderFormContentState extends State<OrderFormContent>
    with SingleTickerProviderStateMixin {
  late final OrderFormContentController controller;
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
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
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        SlideTransition(
          position: _animation,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height:
                  screenHeight *
                  0.75, // Augmenté de 0.55 à 0.75 pour plus d'espace
              width: 350,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Obx(
                () => Form(
                  key: controller.formKey,
                  autovalidateMode:
                      controller.autoValidate.value
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      // Header fixe (non scrollable)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 60,
                                height: 5,
                                margin: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const Text(
                              'Remplissez ces informations pour valider la commande',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),

                      // Contenu scrollable
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              const SizedBox(
                                height: 100,
                              ), // Espace pour éviter que le bouton cache le dernier champ
                            ],
                          ),
                        ),
                      ),

                      // Bouton fixe en bas
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : () {
                                      if (controller.formKey.currentState
                                              ?.validate() ??
                                          false) {
                                        controller.commande(context);
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
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
        ),
      ],
    );
  }
}
