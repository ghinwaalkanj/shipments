import 'package:flutter/cupertino.dart';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.sp),
        child: Container(
          height: 17.h,
          decoration: BoxDecoration(
            color: TColors.white,
          ),
          child: Stack(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: EdgeInsets.only(right: 2.5.w,left: 2.5.w, top: 2.5.h),
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
                bottom: 2.5.h,
                right: 7.w,
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Text(
                      'جاري التحميل',
                      style: CustomTextStyle.headlineTextStyle,
                    );
                  } else {
                    return Visibility(
                      visible: controller.cityName.value.isNotEmpty &&
                          controller.addressDetails.value.isNotEmpty,
                      replacement: GestureDetector(
                        onTap: () {
                          Get.to(() => MapScreen());
                        },
                        child: Row(
                          children: [
                            Text(
                              'أضف عنوانك',
                              style: CustomTextStyle.headlineTextStyle,
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => MapScreen());
                        },
                        child: Row(
                          children: [
                            Text(
                              '${controller.cityName.value} - ${controller.addressDetails.value}',
                              style: CustomTextStyle.headlineTextStyle,
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(25.h);
}
