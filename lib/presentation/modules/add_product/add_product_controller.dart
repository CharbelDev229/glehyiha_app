import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/enums/product_category.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/common/services/location_service.dart';
import 'package:image_picker/image_picker.dart';



class AddProductController {
  
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );
  RxInt index = 1.obs;
  // final SignUpUseCase signUpUseCase;
  final formKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(
    debugLabel: 'add_product',
  );

  // Contrôleurs de formulaire
  TextEditingController nomController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController marqueController = TextEditingController();
  TextEditingController uniteController = TextEditingController();
  
  

  // Variables observables
final Rx<ProductCategory> selectedProduct = ProductCategory.engrais.obs;
 
  RxBool isLoading = false.obs;
  // Ajout de la variable manquante
  // RxBool signUpInLoading = false.obs;
  // RxString errorMessage = ''.obs;
  // RxString selectedCountryCode = '+229'.obs;
  RxBool autoValidate = false.obs;
  

  // Variables de localisation
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  //SignUpController({required this.signUpUseCase});

  void onPageChanged(int index) {
    this.index.value = index;
  }

  void onChangeStep({required int index}) {
    this.index.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  Future<void> getCurrentLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        latitude.value = position.latitude.toString();
        longitude.value = position.longitude.toString();
      }
    } catch (e) {
      logger.e('Erreur de localisation: $e');
    }
  }

  //   Future<bool> register(BuildContext context) async {
  //     bool success = false;
  //     signUpInLoading.value = true;

  //     logger.d('Inscription: ${nomController.text} ${prenomController.text}');

  //     final send = await signUpUseCase.call(
  //       SignUpParams(
  //         dto: RegisterDto(
  //           firstname: nomController.text,
  //           lastname: prenomController.text,
  //           email: emailController.text,
  //           password: passwordController.text,
  //           phoneNumber: phoneNumberController.text,
  //           userRole: selectedRole.value,
  //           specialisation: specialisationController.text,
  //           experience: experienceController.text,
  //           shopName: shopNameController.text,
  //         ),
  //       ),
  //     );

  //     send.fold(
  //       (failure) {
  //         Utils.snackError(context: context, message: failure.message);
  //       },
  //       (email) async {
  //         Utils.snackSuccess(context: context, message: 'Inscription réussie!');

  //         success = true;

  //         if (context.mounted) {
  //  //context.pushNamed(AppRoutesNames.code);

  //         }
  //       },
  //     );

  //     signUpInLoading.value = false;
  //     return success;
  //   }

  final pickedImage = Rxn<XFile>();
  final ImagePicker imagePicker = ImagePicker();

  get selectedRole => null;

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      pickedImage.value = image;
    }
  }
}
