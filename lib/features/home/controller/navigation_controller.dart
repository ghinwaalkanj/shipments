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
  final outlineIcons = [
    Iconsax.setting,
    Iconsax.notification_bing4,
    Iconsax.truck_fast,
    Iconsax.home_24,
  ];
  List bottomnavigationbaritems = [
    'الإعدادات',
    'الإشعارات',
    'الشحنات',
    'الرئيسية',
  ];
}
