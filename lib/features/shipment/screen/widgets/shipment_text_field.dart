import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';

class ShipmentTextField extends StatelessWidget {
  final String hintText;
  final double? width;
  final IconData icon;
  final Function(dynamic value)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isJordanianNumber;
  final int maxLength;
  final bool? showCursor;



  const ShipmentTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.width,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.onTap,
    this.isJordanianNumber = false,
    this.maxLength = 8,
     this.showCursor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width: width,
      child: TextFormField(

        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 11.sp,
          fontWeight:FontWeight.normal,
          textBaseline: TextBaseline.alphabetic,
        ),
        keyboardType: keyboardType,
        showCursor: showCursor,
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
        maxLength: isJordanianNumber == true ? maxLength : null,
        buildCounter: (BuildContext context,
            {int? currentLength, int? maxLength, bool? isFocused}) => null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: CustomTextStyle.greyTextStyle,
          prefixIcon: Icon(
            icon,
            color: TColors.primary,
          ),
          suffix: isJordanianNumber == true ? Text('7 962+ ', style: CustomTextStyle.greyTextStyle) : null,
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
