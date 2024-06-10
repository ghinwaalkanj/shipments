import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants/colors.dart';

class TTextField extends StatelessWidget {
  final String hintText;
  final Icon suffixIcon;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;



  const TTextField({
    Key? key,
    required this.hintText,
    required this.suffixIcon,
    required this.controller,
    this.prefixIcon, this.keyboardType, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.w,
      child: TextField(
        style:TextStyle(
          fontFamily: 'Cairo',
          fontSize: 11.sp,
        ) ,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            fontSize: 9.sp,
            color: TColors.darkGrey,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: TColors.primary, width: 2.0),
            borderRadius: BorderRadius.circular(18.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(18.0),
          ),
          suffixIcon: suffixIcon,
          suffixIconColor: TColors.primary,
          prefixIcon: prefixIcon, // Add the prefixIcon if provided
          errorText: controller.text.isEmpty ? null : null,
        ),
        keyboardType: keyboardType,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
