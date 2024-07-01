import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  final Crud crud = Get.find<Crud>();


  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  fetchNotifications() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');

    var response = await crud.postData(
      NotificationsEndpoint,
      {'user_id': userId.toString()},
      {},
    );

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
        var jsonData = data;
        if (jsonData['status']) {
          var notificationList = jsonData['notifications'] as List;
          notifications.value = notificationList
              .map((notification) => NotificationModel.fromJson(notification))
              .toList()
              .reversed
              .toList();
        } else {
          Get.snackbar('Error', 'Failed to fetch notifications');
        }
      },
    );

    isLoading.value = false;
  }



  Map<String, List<NotificationModel>> getNotificationsByDate() {
    Map<String, List<NotificationModel>> notificationsByDate = {};
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    notifications.forEach((notification) {
      String date = dateFormat.format(notification.date);
      if (date == dateFormat.format(DateTime.now())) {
        date = 'اليوم';
      } else if (date ==
          dateFormat.format(DateTime.now().subtract(Duration(days: 1)))) {
        date = 'أمس';
      }
      if (!notificationsByDate.containsKey(date)) {
        notificationsByDate[date] = [];
      }
      notificationsByDate[date]!.add(notification);
    });

    return notificationsByDate;
  }
}
