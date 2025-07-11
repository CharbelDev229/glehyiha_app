import 'package:get/get.dart';
import '../../../data/models/expert/expert_model.dart';
import '../../../data/repositories/expert_repository.dart';
import '../../../common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../localisation/location_controller.dart';

class ExpertController extends GetxController {
  final ExpertRepository expertRepository;
  final LocationController locationController = Get.find<LocationController>();
  
  // Variables pour la pagination
  var page = 1.obs;
  var perPage = 10.obs;
  var hasMorePages = true.obs;
  
  // Variables pour l'état
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  
  // Listes d'experts
  var expertsProches = <Expert>[].obs;
  var allTrainers = <Expert>[].obs;

  ExpertController({required this.expertRepository});

  @override
  void onInit() {
    super.onInit();
    fetchExpertsProches();
    fetchAllTrainers();
  }

  Future<void> fetchExpertsProches({
    Map<String, dynamic>? additionalParams,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    // Récupérer la position de l'utilisateur si disponible
    final userPosition = locationController.position.value;
    
    // Préparer les paramètres additionnels avec la position si disponible
    final params = <String, dynamic>{};
    if (userPosition != null) {
      params['latitude'] = userPosition.latitude;
      params['longitude'] = userPosition.longitude;
    }
    
    // Fusionner avec les paramètres additionnels fournis
    if (additionalParams != null) {
      params.addAll(additionalParams);
    }
    
    final result = await expertRepository.fetchExpertsProches(
      additionalParams: params,
    );
    
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (response) {
        expertsProches.value = response.expertsProches;
      },
    );
    
    isLoading.value = false;
  }

  Future<void> fetchAllTrainers({bool refresh = false}) async {
    if (refresh) {
      page.value = 1;
      hasMorePages.value = true;
      allTrainers.clear();
    }
    
    if (!hasMorePages.value) return;
    
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await expertRepository.fetchAllTrainers(
      page: page.value,
      perPage: perPage.value,
    );
    
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (response) {
        allTrainers.addAll(response.);
        
        // Mettre à jour les informations de pagination
        if (response.pagination != null) {
          page.value = response.pagination.page;
          perPage.value = response.pagination.perPage;
          hasMorePages.value = page.value < response.pagination.pages;
        } else {
          hasMorePages.value = false;
        }
      },
    );
    
    isLoading.value = false;
  }

  void loadMoreTrainers() {
    if (!isLoading.value && hasMorePages.value) {
      page.value++;
      fetchAllTrainers();
    }
  }

  void refreshData() {
    fetchExpertsProches();
    fetchAllTrainers(refresh: true);
  }
}
