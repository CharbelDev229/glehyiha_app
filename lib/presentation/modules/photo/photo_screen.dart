import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';

import '../../widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  int _currentIndex = 0;

  _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
         HeaderWidget(),
           SizedBox(height: 25),
           SizedBox(height: 25,),

    ] )),
    
        bottomNavigationBar: CustomBottomBar(),
    );
    
  }
}
