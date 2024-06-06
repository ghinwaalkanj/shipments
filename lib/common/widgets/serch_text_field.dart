import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class TSearchFormField extends StatelessWidget {
  const TSearchFormField({
    super.key,
    required this.hintText,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.controller,
  });

  final String hintText;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            Icon(
              icon,
              color: TColors.darkerGrey,
            ),
            CustomSizedBox.itemSpacingHorizontal(),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: TColors.darkGrey.withOpacity(0.7),
                    fontFamily: 'Cairo',
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 1.35.h),
                ),
                style: TextStyle(
                  color: TColors.darkGrey,
                  fontFamily: 'Cairo',
                  fontSize: 11.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
