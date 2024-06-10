import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:shipment_merchent_app/utils/constants/api_constants.dart';
import '../model/shipment_model.dart';

class ShipmentsController extends GetxController {
  var selectedFilterIndex = 0.obs;
  var shipments = <ShipmentModel>[].obs;
  var isLoading = false.obs;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchShipments();
  }

  void setSelectedFilterIndex(int index) {
    selectedFilterIndex.value = index;
  }

  void fetchShipments() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://talabea.000webhostapp.com/merchant/shipments/view.php',
      {'user_id': userId.toString()},
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch shipments');
      },
          (data) {
        if (data['status']) {
          shipments.value = (data['shipments'] as List)
              .map((shipment) => ShipmentModel.fromJson(shipment))
              .toList();
        } else {
          Get.snackbar('Error', 'Failed to fetch shipments');
        }
      },
    );
  }
}

class ShipmentModel {
  final int shipmentId;
  final int shipmentStatus;
  final String shipmentType;
  final String shipmentWeight;
  final int shipmentQuantity;
  final String shipmentValue;
  final String? shipmentNote;
  final String shipmentContents;
  final String shipmentNumber;
  final String createdAt;
  final String estimatedDeliveryTime;
  final String recipientName;
  final String recipientPhone;
  final String recipientAddress;

  ShipmentModel({
    required this.shipmentId,
    required this.shipmentStatus,
    required this.shipmentType,
    required this.shipmentWeight,
    required this.shipmentQuantity,
    required this.shipmentValue,
    required this.shipmentNote,
    required this.shipmentContents,
    required this.shipmentNumber,
    required this.createdAt,
    required this.estimatedDeliveryTime,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientAddress,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      shipmentId: json['shipment_info']['shipment_id'],
      shipmentStatus: json['shipment_info']['shipment_status'],
      shipmentType: json['shipment_info']['shipment_type'],
      shipmentWeight: json['shipment_info']['shipment_weight'],
      shipmentQuantity: json['shipment_info']['shipment_quantity'],
      shipmentValue: json['shipment_info']['shipment_value'],
      shipmentNote: json['shipment_info']['shipment_note'],
      shipmentContents: json['shipment_info']['shipment_contents'],
      shipmentNumber: json['shipment_info']['shipment_number'],
      createdAt: json['shipment_info']['created_at'],
      estimatedDeliveryTime: json['shipment_info']['estimated_delivery_time'],
      recipientName: json['recipient_info']['name'],
      recipientPhone: json['recipient_info']['phone'],
      recipientAddress: json['recipient_info']['address'],
    );
  }
}
