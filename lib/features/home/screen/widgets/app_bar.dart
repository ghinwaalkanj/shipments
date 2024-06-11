import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/features/address/map_screen.dart';
import 'package:shipment_merchent_app/features/home/controller/home_controller.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.onTap,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 17.h,
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.h),
                child: title,
              ),
              actions: actions != null
                  ? actions!
                  .map((action) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: action,
              ))
                  .toList()
                  : null,
              elevation: 0,
            ),
            Positioned(
              bottom: 1.h,
              right: 7.w,
              child: Obx(() => Visibility(
                visible: controller.cityName.value.isNotEmpty &&
                    controller.addressDetails.value.isNotEmpty,
                replacement: Row(
                  children: [
                    Text(
                      'أضف عنوانك',
                      style: CustomTextStyle.headlineTextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(() => MapScreen());
                      },
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      '${controller.cityName.value} - ${controller.addressDetails.value}',
                      style: CustomTextStyle.headlineTextStyle,
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(() => MapScreen());
                      },
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(25.h);
}
