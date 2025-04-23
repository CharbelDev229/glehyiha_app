import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:glehiha/common/constants/colors.dart';
class ExpertScreen extends StatefulWidget {
  const ExpertScreen({super.key});

  @override
  _ExpertScreenState createState() => _ExpertScreenState();
}

class _ExpertScreenState extends State<ExpertScreen> {
  int _currentIndex = 0;

  _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
     body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
           HeaderWidget(),
           SizedBox(height: 25),
           SizedBox(height: 25,),

     
    ] )),
    
        bottomNavigationBar: CustomBottomNavigationBar(),
        
    );
    
  }
}
