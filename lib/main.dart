import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';
import 'package:shipment_merchent_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:shipment_merchent_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:sizer/sizer.dart';
import 'core/integration/crud.dart';
import 'core/services/InternetController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'features/personalization/controller/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AwesomeNotifications().initialize(
      'resource://drawable/ic_stat_icon',
      [
        NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.green,
            ledColor: Colors.green)
      ],
      debug: true);

  NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'alerts',
        title: message.notification!.title!,
        body: message.notification!.body!,
      ),
    );
  });

  Get.put(Crud());
  final OnBoardingController onBoardingController =
  Get.put(OnBoardingController());
  final InternetController internetController = Get.put(InternetController());
  final SettingsController settingsController = Get.put(SettingsController());
  await onBoardingController.checkIfFirstTime();

  // Set the default status bar color
  FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

  runApp(MyApp(
      onBoardingController: onBoardingController,
      internetController: internetController,
      settingsController: settingsController));
}

class MyApp extends StatelessWidget {
  final OnBoardingController onBoardingController;
  final InternetController internetController;
  final SettingsController settingsController;

  MyApp({required this.onBoardingController, required this.internetController, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        internetController.checkConnection(); // Initial check
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: onBoardingController.prefs.getBool('isAuth') == true
              ? NavigationMenu()
              : onBoardingController.prefs.getBool('isFirstTime') == false
              ? LoginScreen()
              : OnBoardingScreen(),

        );
      },
    );
  }
}
