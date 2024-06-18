import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import '../../../utils/constants/colors.dart';

class MpController extends GetxController {
  var recipientLat = 31.9539.obs; // Coordinates of Amman
  var recipientLong = 35.9106.obs; // Coordinates of Amman
  late final LatLng initialPosition = LatLng(31.9539, 35.9106); // Coordinates of Amman
  var selectedLocation = LatLng(31.9539, 35.9106).obs; // Coordinates of Amman
  late BitmapDescriptor merchantCustomIcon;
  late GoogleMapController mapController;

  Future<void> initialize() async {
    await setCustomMarkerIcons();
  }

  Future<void> setCustomMarkerIcons() async {
    merchantCustomIcon = await createCustomMarkerIcon('assets/images/recipent_mark.png');
  }

  Future<BitmapDescriptor> createCustomMarkerIcon(String assetPath) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    final Uint8List imageData = byteData.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(imageData, targetWidth: 70, targetHeight: 100);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? resizedImageData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageBytes = resizedImageData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedImageBytes);
  }

  // Define the LatLngBounds for Jordan
  final LatLngBounds jordanBounds = LatLngBounds(
    southwest: LatLng(29.186004417721982, 34.960356540977955), // South-west corner of Jordan
    northeast: LatLng(33.37445470544933, 38.79321377724409), // North-east corner of Jordan
  );

  // Define the polygon for Jordan's borders
  final List<LatLng> jordanPolygonCoords = [
    LatLng(29.35710624160365, 34.960356540977955),
    LatLng(29.186004417721982, 36.06992371380329),
    LatLng(29.500036758657515, 36.50461658835411),
    LatLng(29.868709005385274, 36.75370026379824),
    LatLng(29.999993181855327, 37.50000413507223),
    LatLng(30.33265247412292, 37.665534652769566),
    LatLng(30.500656227126548, 37.997070774436),
    LatLng(31.50011260473826, 37.000902369618416),
    LatLng(31.996458511317304, 38.99592272937298),
    LatLng(32.23029491982611, 39.30116683244705),
    LatLng(32.35872048444148, 39.259475246071815),
    LatLng(32.30997557369853, 39.04467388987541),
    LatLng(32.4777197979711, 38.98603107780218),
    LatLng(32.4777197979711, 38.98603107780218),
    LatLng(32.50277500054379, 39.08745210617781),
    LatLng(33.37445470544933, 38.79321377724409),
    LatLng(32.309290111370856, 36.83653090149164),
    LatLng(32.53066921654482, 36.20139554142952),
    LatLng(32.53028562907582, 36.19429774582386),
    LatLng(32.51253790063161, 36.1660872772336),
    LatLng(32.52348904685806, 36.15582883358002),
    LatLng(32.52560471239052, 36.122376658022404),
    LatLng(32.51289809740784, 36.07800018042326),
    LatLng(32.6557307295814, 36.02696042507887),
    LatLng(32.74468171566687, 35.755427330732346),
    LatLng(32.64706295300653, 35.562053471803665),
    LatLng(31.11166891844878, 35.43172091245651),
    LatLng(29.357280696989694, 34.9600175768137),
  ];

  void initializeLocation() {
    selectedLocation.value = LatLng(recipientLat.value, recipientLong.value);
    print(selectedLocation.value);
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
      mapController.animateCamera(CameraUpdate.newLatLngZoom(location, 12)); // Set zoom level closer to show details
    } else {

      Get.snackbar(
        'خطأ',
        'الموقع المحدد خارج حدود الأردن.',
        backgroundColor: TColors.error,
        colorText: TColors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: TColors.white),
      );
    }
  }

  void moveToLocation(LatLng location) {
    if (jordanBounds.contains(location)) {
      selectedLocation.value = location;
      recipientLat.value = location.latitude;
      recipientLong.value = location.longitude;
      mapController.animateCamera(CameraUpdate.newLatLngZoom(location, 12)); // Set zoom level closer to show details
    } else {
      Get.snackbar(
        'خطأ',
        'الموقع المحدد خارج حدود الأردن.',
        backgroundColor: TColors.error,
        colorText: TColors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: TColors.white),
      );
    }
  }
}
