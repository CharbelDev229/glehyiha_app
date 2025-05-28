import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/modules/auth/verification_code/verification_code_controller.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:glehiha/presentation/widgets/background_decoration/background_deco.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/button/custom_button.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.controller});
  final VerificationCodeController controller;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late VerificationCodeController controller;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool _autoValidate = false;

  late String email ; 

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final verification_code = _controllers.map((c) => c.text).join();
      if (verification_code.length == 6) {
        await controller.verifyUserAccount(context, verification_code, email);
      }
    });
  }

 


  Future<void> _onSubmit() async {
  final isFormValid = controller.formKey.currentState!.validate();
  if (isFormValid) {
    final verification_code = _controllers.map((c) => c.text).join();
    final email = controller.email;
    final success = await controller.verifyUserAccount(context, verification_code, email);
    if (success) {
      context.pushNamed(AppRoutesNames.parameters);
    }
  } else {
    setState(() {
      _autoValidate = true;
    });
  }
}

   Future<void> _onResendCode() async {
     await controller.resentVerificationCode(context);
   }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final boxWidth = (deviceWidth - 80) / 8;

    return SafeArea(
      child: BackgroundDeco(
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.formKey,
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 90,
                                child: Divider(thickness: 2, color: AppColors.black),
                              ),
                              const SizedBox(height: 25),
                              const Text(
                                "Code OTP",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Veuillez saisir le code à 6 chiffres envoyé à votre adresse email.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 10,
                                children: List.generate(6, (index) {
                                  return SizedBox(
                                    width: boxWidth,
                                    height: 60,
                                    child: TextFormField(
                                      controller: _controllers[index],
                                      focusNode: _focusNodes[index],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        counterText: "",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.green, width: 2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                        } else if (value.isEmpty && index > 0) {
                                          FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '';
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(height: 30),
                              Obx(
                                () => CustomButton(
                                  isLoading: controller.isLoading.value,
                                  backgroundColor: const Color.fromARGB(255, 43, 131, 68),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  onPressed: controller.isLoading.value ? null : _onSubmit,
                                  child: const Text(
                                    "Valider",
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: _onResendCode,
                                child: const Text(
                                  "Renvoyer le code",
                                  style: TextStyle(
                                    color: AppColors.green,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
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
