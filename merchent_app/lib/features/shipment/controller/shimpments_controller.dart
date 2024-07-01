import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';

class ShipmentsController extends GetxController {
  var selectedFilterIndex = 0.obs;
  var errorMessage = ''.obs;
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
    fetchShipments();
  }

  fetchShipments() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var shipmentStatus = _getShipmentStatusByFilterIndex(selectedFilterIndex.value);
    var response = await crud.postData(
      ViewShipmentEndpoint,
      {
        'user_id': userId.toString(),
        'shipment_status': shipmentStatus,
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        errorMessage.value = 'فشل في الاتصال بالخادم، أعد المحاولة';
        Get.snackbar(
          'خطأ',
          'فشل في الاتصال بالخادم، أعد المحاولة',
          backgroundColor: TColors.error,
          colorText: TColors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: TColors.white),
        );
      },
          (data) {
        if (data['status']) {
          shipments.value = (data['shipments'] as List)
              .map((shipment) => ShipmentModel.fromJson(shipment))
              .toList();
        } else {
          errorMessage.value = 'فشل في جلب البيانات';
        }
      },
    );
  }


  String _getShipmentStatusByFilterIndex(int index) {
    switch (index) {
      case 0:
        return '0';
      case 1:
        return '1,2,3,4,5,6';
      case 2:
        return '7';
      case 3:
        return '10';
      case 4:
        return '8,9';
      default:
        return '';
    }
  }


  List<ShipmentModel> get filteredShipments {
    switch (selectedFilterIndex.value) {
      case 0:
        return shipments.where((shipment) => shipment.shipmentStatus == 0).toList();
      case 1:
        return shipments.where((shipment) => [1, 2, 3, 4, 5, 6].contains(shipment.shipmentStatus)).toList();
      case 2:
        return shipments.where((shipment) => shipment.shipmentStatus == 7).toList();
      case 3:
        return shipments.where((shipment) => shipment.shipmentStatus == 10).toList();
      case 4:
        return shipments.where((shipment) => [8, 9].contains(shipment.shipmentStatus)).toList();
      default:
        return shipments;
    }
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
