import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/services/storage_service.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

   fetchNotifications() async {
    isLoading.value = true;
    var userId = await SharedPreferencesHelper.getInt('user_id');

    var response = await http.post(
      Uri.parse(
          'https://api.wasenahon.com/Kwickly/merchant/get_notifications.php'),
      body: {'user_id': userId.toString()},
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status']) {
        var notificationList = jsonData['notifications'] as List;
        notifications.value = notificationList
            .map((notification) => NotificationModel.fromJson(notification))
            .toList();
      }
    } else {
      Get.snackbar('Error', 'Failed to fetch notifications');
    }

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
