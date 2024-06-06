import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/features/personalization/screens/notification_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/settings_screen.dart';
import '../../shipment/screen/shipments_screen.dart';
import '../screen/home_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    HomeScreen(),
    ShipmentScreen(),
    NotificationScreen(),
    SettingsScreen(),
  ];
  final icons = [
    Icons.home_outlined,
    Iconsax.truck,
    Icons.notifications_none_outlined,
    Icons.settings_outlined,
  ];

  List bottomnavigationbaritems = [
    'الرئيسية',
    'الشحنات',
    'الإشعارات',
    'الإعدادات',
  ];
}
