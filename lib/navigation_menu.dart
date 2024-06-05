import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

import 'features/home/controller/navigation_controller.dart';
import 'features/home/screen/home_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar.builder(
        height: 70.0,  // Adjust the height here
        itemCount: NavigationController().screens.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? TColors.primary : TColors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.selectedIndex == index
                  ? Icon(
                NavigationController().icons[index],
                size: 22.sp,  // Increase the icon size
                color: color,
              )
                  : Icon(
                    NavigationController().icons[index],
                    size: 24.sp,  // Adjust the inactive icon size
                    color: color,
                  ),
              SizedBox(height: 0.5.h),  // Adjust the spacing between icon and text
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 2.w,),
                child: Text(
                    NavigationController().bottomnavigationbaritems[index],
                    maxLines: 1,
                    style: TextStyle(
                    color: color,
                    fontSize: isActive ? 9.sp : 7.sp,
                    fontFamily: 'Cairo',
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w700),
                    )
              )
            ],
          );
        },
        activeIndex: controller.selectedIndex.value,
        gapWidth: 2.w,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          controller.selectedIndex.value = index;
        },
      )),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

