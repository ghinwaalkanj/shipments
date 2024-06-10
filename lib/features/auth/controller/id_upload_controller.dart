import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/core/integration/statusrequest.dart';
import '../../../core/services/storage_service.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/id_upload_model.dart';

class IDUploadController extends GetxController {
  var isLoading = false.obs;
  var idFrontImage = File('').obs;
  var idBackImage = File('').obs;
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences prefs;


  final Crud crud = Get.find<Crud>();

  void pickImage(bool isFront) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isFront) {
        idFrontImage.value = File(pickedFile.path);
      } else {
        idBackImage.value = File(pickedFile.path);
      }
    }
  }

  void uploadIDImages() async {
    if (idFrontImage.value.path.isEmpty || idBackImage.value.path.isEmpty) {
      Get.snackbar('Error', 'يرجى إضافة الصور الأمامية والخلفية');
      return;
    }

    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postFileAndTwoData(
      '${MerchantAPIKey}auth/id_upload.php',
      {
        'user_id': userId.toString(),
      },
      {},
      idFrontImage.value,
      idBackImage.value,
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
          Get.to(NavigationMenu());
          prefs.setBool('isAuth', true);
        } else {
          Get.snackbar('Error', responseModel.error ?? 'Unknown error');
        }
      },
    );
  }

}


