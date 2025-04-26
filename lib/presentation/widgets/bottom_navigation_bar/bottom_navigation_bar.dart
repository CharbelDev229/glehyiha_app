import 'package:flutter/material.dart';
import 'package:glehiha/presentation/modules/chat/chat_screen.dart';
import 'package:glehiha/presentation/modules/expert/expert_screen.dart';
import 'package:glehiha/presentation/modules/market/market_screen.dart';
import 'package:glehiha/presentation/modules/photo/photo_screen.dart';
import 'package:get/get.dart';
import '../bottom_navigation_bar/navigation_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final NavigationController navController = Get.find();

  CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        backgroundColor:  Color.fromARGB(255, 38, 117, 61),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: navController.selectedIndex.value,
        onTap: (index) {
          navController.changeIndex(index);

          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExpertScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PhotoScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MarketScreen()),
            );
          }
        },
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,

        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/chat.png',
              width: 35,
              height: 20,
            ),
            label: "chat",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/contact.png',
              width: 35,
              height: 20,
            ),
            label: "Expert",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/camera.png',
              width: 35,
              height: 20,
            ),
            label: "Photo",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/store.png',
              width: 35,
              height: 20,
            ),
            label: "Market",
          ),
        ],
      ),
    );
  }
}
