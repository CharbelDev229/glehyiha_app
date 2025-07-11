import 'package:get/get.dart';
import '../../../data/models/expert/expert_model.dart';
import '../../../data/repositories/expert_repository.dart';
import '../../../common/utils/failure.dart';
import 'package:dartz/dartz.dart';

class ExpertController extends GetxController {
  final ExpertRepository expertRepository;

  ExpertController({required this.expertRepository});

  var experts = <Expert>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchExpertsProches({
    int? page,
    int? pageSize,
    String? sortBy,
    String? order,
    Map<String, dynamic>? additionalParams,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await expertRepository.fetchExpertsProches(
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      order: order,
      additionalParams: additionalParams,
    );
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        experts.clear();
      },
      (response) {
        experts.value =  response.expertsProches;
      },
    );
    isLoading.value = false;
  }
}