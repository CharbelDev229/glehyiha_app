import 'dart:math';

import 'package:get/get.dart';
import '../localisation/location_controller.dart';
import '../../../data/models/expert/expert_model.dart';
import '../../../data/repositories/expert_repository.dart';

class ExpertController extends GetxController {
  final ExpertRepository expertRepository;
  
  // Variables observables
  RxList<Expert> experts = <Expert>[].obs;
  RxList<Expert> allTrainers = <Expert>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingAllTrainers = false.obs;
  RxString errorMessage = ''.obs;
  RxInt currentPage = 1.obs;
  RxBool hasNextPage = false.obs;
  RxBool hasPrevPage = false.obs;
  RxInt totalPages = 1.obs;
  RxInt totalTrainers = 0.obs;

  ExpertController({required this.expertRepository});

  @override
  void onInit() {
    super.onInit();
    // Charger tous les encadreurs au démarrage
    getAllTrainers();
  }

  // Récupérer les experts proches
  Future<void> getExpertsProches({required double latitude, required double longitude}) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await expertRepository.getExpertsProches(
        latitude: latitude,
        longitude: longitude,
      );
      
      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          experts.clear();
        },
        (response) {
          if (response.success) {
            experts.assignAll(response.expertsProches);
            
            // Le backend renvoie déjà les experts à moins de 2km
            // Pas besoin de filtrer à nouveau, mais on peut vérifier
            if (experts.isEmpty) {
              errorMessage.value = 'Aucun expert trouvé dans un rayon de 2 km';
            }
          } else {
            errorMessage.value = response.message;
            experts.clear();
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Erreur lors du chargement des experts: $e';
      experts.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Récupérer tous les encadreurs avec pagination
  Future<void> getAllTrainers({int page = 1, int perPage = 10}) async {
    isLoadingAllTrainers.value = true;
    if (page == 1) {
      errorMessage.value = '';
    }

    try {
      final result = await expertRepository.getAllTrainers(
        page: page,
        perPage: perPage,
      );
      
      result.fold(
        (failure) {
          if (page == 1) {
            errorMessage.value = failure.message;
            allTrainers.clear();
          }
        },
        (response) {
          if (response.success) {
            // Calculer la distance pour chaque encadreur par rapport à la position actuelle
            final locationController = Get.find<LocationController>();
            final userPosition = locationController.position.value;
            
            if (userPosition != null) {
              for (int i = 0; i < response.trainers.length; i++) {
                final trainer = response.trainers[i];
                final distance = _calculateDistance(
                  userPosition.latitude,
                  userPosition.longitude,
                  trainer.latitude,
                  trainer.longitude,
                );
                response.trainers[i] = trainer.copyWith(distanceKm: distance);
              }
              
              // Trier par distance
              response.trainers.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
            }
            
            if (page == 1) {
              allTrainers.assignAll(response.trainers);
            } else {
              allTrainers.addAll(response.trainers);
            }
            
            currentPage.value = response.pagination.page;
            hasNextPage.value = response.pagination.hasNext;
            hasPrevPage.value = response.pagination.hasPrev;
            totalPages.value = response.pagination.pages;
            totalTrainers.value = response.pagination.total;
          } else {
            if (page == 1) {
              errorMessage.value = response.message;
              allTrainers.clear();
            }
          }
        },
      );
    } catch (e) {
      if (page == 1) {
        errorMessage.value = 'Erreur lors du chargement des encadreurs: $e';
        allTrainers.clear();
      }
    } finally {
      isLoadingAllTrainers.value = false;
    }
  }

  // Calculer la distance entre deux points géographiques (formule de Haversine)
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Rayon de la Terre en km
    
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }

  // Charger la page suivante
  Future<void> loadNextPage() async {
    if (hasNextPage.value && !isLoadingAllTrainers.value) {
      await getAllTrainers(page: currentPage.value + 1);
    }
  }

  // Charger la page précédente
  Future<void> loadPrevPage() async {
    if (hasPrevPage.value && !isLoadingAllTrainers.value) {
      await getAllTrainers(page: currentPage.value - 1);
    }
  }

  // Rafraîchir toutes les données
  Future<void> refreshAll() async {
    final locationController = Get.find<LocationController>();
    
    // Recharger la position
    await locationController.requestLocation();
    final pos = locationController.position.value;
    
    // Recharger les données
    await Future.wait([
      getAllTrainers(page: 1),
      if (pos != null) 
        getExpertsProches(latitude: pos.latitude, longitude: pos.longitude),
    ]);
  }

  // Formater la distance pour l'affichage
  String getFormattedDistance(double? distanceKm) {
    if (distanceKm == null || distanceKm == 0) return 'Distance inconnue';
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).toStringAsFixed(0)} m';
    }
    return '${distanceKm.toStringAsFixed(1)} km';
  }
}
