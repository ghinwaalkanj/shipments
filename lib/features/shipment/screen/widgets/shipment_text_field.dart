import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';
//
import '../../../../utils/constants/colors.dart';

class ShipmentTextField extends StatelessWidget {
  final String hintText;
  final double? width;
  final IconData icon;
  final Function(dynamic value)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? showCursor;


  const ShipmentTextField({
    Key? key,
    required this.hintText,
    required this.icon, this.width, this.onChanged, this.controller, this.keyboardType, this.onTap, this.showCursor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width:width ,
      child: TextFormField(
        showCursor: showCursor,
        keyboardType:keyboardType ,
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
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
