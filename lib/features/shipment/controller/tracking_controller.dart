import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/storage_service.dart';

class TrackingController extends GetxController {
  final int shipmentId;
  TrackingController({required this.shipmentId});

  var isLoading = true.obs;
  var isSuccess = false.obs;
  var shipmentInfo = {}.obs;
  var recipientInfo = {}.obs;
  var merchantInfo = {}.obs;
  var announcements = [].obs;

  late BitmapDescriptor customIcon;

  @override
  void onInit() {
    super.onInit();
    setCustomMarkerIcon();
    fetchShipmentDetails();
  }

  void fetchShipmentDetails() async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    final response = await http.post(
      Uri.parse('https://talabea.000webhostapp.com/merchant/shipments/viewById.php'),
      body: {
        'user_id': userId.toString(),
        'shipment_id': shipmentId.toString()
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        shipmentInfo.value = data['shipment_info'];
        recipientInfo.value = data['recipient_info'];
        merchantInfo.value = data['user_info'];
        announcements.value = data['announcements'];
        isSuccess.value = true;
      } else {
        isSuccess.value = false;
      }
    } else {
      isSuccess.value = false;
    }

    isLoading.value = false;
  }

  void setCustomMarkerIcon() async {
    final ByteData byteData = await rootBundle.load('assets/images/merchant_mark.png');
    final Uint8List imageData = byteData.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(imageData, targetWidth: 70, targetHeight: 100);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? resizedImageData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageBytes = resizedImageData!.buffer.asUint8List();

    customIcon = BitmapDescriptor.fromBytes(resizedImageBytes);
  }
}


