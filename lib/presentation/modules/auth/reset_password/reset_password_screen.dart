import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:glehiha/presentation/modules/auth/reset_password/reset_password_controller.dart';
import 'package:glehiha/presentation/widgets/background_decoration/background_deco.dart';
import '../../../../common/utils/text_field_validators.dart';
import '../../../../common/utils/utils.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/custom_text_form_field/custom_text_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.controller});
  final ResetPasswordController controller;
  

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ResetPasswordController controller;
    bool _autoValidate = false;
 
  @override
  void initState() {
    controller = widget.controller;
    super.initState();
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
                        child: Obx(
  () => Form(
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
          "Mot de passe oublié",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Veuillez entrer votre nouveau mot de passe et le code envoyé",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: controller.newpasswordController,
          validator: TextFieldValidators.required,
          labelText: "Nouveau mot de passe",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          suffixIcon: const Icon(
            Icons.lock,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: controller.resetcodeController,
          validator: TextFieldValidators.required,
          labelText: "Code envoyé",
          keyboardType: TextInputType.number,
          
        ),
        const SizedBox(height: 40),
        CustomButton(
          isLoading: controller.isLoading.value,
          backgroundColor: const Color.fromARGB(255, 43, 131, 68),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          onPressed: controller.isLoading.value
              ? null
              : () => controller.submitRequest(context),
          child: controller.isLoading.value
              ? const CircularProgressIndicator()
              : const Text(
                  "Valider",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    ),
  ),
),)))]);

              
            },
          ),
        ),
      ),
    );
  }
}
