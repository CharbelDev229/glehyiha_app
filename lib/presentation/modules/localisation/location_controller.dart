import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  var position = Rxn<Position>();
  var locationEnabled = false.obs;

  Future<void> requestLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationEnabled.value = false;
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationEnabled.value = false;
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      locationEnabled.value = false;
      return;
    }
    locationEnabled.value = true;
    position.value = await Geolocator.getCurrentPosition();
  }
}