import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants/colors.dart';

class TTextField extends StatelessWidget {
  final String hintText;
  final Icon? suffixIcon;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool showPrefix;
  final bool isPhone; // إضافة متغير جديد لتحديد ما إذا كان الحقل هو رقم هاتف

  const TTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    required this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    this.showPrefix = true, // الافتراضي هو عرض البادئة
    this.isPhone = false, // الافتراضي ليس رقم هاتف
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.w,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11.sp,
            fontWeight:  isPhone ?FontWeight.bold:FontWeight.normal,
            textBaseline: TextBaseline.alphabetic,
          ),
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
            prefixIcon: prefixIcon,
            prefixIconColor: TColors.primary,
            suffixText: isPhone ? ' 7 962+ ' : null,
            suffixStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            prefixStyle: TextStyle(
              fontSize: 11.sp,
              color: Colors.black,
              fontFamily: 'Cairo',
            ),
          ),
          keyboardType: keyboardType,
          textDirection: isPhone ? TextDirection.ltr : TextDirection.rtl,
          maxLength: isPhone ? 8 : null,
        ),
      ),
    );
  }
}
