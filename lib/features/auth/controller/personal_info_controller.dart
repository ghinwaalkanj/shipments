import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/integration/statusrequest.dart';
import 'package:shipment_merchent_app/features/auth/screen/id_upload_screen.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/personal_info_model.dart';

class PersonalInfoController extends GetxController {

  var fullName = ''.obs;
  var phoneNumber = ''.obs;
  var nationalId = ''.obs;
  var businessName = ''.obs;
  var gender = ''.obs;
  var isFormValid = false.obs;
  var isLoading = false.obs;

  late TextEditingController fullNameController;
  late TextEditingController idController;
  late TextEditingController shopController;
  late TextEditingController genderController;

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      fullName.value = Get.arguments['name'] ?? '';
      nationalId.value = Get.arguments['national_id'] ?? '';
      businessName.value = Get.arguments['business_name'] ?? '';
      gender.value = Get.arguments['gender'] ?? '';
      validateForm();
    }

    fullNameController = TextEditingController(text: fullName.value);
    idController = TextEditingController(text: nationalId.value);
    shopController = TextEditingController(text: businessName.value);
    genderController = TextEditingController(text: gender.value);
  }

  void validateForm() {
    if (fullName.value.isNotEmpty &&
        nationalId.value.isNotEmpty &&
        businessName.value.isNotEmpty &&
        gender.value.isNotEmpty) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  void submitPersonalInfo() async {
    if (fullName.value.isEmpty ||
        nationalId.value.isEmpty ||
        businessName.value.isEmpty ||
        gender.value.isEmpty) {
      Get.snackbar('Error', 'عبئ كل المعلومات');
      return;
    }

    isLoading.value = true;
    var token = await SharedPreferencesHelper.getString('token');
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      '${MerchantAPIKey}auth/personal_info.php',
      {
        'token': token,
        'user_id': userId.toString(),
        'name': fullName.value,
        'national_id': nationalId.value,
        'business_name': businessName.value,
        'gender': gender.value,
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to update profile');
      },
          (data) {
        try {
          PersonalInfoResponseModel responseModel = PersonalInfoResponseModel.fromJson(data);
          if (responseModel.status) {
            Get.snackbar('Success', responseModel.message ?? 'Profile updated successfully');
            Get.to(IDUploadScreen());
          } else {
            Get.snackbar('Error', responseModel.message ?? 'Unknown error');
          }
        } catch (e) {
          Get.snackbar('Error', 'Error parsing response');
        }
      },
    );
  }
}
