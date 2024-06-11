import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/features/personalization/screens/notification_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/settings_screen.dart';
import '../../shipment/screen/shipments_screen.dart';
import '../screen/home_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 3.obs;
  final screens = [
    SettingsScreen(),
    NotificationScreen(),
    ShipmentScreen(),
    HomeScreen(),
  ];
  final icons = [
    Icons.settings_outlined,
    Icons.notifications_none_outlined,
    Iconsax.truck,
    Icons.home_outlined,
  ];

  List bottomnavigationbaritems = [
    'الإعدادات',
    'الإشعارات',
    'الشحنات',
    'الرئيسية',
  ];
}
