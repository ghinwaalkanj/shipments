import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shipment_merchent_app/core/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var isNotificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotificationPreference();
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  void toggleNotifications(bool value) async {
    isNotificationsEnabled.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', value);
    if (value) {
      FirebaseMessaging.instance.subscribeToTopic("merchant${await SharedPreferencesHelper.getInt('user_id')}");
      FirebaseMessaging.instance.subscribeToTopic("merchant");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("merchant${await SharedPreferencesHelper.getInt('user_id')}");
      FirebaseMessaging.instance.unsubscribeFromTopic("merchant");
    }
  }

  void _loadNotificationPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? notificationsEnabled = prefs.getBool('notificationsEnabled');
    if (notificationsEnabled != null) {
      isNotificationsEnabled.value = notificationsEnabled;
    }
  }
}
