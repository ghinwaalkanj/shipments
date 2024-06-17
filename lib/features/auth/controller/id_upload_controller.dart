import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:sizer/sizer.dart';
import '../../../core/services/storage_service.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';
import '../model/id_upload_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class IDUploadController extends GetxController {
  var isLoading = false.obs;
  var idFrontImage = File('').obs;
  var idBackImage = File('').obs;
  var idFrontImageUrl = ''.obs;
  var idBackImageUrl = ''.obs;
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences prefs;

  final Crud crud = Get.find<Crud>();

  void setInitialImages(String? frontImageUrl, String? backImageUrl) {
    if (frontImageUrl != null) {
      idFrontImageUrl.value = frontImageUrl;
    }
    if (backImageUrl != null) {
      idBackImageUrl.value = backImageUrl;
    }
  }

  void showImagePicker(BuildContext context, bool isFront) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: TColors.primary,
                    ),
                    title: Text(
                      'اختر من الاستديو',
                      style: TextStyle(
                        color: TColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.sp,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    onTap: () {
                      pickImage(isFront, ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    color: TColors.primary,
                  ),
                  title: Text(
                    'التقط صورة',
                    style: TextStyle(
                      color: TColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.sp,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  onTap: () {
                    pickImage(isFront, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void pickImage(bool isFront, ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (isFront) {
        idFrontImage.value = File(pickedFile.path);
        idFrontImageUrl.value = '';
      } else {
        idBackImage.value = File(pickedFile.path);
        idBackImageUrl.value = '';
      }
    }
  }

  void uploadIDImages() async {
    if ((idFrontImage.value.path.isEmpty && idFrontImageUrl.value.isEmpty) ||
        (idBackImage.value.path.isEmpty && idBackImageUrl.value.isEmpty)) {
      Get.snackbar(
        'خطأ',
        'يرجى إضافة الصور الأمامية والخلفية',
        backgroundColor: TColors.error,
        colorText: TColors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: TColors.white),
        duration: Duration(seconds: 5),
      );
      return;
    }

    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');

    var frontImage =
        idFrontImage.value.path.isNotEmpty ? idFrontImage.value : null;
    var backImage =
        idBackImage.value.path.isNotEmpty ? idBackImage.value : null;

    var response;
    if (frontImage != null && backImage != null) {
      response = await crud.postFileAndTwoData(
        IDUploadEndpoint,
        {
          'user_id': userId.toString(),
        },
        {},
        frontImage,
        backImage,
      );
    } else {
      response = await crud.postData(
        IDUploadEndpoint,
        {
          'user_id': userId.toString(),
        },
        {},
      );
    }

    isLoading.value = false;

    response.fold(
      (failure) {
        Get.snackbar(
          'خطأ',
          'فشل في رفع صور الهوية',
          backgroundColor: TColors.error,
          colorText: TColors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: TColors.white),
          duration: Duration(seconds: 5),
        );
      },
      (data) async {
        IDUploadResponseModel responseModel =
            IDUploadResponseModel.fromJson(data);
        if (responseModel.status) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isAuth', true);
          FirebaseMessaging.instance.subscribeToTopic("merchant");
          FirebaseMessaging.instance
              .subscribeToTopic("merchant${userId.toString()}");
          Get.to(NavigationMenu());
        } else {
          Get.snackbar(
            'خطأ',
            responseModel.error ?? 'خطأ غير معروف',
            backgroundColor: TColors.error,
            colorText: TColors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: TColors.white),
            duration: Duration(seconds: 5),
          );
        }
      },
    );
  }
}
