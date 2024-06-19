import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/notification_widgets/notification_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/notification_widgets/shimmar_notifications.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../home/controller/home_controller.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final HomeController controller1 = Get.put(HomeController());

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
      body: WillPopScope(
        onWillPop: () => controller1.onWillPop(context),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Obx(() {
              if (controller.isLoading.value) {
                return NotificationShimmar();
              }
              final notificationsByDate = controller.getNotificationsByDate();
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchNotifications();
                },
                color: TColors.primary,
                child: notificationsByDate.isEmpty
                    ? ListView(
                  children: [
                    SizedBox(height: 15.h), // Add some space to center the content
                    Center(
                      child: Image(
                        image: AssetImage(
                            "assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
                        height: 30.h,
                      ),
                    ),
                    CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                    Center(
                      child: Text(
                        'لا توجد إشعارات',
                        style: CustomTextStyle.headlineTextStyle,
                      ),
                    ),
                    CustomSizedBox.textSpacingVertical(),
                    Center(
                      child: Text(
                        'حاول لاحقًا لمعرفة ما إذا كان هناك جديد',
                        style: CustomTextStyle.headlineTextStyle.apply(
                            color: TColors.darkGrey, fontWeightDelta: -5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : ListView(
                  children: notificationsByDate.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: entry.key),
                        ...entry.value.map((notification) {
                          return NotificationTile(
                            title: notification.title ?? 'No Title', // Ensure title is not null
                            message: notification.body ?? 'No Message', // Ensure message is not null
                            time: notification.formattedTime ?? '', // Ensure time is not null
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
      ),
    );
  }
}
