import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:glehiha/presentation/modules/expert_page/expert_page_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

import '../../../common/constants/colors.dart';
import '../../widgets/bottom_navigation_bar/bottom_navigation_bottom_bar.dart';
import '../../widgets/expert/expert_card_widget.dart';
import '../../widgets/header_widget/header_widget.dart';
import 'expert_controller.dart';
import '../localisation/location_controller.dart';
import '../../../data/repositories/expert_repository.dart';
import '../../../data/data_source/expert/expert_remote_data_source.dart';
import '../../../common/helpers/request_manager.dart';

class ExpertScreen extends StatelessWidget {
  const ExpertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Création d'un MapController pour manipuler la carte
    final mapController = MapController();
    
    // Créer une instance de Dio directement
    final dio = Dio();
    
    // D'abord, initialiser le LocationController
    final locationController = Get.put(LocationController());
    
    // Ensuite, initialiser l'ExpertController qui dépend du LocationController
    final controller = Get.put(
      ExpertController(
        expertRepository: ExpertRepositoryImpl(
          expertRemoteDataSource: ExpertRemoteDataSourceImpl(
            dioRequestManager: DioRequestManager(dio: dio),
          ),
        ),
      ),
    );
    
    // Demande la localisation à l'arrivée sur la page
    Future.microtask(() async {
      if (locationController.position.value == null) {
        await locationController.requestLocation();
      }
      final pos = locationController.position.value;
      if (pos != null) {
        await controller.getExpertsProches(
          latitude: pos.latitude,
          longitude: pos.longitude,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        // Ajout du bouton de retour automatique
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back()
        ),
        title: const Text('Experts Agricoles'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshAll(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshAll(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Carte des experts proches
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: const Color.fromARGB(255, 101, 141, 228),
                  child: const Text(
                    'Experts à proximité',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),

                // Carte dynamique avec marqueurs pour les experts proches
                Obx(() {
                  final expertsProches = controller.experts;
                  final userPosition = locationController.position.value;
                  
                  return Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Stack(
                      children: [
                        if (controller.isLoading.value)
                          const Center(child: CircularProgressIndicator()),
                        
                        if (controller.errorMessage.value.isNotEmpty)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.errorMessage.value,
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Recharger la position et les experts
                                    await locationController.requestLocation();
                                    final pos = locationController.position.value;
                                    if (pos != null) {
                                      await controller.getExpertsProches(
                                        latitude: pos.latitude,
                                        longitude: pos.longitude,
                                      );
                                    }
                                  },
                                  child: const Text('Réessayer'),
                                ),
                              ],
                            ),
                          ),
                          
                        if (!controller.isLoading.value && 
                            controller.errorMessage.value.isEmpty)
                          FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: userPosition != null
                                  ? LatLng(
                                      userPosition.latitude,
                                      userPosition.longitude,
                                    )
                                  : (expertsProches.isNotEmpty
                                      ? LatLng(
                                          expertsProches.first.latitude,
                                          expertsProches.first.longitude,
                                        )
                                      : const LatLng(6.6380, 1.7180)),
                              initialZoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                userAgentPackageName: 'com.example.app',
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
                                      width: 60,
                                      height: 60,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: const Text('Vous', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                          ),
                                          const Icon(
                                            Icons.person_pin_circle,
                                            color: Colors.blue,
                                            size: 36,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                              // Marqueurs experts proches
                              MarkerLayer(
                                markers: expertsProches
                                    .where((e) => e.latitude != 0.0 && e.longitude != 0.0)
                                    .map(
                                      (expert) => Marker(
                                        point: LatLng(
                                          expert.latitude,
                                          expert.longitude,
                                        ),
                                        width: 120,
                                        height: 70,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => ExpertPageScreen(
                                              name: '${expert.firstName} ${expert.lastName}',
                                              expert: expert,
                                            ));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${expert.firstName} ${expert.lastName}',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  controller.getFormattedDistance(expert.distanceKm),
                                                  style: const TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                          
                        // Bouton pour recentrer la carte sur la position de l'utilisateur
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: AppColors.primaryGreen,
                            onPressed: () async {
                              if (userPosition != null) {
                                mapController.move(
                                  LatLng(userPosition.latitude, userPosition.longitude),
                                  13.0,
                                );
                              } else {
                                // Si la position n'est pas disponible, demander la localisation
                                await locationController.requestLocation();
                                final pos = locationController.position.value;
                                if (pos != null) {
                                  mapController.move(
                                    LatLng(pos.latitude, pos.longitude),
                                    13.0,
                                  );
                                  // Recharger les experts proches avec la nouvelle position
                                  await controller.getExpertsProches(
                                    latitude: pos.latitude,
                                    longitude: pos.longitude,
                                  );
                                }
                              }
                            },
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),

                // Section 2: Liste des experts proches
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: AppColors.primaryGreen,
                  child: const Text(
                    'Liste des experts proches',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),

                // Liste des experts proches (à moins de 2km)
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              await locationController.requestLocation();
                              final pos = locationController.position.value;
                              if (pos != null) {
                                await controller.getExpertsProches(
                                  latitude: pos.latitude,
                                  longitude: pos.longitude,
                                );
                              }
                            },
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.experts.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          const Text(
                            'Aucun expert trouvé à proximité',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              await locationController.requestLocation();
                              final pos = locationController.position.value;
                              if (pos != null) {
                                await controller.getExpertsProches(
                                  latitude: pos.latitude,
                                  longitude: pos.longitude,
                                );
                              }
                            },
                            child: const Text('Actualiser ma position'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.experts.length, // Ces experts sont à moins de 2km
                    itemBuilder: (context, index) {
                      final expert = controller.experts[index];
                      return ExpertCardWidget(
                        name:'${expert.firstName} ${expert.lastName}',
                        specialty: expert.specialization,
                        distance: controller.getFormattedDistance(expert.distanceKm),
                        rating: 4.0,
                        expert: expert,
                      );
                    },
                  );
                }),

                const SizedBox(height: 30),

                // Section 3: Tous les encadreurs
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: const Color.fromARGB(255, 76, 175, 80),
                  child: const Text(
                    'Tous les encadreurs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),

                // Liste de tous les encadreurs avec pagination
                Obx(() {
                  if (controller.isLoadingAllTrainers.value && controller.allTrainers.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.value.isNotEmpty && controller.allTrainers.isEmpty) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.allTrainers.length,
                        itemBuilder: (context, index) {
                          final expert = controller.allTrainers[index];
                          return ExpertCardWidget(
                            name:'${expert.firstName} ${expert.lastName}',
                            specialty: expert.specialization,
                            distance: controller.getFormattedDistance(expert.distanceKm),
                            rating: 4.0,
                            expert: expert,
                          );
                        },
                      ),
                      
                      // Pagination
                      if (controller.allTrainers.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: controller.hasPrevPage.value
                                    ? () => controller.loadPrevPage()
                                    : null,
                                child: const Text('Précédent'),
                              ),
                              Text(
                                'Page ${controller.currentPage.value} sur ${controller.totalPages.value}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: controller.hasNextPage.value
                                    ? () => controller.loadNextPage()
                                    : null,
                                child: const Text('Suivant'),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
