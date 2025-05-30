import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/data/models/user/glehiha_current_user.dart';
import 'package:glehiha/data/models/user/glehiha_user.dart';
import 'package:glehiha/domain/usescases/user/update_profile.dart';
import 'package:glehiha/domain/usescases/user/get_profile.dart';
import 'package:glehiha/domain/usescases/user/delete_account.dart';
import 'package:glehiha/domain/usescases/user/change_password.dart';
import 'package:glehiha/domain/usescases/user/loyout.dart';
import '../../common/dtos/profile_dto/change_pwd_dto.dart';

class ProfileService extends GetxService {
  static const _keyImagePath = 'profile_image_path';

  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final LogoutUseCase logoutUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileService({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.logoutUseCase,
    required this.deleteAccountUseCase,
    required this.changePasswordUseCase,
  });

  final isLoading = false.obs;
  final RxString profileImagePath = ''.obs;
  final Rxn<GlehihaCurrentUser> currentUser = Rxn<GlehihaCurrentUser>();

  final oldPassword = ''.obs;
  final newPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfileImagePath();
  }

  /// Sauvegarde du chemin de l'image
  Future<void> _saveProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyImagePath, path);
    profileImagePath.value = path;
  }

  /// Chargement du chemin de l'image sauvegardée
  Future<void> _loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_keyImagePath);
    if (savedPath != null) {
      profileImagePath.value = savedPath;
    }
  }

  /// Nettoyage de l'image
  Future<void> clearProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyImagePath);
    profileImagePath.value = '';
  }

  /// Mise à jour locale du chemin de l'image
  void updateProfileImage(String path) {
    profileImagePath.value = path;
    _saveProfileImagePath(path); // Ajouté pour persister à chaque mise à jour
  }

  /// Ouverture de la galerie pour choisir une image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      updateProfileImage(image.path);
    }
  }

  /// Récupération du profil utilisateur
  Future<bool> onGetMyProfile() async {
    bool success = false;
    final send = await getProfileUseCase.call(const GetProfileParams());

    send.fold(
      (failure) {
        logger.e(failure);
      },
      (response) {
        logger.f(response);
        logger.f("Type de response: ${response.runtimeType}");
        logger.f("Contenu de response: $response");
        currentUser.value = response;
        success = true;
      },
    );

    return success;
  }

  /// Déconnexion de l'utilisateur
  Future<void> onLogout() async {
    setIsLoading(true);
    final result = await logoutUseCase.call(const LogoutParams());

    result.fold(
      (failure) => logger.e(failure),
      (response) => logger.f(response),
    );

    setIsLoading(false);
    clearCurrentUser();
    clearProfileImage(); // nettoyage du cache image à la déconnexion
  }

  /// Suppression du compte utilisateur
  Future<void> onDeleteAccount({required String password}) async {
    setIsLoading(true);

    final result = await deleteAccountUseCase.call(
      DeleteAccountParams(password: password),
    );

    result.fold(
      (failure) => logger.e(failure),
      (response) => logger.f(response),
    );

    setIsLoading(false);
  }

  /// Changement de mot de passe
  Future<void> onChangePassword() async {
    setIsLoading(true);

    final result = await changePasswordUseCase.call(
      ChangePasswordParams(
        newPwdDto: ChangePwdDto(
          oldPassword: oldPassword.value,
          newPassword: newPassword.value,
        ),
      ),
    );

    result.fold(
      (failure) => logger.e(failure),
      (response) => logger.f(response),
    );

    setIsLoading(false);
  }

  /// Conversion en GlehihaUser
  GlehihaUser getUserHasGlehihaUserInfo() {
    final GlehihaCurrentUser glehihaCurrentUser = currentUser.value!;
    return GlehihaUser(
      id: glehihaCurrentUser.id,
      pseudo: glehihaCurrentUser.pseudo,
      media: glehihaCurrentUser.media,
      role: glehihaCurrentUser.role,
    );
  }

  void setIsLoading(bool status) {
    isLoading.value = status;
  }

  void clearCurrentUser() {
    currentUser.value = null;
  }
}
