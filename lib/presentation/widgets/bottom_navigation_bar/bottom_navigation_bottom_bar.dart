import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../common/constants/assets/assets.dart';
import '../bottom_navigation_bar/navigation_controller.dart';
import 'package:glehiha/presentation/router/routes.dart';

class CustomBottomBar extends StatelessWidget {
  final NavigationController navController = Get.find();

  CustomBottomBar({super.key});

  final List<BottomNavyBarItem> items = [
    BottomNavyBarItem(
      icon: Image.asset(Assets.chat, width: 30, height: 30),
      itemName: AppRoutesNames.chat,
    ),
    BottomNavyBarItem(
      icon: Image.asset(Assets.contact, width: 30, height: 30),
      itemName: AppRoutesNames.expert,
    ),
    BottomNavyBarItem(
      icon: Image.asset(Assets.camera, width: 30, height: 30),
      itemName: AppRoutesNames.photo,
    ),
    BottomNavyBarItem(
      icon: Image.asset(Assets.store, width: 30, height: 30),
      itemName: AppRoutesNames.market,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedIndex = navController.selectedIndex.value;

      return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 38, 117, 61),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 0),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  items.map((item) {
                    var index = items.indexOf(item);

                    return Expanded(
                      child: TextButton(
                        onPressed: () {
                          navController.changeIndex(index);
                          _navigateToScreen(context, index);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: _ItemWidget(
                          item: item,
                          iconSize: 24,
                          isSelected: index == selectedIndex,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      );
    });
  }

  void _navigateToScreen(BuildContext context, int index) {
    if (index == 0) {
      context.goNamed(AppRoutesNames.chat);
    } else if (index == 1) {
      context.goNamed(AppRoutesNames.expert);
    } else if (index == 2) {
      context.goNamed(AppRoutesNames.photo);
    } else if (index == 3) {
      context.goNamed(AppRoutesNames.market);
    }
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;

  const _ItemWidget({
    required this.item,
    required this.isSelected,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconTheme(
            data: IconThemeData(
              size: iconSize,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            ),
            child: item.icon,
          ),
          const SizedBox(height: 4),
          Text(
            item.itemName,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({required this.icon, required this.itemName});

  final Widget icon;
  final String itemName;
}
