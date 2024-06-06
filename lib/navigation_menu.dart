import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'features/home/controller/navigation_controller.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(() => Container(
        decoration: BoxDecoration(
          color: Colors.white,  // Ensure this matches the bottom navigation background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: AnimatedBottomNavigationBar.builder(
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
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Text(
                      NavigationController().bottomnavigationbaritems[index],
                      maxLines: 1,
                      style: TextStyle(
                        color: color,
                        fontSize: isActive ? 9.sp : 7.sp,
                        fontFamily: 'Cairo',
                        fontWeight: isActive ? FontWeight.bold : FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              );
            },
            activeIndex: controller.selectedIndex.value,
            gapWidth: 2.w,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
          ),
        ),
      )),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
