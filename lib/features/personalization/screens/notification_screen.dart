import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/notification_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  NotificationScreen({super.key});

  IconData _getIconForNotification(String title) {
    switch (title) {
      case 'المندوب قبل شحنتك':
        return Icons.check_circle_outline;
      case 'مشكلة في الشحنة':
        return Icons.error_outline;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: 'الإشعارات',
        showBackArrow: false,
      ),
      backgroundColor: TColors.bg,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final notificationsByDate = controller.getNotificationsByDate();
            return RefreshIndicator(
              onRefresh: () async {
                await controller.fetchNotifications();
              },
              color: TColors.primary,
              child: ListView(
                children: notificationsByDate.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(title: entry.key),
                      ...entry.value.map((notification) {
                        return NotificationTile(
                          message: notification.title,
                          icon: _getIconForNotification(notification.title),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ),
            );
          }),
        ),
      ),
    );
  }
}
