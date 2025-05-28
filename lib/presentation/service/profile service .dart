import 'package:get/get.dart';
import 'package:glehiha/common/constants/instances.dart';
import 'package:glehiha/data/models/user/glehiha_current_user.dart';
import 'package:glehiha/domain/usescases/user/update_profile.dart';
import '../../common/dtos/profile_dto/change_pwd_dto.dart';
import '../../data/models/user/glehiha_user.dart';
import '../../domain/usescases/user/change_password.dart';
import '../../domain/usescases/user/delete_account.dart';
import '../../domain/usescases/user/get_profile.dart';
import '../../domain/usescases/user/loyout.dart';

class ProfileService extends GetxService {
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
    RxString selectedImagePath = ''.obs;

  Rxn<GlehihaCurrentUser> currentUser = Rxn<GlehihaCurrentUser>();

  final oldPassword = ''.obs;
  final newPassword = ''.obs;

  void setIsLoading(bool status) {
    isLoading.value = status;
  }
  void clearCurrentUser() {
    currentUser.value = null;
  }
     void updateProfileImage(String path) {
    selectedImagePath.value = path;
  }
  /// Récupération des infos utilisateur
  // for get user infos
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

  GlehihaUser getUserHasGlehihaUserInfo() {
    GlehihaCurrentUser glehihaCurrentUser = currentUser.value!;
    GlehihaUser glehihaUser = GlehihaUser(
      id: glehihaCurrentUser.id,
      pseudo: glehihaCurrentUser.pseudo,
      media: glehihaCurrentUser.media,
      role: glehihaCurrentUser.role,
    );

    return glehihaUser;
  }
}
