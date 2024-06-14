import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../core/integration/crud.dart';
import '../../../core/integration/statusrequest.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/colors.dart';
import '../../home/controller/home_controller.dart';
import '../../../navigation_menu.dart';
import '../model/AddressModel.dart';
import '../model/cities.php.dart';

class AddressController extends GetxController {
  var cities = <City>[].obs;
  var isLoading = false.obs;
  var searchlist = [].obs;
  var addresses = <Address>[].obs;
  var statusRequest = StatusRequest.loading.obs;

  final Crud crud = Get.find<Crud>();
  final HomeController controller = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }


  void fetchCities() async {
    isLoading.value = true;
    var response = await crud.getData(
        'https://talabea.000webhostapp.com/merchant/address/get_cities.php',
        {});
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch cities');
      },
          (data) {
        if (data['status']) {
          cities.value =
          List<City>.from(data['data'].map((city) => City.fromJson(city)));
        } else {
          Get.snackbar('Error', 'Failed to fetch cities');
        }
      },
    );
  }

  Future<void> addAddress({
    required String details,
    required String cityId,
    required String lat,
    required String long,
  }) async {
    if (details.isEmpty || cityId.isEmpty || lat.isEmpty || long.isEmpty) {
      Get.snackbar('Error', 'يرجى ملء جميع الحقول');
      return;
    }

    var userId = await SharedPreferencesHelper.getInt('user_id');

    isLoading.value = true;
    var response = await crud.postData(
      'https://talabea.000webhostapp.com/merchant/address/add.php',
      {
        'user_id': userId.toString(),
        'details': details,
        'city': cityId,
        'lat': lat,
        'long': long,
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to add address');
      },
          (data) {
        if (data['status']) {
          Get.to(NavigationMenu());
          Get.snackbar(
            'نجاح',
            'تمت إضافة العنوان بنجاح',
            backgroundColor: TColors.primary,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.check_circle_outline, color: Colors.white),
            duration: Duration(seconds: 5),
          );
          controller.fetchHomeData();
        } else {
          Get.snackbar('Error', data['message']);
        }
      },
    );
  }

  void getsearch(String query) async {
    var url = "https://photon.komoot.io/api/?q=$query&limit=5";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      List features = responsebody['features'];

      if (features.isNotEmpty) {
        statusRequest.value = StatusRequest.success;
        searchlist.value = features;
      } else {
        searchlist.value = [];
      }
    } else {
      searchlist.value = [];
    }

    update();
  }


  void fetchAddresses() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      'https://talabea.000webhostapp.com/merchant/address/view.php',
      {'user_id': userId.toString()},
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch addresses');
      },
          (data) {
        if (data['status']) {
          var addressList = (data['all_addresses'] as List)
              .map((address) => Address.fromJson(address))
              .toList();
          addresses.value = addressList;
        } else {
          Get.snackbar('Error', data['message']);
        }
      },
    );
  }

  Future<void> setDefaultAddress(String addressId) async {
    var userId = await SharedPreferencesHelper.getInt('user_id');

    isLoading.value = true;
    var response = await crud.postData(
      'https://talabea.000webhostapp.com/merchant/address/set_default_address.php',
      {
        'user_id': userId.toString(),
        'address_id': addressId,
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to set default address');
      },
          (data) {
        if (data['status']) {
          Get.snackbar(
            'نجاح',
            'تم تعيين العنوان الافتراضي بنجاح',
            backgroundColor: TColors.primary,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.check_circle_outline, color: Colors.white),
            duration: Duration(seconds: 5),
          );
          fetchAddresses(); // Refresh the address list
          controller.fetchHomeData();
        } else {
          Get.snackbar('Error', data['message']);
        }
      },
    );
  }

}
