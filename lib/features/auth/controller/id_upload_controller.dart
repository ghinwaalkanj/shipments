import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';
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
      Get.snackbar(
        'خطأ',
        'يرجى إضافة الصور الأمامية والخلفية',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: Colors.white),
        duration: Duration(seconds: 5),
      );
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
        Get.snackbar(
          'خطأ',
          'فشل في رفع صور الهوية',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
      },
          (data) async {
        IDUploadResponseModel responseModel = IDUploadResponseModel.fromJson(data);
        if (responseModel.status) {
          Get.snackbar(
            'نجاح',
            'تم تحديث الملف الشخصي بنجاح',
            backgroundColor: TColors.primary,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.check_circle_outline, color: Colors.white),
            duration: Duration(seconds: 5),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isAuth', true);
          Get.to(NavigationMenu());
        } else {
          Get.snackbar(
            'خطأ',
            responseModel.error ?? 'خطأ غير معروف',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: Colors.white),
            duration: Duration(seconds: 5),
          );
        }
      },
    );
  }

}


