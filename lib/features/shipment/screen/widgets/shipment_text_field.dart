import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class ShipmentTextField extends StatelessWidget {
  final String hintText;
  final double? width;
  final IconData icon;

  const ShipmentTextField({
    Key? key,
    required this.hintText,
    required this.icon, this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width:width ,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:CustomTextStyle.greyTextStyle,
          prefixIcon: Icon(
            icon,
            color: TColors.primary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: TColors.grey.withOpacity(0.2),
        ),
      ),
    );
  }
}
