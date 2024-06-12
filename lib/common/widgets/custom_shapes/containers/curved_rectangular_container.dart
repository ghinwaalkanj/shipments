import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:sizer/sizer.dart';

class CurvedRectangular extends StatelessWidget {
  const CurvedRectangular({
    super.key,
    required this.color,
    required this.text,
    required this.image,
    required this.textColor,
    required this.height, this.onTap,
  });

  final Color color;
  final Color textColor;
  final String text;
  final String image;
  final double height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 43.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                image,
              ),
              height: height,
            ),
            CustomSizedBox.itemSpacingVertical(),
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  color: textColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
