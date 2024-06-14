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

   fetchShipments() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://api.wasenahon.com/Kwickly/merchant/shipments/view.php',
      {'user_id': userId.toString()},
      {},
    );
    isLoading.value = false;

    response.fold(
      (failure) {
      },
      (data) {
        if (data['status']) {
          shipments.value = (data['shipments'] as List)
              .map((shipment) => ShipmentModel.fromJson(shipment))
              .toList();
        } else {
        }
      },
    );
  }

  List<ShipmentModel> get filteredShipments {
    if (selectedFilterIndex.value == 0) {
      return shipments
          .where((shipment) => shipment.shipmentStatus == 0)
          .toList();
    } else if (selectedFilterIndex.value == 1) {
      return shipments
          .where((shipment) =>
              shipment.shipmentStatus == 1 ||
              shipment.shipmentStatus == 2 ||
              shipment.shipmentStatus == 3 ||
              shipment.shipmentStatus == 4 ||
              shipment.shipmentStatus == 5 ||
              shipment.shipmentStatus == 6)
          .toList();
    } else if (selectedFilterIndex.value == 2) {
      return shipments
          .where((shipment) => shipment.shipmentStatus == 7)
          .toList();
      return [];
    } else if (selectedFilterIndex.value == 3) {
      return shipments
          .where((shipment) => shipment.shipmentStatus == 10)
          .toList();
      return [];
    }else if (selectedFilterIndex.value == 4) {
      return shipments
          .where((shipment) =>
              shipment.shipmentStatus == 8 || shipment.shipmentStatus == 9)
          .toList();
      return [];
    }
    return shipments;
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
  final String? recipientCity;
  final String senderName;
  final String senderBusinessName;
  final String senderFromAddressDetails;
  final String senderFromAddressLat;
  final String senderFromAddressLong;
  final String senderCity;
  final String? deliveryUserName;
  final String? deliveryUserPhone;

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
    this.recipientCity,
    required this.senderName,
    required this.senderBusinessName,
    required this.senderFromAddressDetails,
    required this.senderFromAddressLat,
    required this.senderFromAddressLong,
    required this.senderCity,
    this.deliveryUserName,
    this.deliveryUserPhone,
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
      recipientCity: json['recipient_info']['city'],
      senderName: json['user_info']['name'],
      senderBusinessName: json['user_info']['business_name'],
      senderFromAddressDetails: json['user_info']['from_address_details'],
      senderFromAddressLat: json['user_info']['from_address_lat'],
      senderFromAddressLong: json['user_info']['from_address_long'],
      senderCity: json['user_info']['city'],
      deliveryUserName: json['delivery_user_info']['name'],
      deliveryUserPhone: json['delivery_user_info']['phone'],
    );
  }
}
