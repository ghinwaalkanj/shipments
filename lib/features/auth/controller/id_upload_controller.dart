import 'dart:io';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/integration/statusrequest.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/id_upload_model.dart';

class IDUploadController extends GetxController {
  var isLoading = false.obs;
  var idFrontImage = File('').obs;
  var idBackImage = File('').obs;

  final Crud crud = Get.find<Crud>();

  void uploadIDImages() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postFileAndData(
      '${MerchantAPIKey}auth/id_upload.php',
      {
        'user_id': userId.toString(),
      },
      {},
      idFrontImage.value,
      ///      idBackImage.value,

    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to upload ID images');
      },
          (data) {
        IDUploadResponseModel responseModel = IDUploadResponseModel.fromJson(data);
        if (responseModel.status) {
          Get.snackbar('Success', 'Profile updated successfully');
        } else {
          Get.snackbar('Error', responseModel.error ?? 'Unknown error');
        }
      },
    );
  }
}
