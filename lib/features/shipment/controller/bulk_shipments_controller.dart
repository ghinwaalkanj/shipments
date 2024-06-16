import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBulkShipmentController extends GetxController {
  var currentStep = 1.obs;
  var shipmentForms = <ShipmentFormModel>[].obs;
  var isExpandedList = <bool>[].obs;
  var cities = <City>[].obs;
  var isLoading = false.obs;

  List<TextEditingController> recipientNameControllers = [];
  List<TextEditingController> phoneControllers = [];
  List<TextEditingController> addressControllers = [];
  List<TextEditingController> amountControllers = [];
  List<TextEditingController> notesControllers = [];
  List<RxString> selectedCityOptions = [];

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchCities();
    addShipmentForm();
  }

  void addShipmentForm() {
    shipmentForms.add(ShipmentFormModel());
    isExpandedList.add(false); // Add the new shipment form in collapsed state

    recipientNameControllers.add(TextEditingController());
    phoneControllers.add(TextEditingController());
    addressControllers.add(TextEditingController());
    amountControllers.add(TextEditingController());
    notesControllers.add(TextEditingController());
    selectedCityOptions.add(''.obs);
    shipmentForms.refresh();
    toggleExpansion(shipmentForms.length - 1); // Expand the newly added shipment form
  }

  void toggleExpansion(int index) {
    for (int i = 0; i < isExpandedList.length; i++) {
      if (i == index) {
        isExpandedList[i] = !isExpandedList[i];
      } else {
        isExpandedList[i] = false;
      }
    }
    shipmentForms.refresh();
  }

  void removeShipmentForm(int index) {
    shipmentForms.removeAt(index);
    isExpandedList.removeAt(index);
    recipientNameControllers.removeAt(index);
    phoneControllers.removeAt(index);
    addressControllers.removeAt(index);
    amountControllers.removeAt(index);
    notesControllers.removeAt(index);
    selectedCityOptions.removeAt(index);
    shipmentForms.refresh();
  }

  Future<void> getsearch(String query, int index) async {
    var url = "https://photon.komoot.io/api/?q=$query&limit=5";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      List features = responsebody['features'];

      if (features.isNotEmpty) {
        shipmentForms[index].recipientLat = features[0]['geometry']['coordinates'][1];
        shipmentForms[index].recipientLong = features[0]['geometry']['coordinates'][0];
        shipmentForms[index].cityId = features[0]['properties']['city'];
      }
    } else {
      throw Exception('Failed to fetch lat long');
    }
  }

  void fetchCities() async {
    isLoading.value = true;
    var response = await crud.getData(
      'https://api.wasenahon.com/Kwickly/merchant/address/get_cities.php',
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch cities');
      },
          (data) {
        if (data['status']) {
          cities.value = List<City>.from(data['data'].map((city) => City.fromJson(city)));
        } else {
          Get.snackbar('Error', 'Failed to fetch cities');
        }
      },
    );
  }

  void printShipmentData() {
    for (var form in shipmentForms) {
      print(form.toJson());
    }
  }

  void submitShipments() async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT_HERE'),
      body: jsonEncode(shipmentForms.map((shipment) => shipment.toJson()).toList()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        Get.snackbar('نجاح', 'تم إضافة الشحنات بنجاح');
      } else {
        Get.snackbar('خطأ', 'فشل في إضافة الشحنات');
      }
    } else {
      Get.snackbar('خطأ', 'فشل الاتصال بالخادم');
    }
  }
}

class ShipmentFormModel {
  String recipientName = '';
  String recipientPhone = '';
  String recipientAddress = '';
  String amount = '';
  String notes = '';
  String cityId = '';
  double recipientLat = 0.0;
  double recipientLong = 0.0;

  Map<String, dynamic> toJson() {
    return {
      'recipient_name': recipientName,
      'recipient_phone': recipientPhone,
      'recipient_address': recipientAddress,
      'amount': amount,
      'notes': notes,
      'city_id': cityId,
      'recipient_lat': recipientLat,
      'recipient_long': recipientLong,
    };
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}
