import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:glehiha/presentation/modules/expert_page/expert_page_screen.dart';
import 'package:glehiha/presentation/widgets/footer_widget/footer_widget.dart';
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
    final mapController = MapController();
    final dio = Dio();
    final locationController = Get.put(LocationController());
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
      // ✅ Toujours demander la localisation, même si elle existe déjà
      await locationController.requestLocation(context);
      
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
        title: const Text('Experts Agricoles'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshAll(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshAll(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... Section 1: Carte des experts proches ...
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
                                    await locationController.requestLocation(
                                      context,
                                    );
                                    final pos =
                                        locationController.position.value;
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
                        if (!controller.isLoading.value && controller.errorMessage.value.isEmpty)
                          FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: userPosition != null
                                  ? LatLng(userPosition.latitude, userPosition.longitude)
                                  : const LatLng(6.6380, 1.7180), // Position par défaut même sans experts
                              initialZoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                userAgentPackageName: 'com.example.glehiha',
                                additionalOptions: {
                                  'attribution': '© OpenStreetMap contributors',
                                },
                                maxZoom: 19,
                                tileProvider: NetworkTileProvider(),
                              ),
                              // Toujours afficher le marqueur utilisateur s'il existe
                              if (userPosition != null)
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: LatLng(userPosition.latitude, userPosition.longitude),
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
                              // Marqueurs des experts (seulement s'il y en a)
                              if (expertsProches.isNotEmpty)
                                MarkerLayer(
                                  markers: expertsProches
                                      .where((e) => e.latitude != 0.0 && e.longitude != 0.0)
                                      .map(
                                        (expert) => Marker(
                                          point: LatLng(expert.latitude, expert.longitude),
                                          width: 80,
                                          height: 80,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(() => ExpertPageScreen(
                                                name: '${expert.firstName} ${expert.lastName}',
                                                expert: expert,
                                              ));
                                            },
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
                                                  child: Text(
                                                    '${expert.firstName.substring(0, 1)}${expert.lastName.substring(0, 1)}',
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.person_pin_circle,
                                                  color: Colors.red,
                                                  size: 36,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                            ],
                          ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: AppColors.primaryGreen,
                            onPressed: () async {
                              if (userPosition != null) {
                                mapController.move(
                                  LatLng(
                                    userPosition.latitude,
                                    userPosition.longitude,
                                  ),
                                  13.0,
                                );
                              } else {
                                await locationController.requestLocation(
                                  context,
                                );
                                final pos = locationController.position.value;
                                if (pos != null) {
                                  mapController.move(
                                    LatLng(pos.latitude, pos.longitude),
                                    13.0,
                                  );
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
                              await locationController.requestLocation(context);
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
                              await locationController.requestLocation(context);
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
                    itemCount: controller.experts.length,
                    itemBuilder: (context, index) {
                      final expert = controller.experts[index];
                      return ExpertCardWidget(
                        name: '${expert.firstName} ${expert.lastName}',
                        specialty: expert.specialization,
                        distance: controller.getFormattedDistance(
                          expert.distanceKm,
                        ),
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
                  color: AppColors.primaryGreen,
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
                Obx(() {
                  if (controller.isLoadingAllTrainers.value &&
                      controller.allTrainers.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage.value.isNotEmpty &&
                      controller.allTrainers.isEmpty) {
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
                            name: '${expert.firstName} ${expert.lastName}',
                            specialty: expert.specialization,
                            distance: controller.getFormattedDistance(
                              expert.distanceKm,
                            ),
                            rating: 4.0,
                            expert: expert,
                          );
                        },
                      ),
                      if (controller.allTrainers.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed:
                                    controller.hasPrevPage.value
                                        ? () => controller.loadPrevPage()
                                        : null,
                                child: const Text('Précédent'),
                              ),
                              Text(
                                'Page ${controller.currentPage.value} sur ${controller.totalPages.value}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed:
                                    controller.hasNextPage.value
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
      bottomNavigationBar: CustomBottomBar(), // Ajoute le footer ici
    );
  }
}
