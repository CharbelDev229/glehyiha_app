import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';

import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  


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
