import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/personalization/screens/profile_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/custom_list_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/paddings.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/custom_shapes/containers/common_container.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: 'الإعدادات',
        showBackArrow: false,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            CustomSizedBox.itemSpacingVertical(),
            SectionTitle(title: 'الحساب'),
            CommonContainer(
              height: 15.h,
              width: 15.h,
              child: Column(
                children: [
                  CustomListTile(
                    title: 'المعلومات الشخصية',
                    icon: Iconsax.profile_circle,
                    onTap: () {
                      Get.to(ProfileScreen());
                    },
                  ),
                  CustomListTile(
                    title: 'العناوين',
                    icon: Iconsax.map,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            CustomSizedBox.itemSpacingVertical(),
            SectionTitle(title: 'التفضيلات'),
            CommonContainer(
              height: 15.h,
              width: 15.w,
              child: Column(
                children: [
                  CustomListTile(
                    title: 'الوضع الليلي',
                    icon: Iconsax.moon,
                    trailing: Switch(
                      activeColor: TColors.primary,
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  CustomListTile(
                    title: 'الإشعارات',
                    icon: Iconsax.notification,
                    trailing: Switch(
                      activeColor: TColors.primary,
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            CustomSizedBox.itemSpacingVertical(),
            SectionTitle(title: 'معلومات عامة'),
            CommonContainer(
              height: 15.h,
              width: 15.w,
              child: Column(
                children: [
                  CustomListTile(
                    title: 'حول التطبيق',
                    icon: Icons.info_outline_rounded,
                    onTap: () {},
                  ),
                  CustomListTile(
                    title: 'سياسة الخصوصية',
                    icon: Icons.privacy_tip_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

