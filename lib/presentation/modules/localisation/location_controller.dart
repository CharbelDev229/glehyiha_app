import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationController extends GetxController {
  var position = Rxn<Position>();
  var locationEnabled = false.obs;

  Future<void> requestLocation(BuildContext context, {bool forceRequest = true}) async {
    // ✅ Si forceRequest = true, on redemande toujours la position
    if (forceRequest || position.value == null) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationEnabled.value = false;
        _showLocationDialog(context, "Activez la localisation dans les paramètres de votre téléphone.");
        return;
      }
      
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationEnabled.value = false;
          _showLocationDialog(context, "La permission de localisation est requise pour afficher les experts proches.");
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        locationEnabled.value = false;
        _showLocationDialog(context, "La permission de localisation est définitivement refusée. Veuillez l'activer dans les paramètres.");
        return;
      }
      
      locationEnabled.value = true;
      // ✅ Toujours récupérer une nouvelle position
      position.value = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
    }
  }

  void _showLocationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Localisation"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
