import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/profile_model.dart';
import '../model/update_profile_model.dart';

class ProfileController extends GetxController {
  var profile = MerchantInfo.empty().obs;
  var isLoading = false.obs;

   TextEditingController nameController=TextEditingController();
   TextEditingController phoneController=TextEditingController();
   TextEditingController businessNameController=TextEditingController();

  final Crud crud = Get.find<Crud>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      '${MerchantAPIKey}profile.php',
      {'user_id': userId.toString()},
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch profile');
      },
          (data) {
        ProfileResponseModel responseModel = ProfileResponseModel.fromJson(data);
        profile.value = responseModel.merchantInfo;
        nameController.text = profile.value.name;
        phoneController.text = profile.value.phone;
        businessNameController.text = profile.value.businessName;
      },
    );
  }
  void editProfile(String name, String phone, String businessName) async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      '${MerchantAPIKey}edit_profile.php',
      {
        'user_id': userId.toString(),
        'name': nameController.text ,
        'phone': phoneController.text,
        'business_name':  businessNameController.text,
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to update profile');
        print(profile.value.name);
        print(profile.value.name);

      },
          (data) {
        EditProfileResponseModel responseModel = EditProfileResponseModel.fromJson(data);
        if (responseModel.status) {
          Get.snackbar('Success', responseModel.message);
          fetchProfile();
        } else {
          Get.snackbar('Error', responseModel.message);
        }
      },
    );
  }

}
