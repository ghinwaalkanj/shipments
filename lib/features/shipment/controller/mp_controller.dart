import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MpController extends GetxController {
  var recipientLat = 33.5138.obs;
  var recipientLong = 36.2765.obs;
  var selectedLocation = LatLng(33.5138, 36.2765).obs;

  late GoogleMapController mapController;

  void initializeLocation() {
    selectedLocation.value = LatLng(recipientLat.value, recipientLong.value);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onTap(LatLng location) {
    selectedLocation.value = location;
    recipientLat.value = location.latitude;
    recipientLong.value = location.longitude;
    print(recipientLong.value);
    print(recipientLat.value);
    mapController.animateCamera(CameraUpdate.newLatLng(location));
  }
}//
