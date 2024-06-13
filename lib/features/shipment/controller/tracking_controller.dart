import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackingController extends GetxController {
  final int shipmentId;
  TrackingController({required this.shipmentId});

  var isLoading = true.obs;
  var isSuccess = false.obs;
  var shipmentInfo = {}.obs;
  var recipientInfo = {}.obs;
  var announcements = [].obs;

  @override
  void onInit() {
    fetchShipmentDetails();
    super.onInit();
  }

  void fetchShipmentDetails() async {
    final response = await http.post(
      Uri.parse('https://talabea.000webhostapp.com/merchant/shipments/viewById.php'),
      body: {'shipment_id': shipmentId.toString()},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        shipmentInfo.value = data['shipment_info'];
        recipientInfo.value = data['recipient_info'];
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
}
