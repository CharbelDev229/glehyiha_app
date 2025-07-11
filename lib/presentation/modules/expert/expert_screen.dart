import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

import '../../../common/constants/colors.dart';
import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';
import '../../widgets/expert/expert_card_widget.dart';
import '../../widgets/header_widget/header_widget.dart';
import 'expert_controller.dart';
import '../localisation/location_controller.dart';

// Ajoute les imports nécessaires pour le repository et le data source
import '../../../data/repositories/expert_repository.dart';
import '../../../data/data_source/expert/expert_remote_data_source.dart';
import '../../../common/helpers/request_manager.dart';

class ExpertScreen extends StatelessWidget {
  const ExpertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<Dio>()) {
      Get.put(Dio());
    }
    // Injection du controller avec son repository/dataSource
    final controller = Get.put(
      ExpertController(
        expertRepository: ExpertRepositoryImpl(
          expertRemoteDataSource: ExpertRemoteDataSourceImpl(
            dioRequestManager: DioRequestManager(dio: Dio()),
          ),
        ),
      ),
    );
    final locationController = Get.put(LocationController());

    // Demande la localisation à l'arrivée sur la page
    Future.microtask(() async {
      if (locationController.position.value == null) {
        await locationController.requestLocation();
        if (!locationController.locationEnabled.value) {
          Get.defaultDialog(
            title: "Localisation",
            middleText:
                "Voulez-vous activer la localisation pour voir les experts proches ?",
            textConfirm: "Oui",
            textCancel: "Non",
            onConfirm: () async {
              await locationController.requestLocation();
              Get.back();
            },
            onCancel: () {},
          );
        }
      }
    });

    return SafeArea(
      child: Container(
        color: AppColors.transparent,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(),
                const SizedBox(height: 10),
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

                // Carte dynamique avec marqueurs
                Obx(() {
                  final experts = controller.experts;
                  final userPosition = locationController.position.value;
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter:
                            userPosition != null
                                ? LatLng(
                                  userPosition.latitude,
                                  userPosition.longitude,
                                )
                                : (experts.isNotEmpty
                                    ? LatLng(
                                      experts.first.latitude,
                                      experts.first.longitude,
                                    )
                                    : LatLng(0, 0)),
                        initialZoom: 13.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        ),
                        // Marqueur position utilisateur
                        if (userPosition != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(
                                  userPosition.latitude,
                                  userPosition.longitude,
                                ),
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.person_pin_circle,
                                  color: Colors.blue,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),
                        // Marqueurs experts
                        MarkerLayer(
                          markers:
                              experts
                                  .map(
                                    (expert) => Marker(
                                      point: LatLng(
                                        expert.latitude,
                                        expert.longitude,
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 36,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ],
                    ),
                  );
                }),
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

                // Liste dynamique des experts
                Obx(() {
                  final experts = controller.experts;
                  if (experts.isEmpty) {
                    return const Center(child: Text('Aucun expert trouvé.'));
                  }
                  return Column(
                    children:
                        experts
                            .map(
                              (expert) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: ExpertCardWidget(
                                  name:
                                      '${expert.firstName} ${expert.lastName}',
                                  specialty: expert.specialization,
                                  distance: '${expert.distanceKm} km',
                                  rating: 4.0, // À adapter si tu as la note
                                ),
                              ),
                            )
                            .toList(),
                  );
                }),

                const SizedBox(height: 40),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomBar(),
        ),
      ),
    );
  }
}
