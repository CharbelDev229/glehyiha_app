import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../common/constants/colors.dart';
import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';
import '../../widgets/expert/expert_card_widget.dart';
import '../../widgets/header_widget/header_widget.dart';

class ExpertScreen extends StatelessWidget {
  const ExpertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
         color: AppColors.transparent,
     
      child: Scaffold(
        
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
              const SizedBox(height: 25),

              Center(
                child: Text(
                  'Trouver des experts agricoles',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: const Color.fromARGB(255, 101, 141, 228),
                  child: const Text(
                    'Expert à proximité',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // 🗺 Carte OpenStreetMap
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
                      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              Text(
                'Expert disponible',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 101, 141, 228),
                ),
              ),
              const SizedBox(height: 10),

              const ExpertCardWidget(
                name: 'Dr Maria Rodriguez',
                specialty: 'Spécialiste des maladies des cultures',
                distance: '3.2 km',
                rating: 4.5,
              ),
              const SizedBox(height: 25),
              const ExpertCardWidget(
                name: 'John Smith',
                specialty: 'Expert en santé des sols',
                distance: '4.5 km',
                rating: 4.0,
              ),

              const SizedBox(height: 40), // Marge sous le contenu
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
     ) );
  }
}
