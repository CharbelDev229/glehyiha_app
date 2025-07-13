
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import '../../enums/product_category.dart';

class AddProductDto {
  final String name;
  final String description;
  // 🔴 AJOUT: resume manquant
  final String resume;
  final String marque;
  final double price;
  final int stock;
  final ProductCategory category;
  final String unit;
  final Uint8List imageBytes;
  final String filename;
  final String dateFabrication;
  final String datePeremption;
  // 🔴 AJOUT: latitude et longitude manquants
  final String latitude;
  final String longitude;

  AddProductDto({
    required this.name,
    required this.description,
    required this.resume,
    required this.marque,
    required this.price,
    required this.stock,
    required this.category,
    required this.unit,
    required this.imageBytes,
    required this.filename,
    required this.dateFabrication,
    required this.datePeremption,
    required this.latitude,
    required this.longitude,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'description': description,
      'resume': resume,
      'marque': marque,
      'price': price,
      'stock': stock,
      'category': category.value, // 🔴 CORRECTION: .name -> .value
      'unite': unit,
      'date_fabrication': dateFabrication,
      'date_expiration': datePeremption,
      'latitude': latitude,
      'longitude': longitude,
      'file': await MultipartFile.fromBytes(
        imageBytes,
        filename: filename,
        contentType: MediaType('image', _getImageExtension(filename)),
      ),
    });
  }

  String _getImageExtension(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    return (ext == 'jpg') ? 'jpeg' : ext;
  }
}

// ========================================
// 4. CORRECTION: Formatage des dates dans AddProduct UI
// ========================================

// Dans les sélecteurs de date, remplacer toIso8601String() par un format lisible :

