import 'package:glehiha/data/models/expert/expert_model.dart';

class PaginationInfo {
  final bool hasNext;
  final bool hasPrev;
  final int page;
  final int pages;
  final int perPage;
  final int total;

  PaginationInfo({
    required this.hasNext,
    required this.hasPrev,
    required this.page,
    required this.pages,
    required this.perPage,
    required this.total,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      hasNext: json['has_next'] as bool? ?? false,
      hasPrev: json['has_prev'] as bool? ?? false,
      page: json['page'] as int? ?? 1,
      pages: json['pages'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
    );
  }
}

class AllTrainersResponse {
  final List<Expert> trainers;
  final PaginationInfo pagination;
  final String message;
  final bool success;

  AllTrainersResponse({
    required this.trainers,
    required this.pagination,
    required this.message,
    required this.success,
  });

  factory AllTrainersResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final paginationData = data['pagination'] ?? {};
    final trainersList = data['trainers'] as List? ?? [];
    
    return AllTrainersResponse(
      trainers: trainersList
          .map((i) => Expert.fromJson(i as Map<String, dynamic>))
          .toList(),
      pagination: PaginationInfo.fromJson(paginationData),
      message: json['message'] as String? ?? 'Erreur inconnue',
      success: json['success'] as bool? ?? false,
    );
  }
}