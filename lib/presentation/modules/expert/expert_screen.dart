import 'package:flutter/material.dart';
import 'package:glehiha/presentation/widgets/header_widget/header_widget.dart';
import 'package:glehiha/presentation/widgets/bottom_navigation_bar/navigation_controller.dart';
import 'package:get/get.dart';
import 'package:glehiha/common/constants/colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:glehiha/presentation/widgets/expert/expert_card_widget.dart';

import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';

class ExpertScreen extends StatelessWidget {
  const ExpertScreen({Key? key}) : super(key: key);

 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const SizedBox(height: 25),
              const Text(
                'Trouver des experts agricoles',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              // OpenStreetMap implementation
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(0, 0),
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Expert disponible',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Expert List using the new widget
              const ExpertCardWidget(
                name: 'Dr Maria Rodriguez',
                specialty: 'Spécialiste des maladies des cultures',
                distance: '3.2 km',
                rating: 4.5,
              ),
              const SizedBox(height: 10),
              const ExpertCardWidget(
                name: 'John Smith',
                specialty: 'Expert en santé des sols',
                distance: '4.5 km',
                rating: 4.0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
