import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MpController extends GetxController {
  var recipientLat = 31.963158.obs; // Coordinates of Jordan
  var recipientLong = 35.930359.obs; // Coordinates of Jordan
  var selectedLocation = LatLng(31.963158, 35.930359).obs; // Coordinates of Jordan

  late GoogleMapController mapController;

  // Define the LatLngBounds for Jordan
  final LatLngBounds jordanBounds = LatLngBounds(
    southwest: LatLng(29.1836, 34.9596), // South-west corner of Jordan
    northeast: LatLng(33.3752, 39.3019), // North-east corner of Jordan
  );

  void initializeLocation() {
    selectedLocation.value = LatLng(recipientLat.value, recipientLong.value);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newLatLngBounds(jordanBounds, 50));
  }

  void onTap(LatLng location) {
    if (jordanBounds.contains(location)) {
      selectedLocation.value = location;
      recipientLat.value = location.latitude;
      recipientLong.value = location.longitude;
      print(recipientLong.value);
      print(recipientLat.value);
      mapController.animateCamera(CameraUpdate.newLatLng(location));
    } else {
      Get.snackbar('خطأ', 'الموقع المحدد خارج حدود الأردن.');
    }
  }
}
