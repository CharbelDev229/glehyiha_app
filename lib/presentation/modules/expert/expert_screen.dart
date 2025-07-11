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
        if (!locationController.locationEnabled.value) {
          Get.defaultDialog(
            title: "Localisation",
            middleText: "Voulez-vous activer la localisation pour voir les experts proches ?",
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Experts Agricoles'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
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
                          Center(child: CircularProgressIndicator()),
                        
                        if (controller.errorMessage.value.isNotEmpty)
                          Center(
                            child: Text(
                              controller.errorMessage.value,
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
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
                                      : LatLng(5.349390, -4.017050)), // Abidjan par défaut
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
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: Text('Vous', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                          ),
                                          Icon(
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
                                            // Afficher plus d'informations sur l'expert
                                            Get.defaultDialog(
                                              title: "${expert.firstName} ${expert.lastName}",
                                              content: Column(
                                                children: [
                                                  Text("Spécialité: ${expert.specialization}"),
                                                  Text("Distance: ${expert.distanceKm.toStringAsFixed(1)} km"),
                                                  Text("Adresse: ${expert.adresse}"),
                                                  SizedBox(height: 10),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Navigation vers la page détaillée de l'expert
                                                      Get.back();
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => ExpertPageScreen(
                                                            name: "${expert.firstName} ${expert.lastName}",
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text("Voir le profil"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(4),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  '${expert.firstName}',
                                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Icon(
                                                Icons.location_on,
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
                          
                        // Bouton pour recentrer la carte sur l'utilisateur
                        if (userPosition != null)
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: FloatingActionButton(
                              mini: true,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.my_location, color: Colors.blue),
                              onPressed: () {
                                mapController.move(
                                  LatLng(userPosition.latitude, userPosition.longitude),
                                  13.0,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 30),
                
                // Section 2: Liste de tous les experts
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: const Color.fromARGB(255, 101, 141, 228),
                  child: const Text(
                    'Tous les experts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),

                // Liste de tous les experts avec pagination
                Obx(() {
                  if (controller.allRegisteredExpertsLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (controller.allRegisteredExpertsErrorMessage.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.allRegisteredExpertsErrorMessage.value,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  
                  if (controller.allRegisteredExperts.isEmpty) {
                    return const Center(child: Text('Aucun expert trouvé'));
                  }
                  
                  return Column(
                    children: [
                      // Liste des experts
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.allRegisteredExperts.length,
                        itemBuilder: (context, index) {
                          final expert = controller.allRegisteredExperts[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ExpertCardWidget(
                              name: '${expert.firstName} ${expert.lastName}',
                              specialty: expert.specialization,
                              distance: expert.distanceKm != null ? '${expert.distanceKm.toStringAsFixed(1)} km' : 'N/A',
                              rating: 4.0, // À adapter si vous avez la note
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpertPageScreen(
                                      name: "${expert.firstName} ${expert.lastName}",
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      
                      // Contrôles de pagination
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Bouton page précédente
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: controller.hasPrevPage.value
                                  ? () => controller.previousPage()
                                  : null,
                            ),
                            
                            // Affichage de la pagination
                            Text(
                              'Page ${controller.currentPage.value} sur ${controller.totalPages.value}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            
                            // Bouton page suivante
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: controller.hasNextPage.value
                                  ? () => controller.nextPage()
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      
                      // Informations sur le nombre total
                      Text(
                        'Total: ${controller.totalExperts.value} experts',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      
                      // Sélecteur du nombre d'éléments par page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Éléments par page: '),
                          DropdownButton<int>(
                            value: controller.perPage.value,
                            items: [10, 20, 50, 100].map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                controller.changePerPage(newValue);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }
}
