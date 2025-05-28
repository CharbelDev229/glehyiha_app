import '../../../common/constants/instances.dart';
import '../../../common/constants/storage_keys.dart';

class OnboardingController {
  void init() {
    prefs.setBool(StorageKeys.isFirstTimeKey, false);
  }
}
