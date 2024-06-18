import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';

class ShipmentTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputType? keyboardType;

  ShipmentTextField({
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.onChanged, this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:keyboardType ,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          height: 0.2.h,
          fontSize: 10.sp,
          fontFamily: 'Cairo',
        ),
        prefixIcon: Icon(icon,color: TColors.primary,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
