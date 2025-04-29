import 'package:get/get.dart';
import 'package:glehiha/presentation/modules/chat/chat_screen.dart';
import 'package:glehiha/presentation/modules/expert/expert_screen.dart';
import 'package:glehiha/presentation/modules/photo/photo_screen.dart';
import 'package:glehiha/presentation/modules/market/market_screen.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
    navigateToScreen(index);
  }

  void navigateToScreen(int index) {
    if (index == 0) {
      Get.offAll(() => ChatScreen());
    } else if (index == 1) {
      Get.offAll(() => ExpertScreen());
    } else if (index == 2) {
      Get.offAll(() => PhotoScreen());
    } else if (index == 3) {
      Get.offAll(() => MarketScreen());
    }
  }
}

