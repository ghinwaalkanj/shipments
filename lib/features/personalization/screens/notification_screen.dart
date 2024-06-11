import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/notification_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          child: ListView(
            children: [
              SectionTitle(title: 'اليوم'),
              NotificationTile(
                message: 'تم سحب \$300 من المحفظة',
                icon: Icons.money_outlined,
              ),
              NotificationTile(
                message: 'جاري توصيل الشحنة رقم #16184946',
                icon: Icons.local_shipping_outlined,
              ),
              NotificationTile(
                message: 'تم التبليغ عن الشحنة رقم #16184946',
                icon: Icons.info_outline,
              ),
              SectionTitle(title: 'أمس'),
              NotificationTile(
                message: 'تم سحب \$300 من المحفظة',
                icon: Icons.money_outlined,
              ),
              NotificationTile(
                message: 'جاري توصيل الشحنة رقم #16184946',
                icon: Icons.local_shipping_outlined,
              ),
              NotificationTile(
                message: 'تم التبليغ عن الشحنة رقم #16184946',
                icon: Icons.info_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

