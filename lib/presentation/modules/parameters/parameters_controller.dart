import '../../../common/constants/instances.dart';
import '../../../common/constants/storage_keys.dart';

class ParametersController {
  void init() {
    prefs.setBool(StorageKeys.isFirstTimeKey, true);
  }
}
