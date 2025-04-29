import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/modules/auth/verification_code/verification_code_controller.dart';

import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/background_decoration/background_deco.dart';


import 'package:go_router/go_router.dart';


import '../../../../common/utils/utils.dart';
import '../../../widgets/button/custom_button.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.controller});
  final VerificationCodeController controller;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late VerificationCodeController controller;
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];

  bool _autoValidate = false;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();


    _controllers = List.generate(6, (_) => TextEditingController());
  _focusNodes = List.generate(6, (_) => FocusNode());
  }

  void _onSubmit() {
    final isFormValid = controller.formKey.currentState!.validate();

    if (isFormValid) {
      context.pushNamed(
        AppRoutesNames.parameters,
      ); // ou context.pushNamed(...) si tu utilises go_router
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackgroundDeco(
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(height: Utils.deviceH(context) * 0.33),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 30.0,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Form(
                          key: controller.formKey,
                          autovalidateMode:
                              _autoValidate
                                  ? AutovalidateMode.always
                                  : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 90,
                                child: Divider(
                                  thickness: 2,
                                  color: AppColors.black,
                                ),
                              ),
                              const SizedBox(height: 25),
                                const Text(
                                "Code otp",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 32,
                               fontWeight: FontWeight.w600,
                                ),
                              ),
                             
                              const Text(
                                "Un code à 6 chiffres vous a été envoyé pour la vérification",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                             SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(6, (index) {
                                   return SizedBox(
                                   width: 50,
                                   height: 60,
                                   child: TextFormField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    fontWeight: FontWeight.bold,),
                                     decoration: InputDecoration(
                                       counterText: "",
                                       enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),),
                                       focusedBorder: OutlineInputBorder(
                                       borderSide: const BorderSide(color: Colors.green, width: 2),
                                       borderRadius: BorderRadius.circular(10),),),
                                        onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                           } else if (value.isEmpty && index > 0) {
                                           FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                             }},),);})),
                                      const SizedBox(height: 30),
                              Obx(
                                () => CustomButton(
                                  isLoading: controller.isLoading.value,
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    43,
                                    131,
                                    68,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  onPressed:
                                      controller.isLoading.value
                                          ? null
                                          : _onSubmit,
                                  child:
                                      controller.isLoading.value
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                            "Valider",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
