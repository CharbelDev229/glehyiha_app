import 'package:flutter/material.dart';
import 'package:glehiha/presentation/modules/parameters/parameters_controller.dart';
import 'package:glehiha/presentation/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/gestures.dart';
import 'package:glehiha/common/constants/assets/assets.dart';

import '../../../common/constants/colors.dart';


class ParametersScreen extends StatefulWidget {
  final ParametersController controller;
  const ParametersScreen({super.key, required this.controller});
  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  late ParametersController controller;
  @override
  void initState() {
    controller = widget.controller;
    controller.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
        body: SingleChildScrollView(
        child: Column(
      children: [
         Padding(
              padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Que voulez-vous faire\n",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                    text: " !?",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutesNames.chat);
              },
          child:   Image.asset(Assets.chat, width: 80, height: 80),),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 201, 221, 214),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Discuter avec le chatbot pour prendre conseil',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed(AppRoutesNames.chat);
                          },
                  ),
                ),
              ),
            ),

           
           
            SizedBox(height: 8),
            GestureDetector(
              onTap: (){
              context.pushNamed(AppRoutesNames.expert);
              },
           child:  Image.asset(
              Assets.contact,
              width: 80,
              height: 80,
            ),),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 201, 221, 214),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Entrez en contact avec les experts',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed(AppRoutesNames.expert);
                          },
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),
            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoutesNames.market);
              },
         child:    Image.asset(Assets.store, width: 80, height: 80),),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 201, 221, 214),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Acheter des engrais pour vos cultures',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed(AppRoutesNames.market);
                          },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
         ]) ));
  }
}
