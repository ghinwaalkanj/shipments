import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../features/shipment/screen/bulk_shipments_screen.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    Key? key,
    required this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  }) : super(key: key);

  final String title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 17.h,
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Stack(
            children: [
              Positioned(
                bottom: 5.h,
                child: Row(
                  children: [
                    if (showBackArrow)
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back,
                          size: 21.sp,
                        ),
                      ),
                    if (!showBackArrow)
                      SizedBox(width: 2.w),
                    CustomSizedBox.itemSpacingHorizontal(),
                    Text(
                      title,
                      style: CustomTextStyle.headlineTextStyle
                          .apply(fontWeightDelta: 2),
                    ),
                  ],
                ),
              ),
              if (showSwitch)
                Positioned(
                  bottom: 1.h,
                  left: 0,
                  child: Column(
                    children: [
                      Text(
                        'Bulk Orders',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: switchValue,
                        activeColor: TColors.primary,
                        onChanged: (value) {
                          if (value) {
                            Get.to(() => BulkShipmentsScreen());
                          }
                          if (onSwitchChanged != null) {
                            onSwitchChanged!(value);
                          }
                        },
                      ),
                    ],
                  ),
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
