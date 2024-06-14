import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/personalization/screens/privacy_policy_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/profile_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/CustomSettingsSection.dart';
import 'package:shipment_merchent_app/features/personalization/screens/about_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/custom_list_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../address/viewAddress.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: 0, left: 4.w, right: 4.w, bottom: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.itemSpacingVertical(),
                const SectionTitle(title: 'الحساب'),
                CustomSettingsSection(
                  children: [
                    CustomListTile(
                      title: 'المعلومات الشخصية',
                      icon: Iconsax.profile_circle,
                      onTap: () {
                        Get.to(() => ProfileScreen());
                      },
                    ),
                    CustomListTile(
                      title: 'العناوين',
                      icon: Iconsax.map,
                      onTap: () {
                        Get.to(() => AddressListScreen());
                      },
                    ),
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(),
                const SectionTitle(title: 'التفضيلات'),
                CustomSettingsSection(
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
                CustomSizedBox.itemSpacingVertical(),
                const SectionTitle(title: 'معلومات عامة'),
                CustomSettingsSection(
                  children: [
                    CustomListTile(
                      title: 'حول التطبيق',
                      icon: Icons.info_outline_rounded,
                      onTap: () {
                        Get.to(AboutAppScreen());
                      },
                    ),
                    CustomListTile(
                      title: 'سياسة الخصوصية',
                      icon: Icons.privacy_tip_outlined,
                      onTap: () {
                        Get.to(PrivacyPolicyScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
