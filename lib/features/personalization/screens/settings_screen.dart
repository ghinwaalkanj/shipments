import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/personalization/screens/profile_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/custom_list_tile.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';


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
            padding: EdgeInsets.only(top:0,left: 4.w,right: 4.w,bottom: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.itemSpacingVertical(),
                const SectionTitle(title: 'الحساب'),
                _buildSettingsSection(
                  context,
                  [
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
                      onTap: () {},
                    ),
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(),
                const SectionTitle(title: 'التفضيلات'),
                _buildSettingsSection(
                  context,
                  [
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
                _buildSettingsSection(
                  context,
                  [
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: children
            .map((child) => Column(
                  children: [
                    child,
                    if (children.last != child) Divider(color: TColors.grey),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
