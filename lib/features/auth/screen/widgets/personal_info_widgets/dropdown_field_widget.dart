import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

class DropdownFieldWidget extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;

  const DropdownFieldWidget({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<String>(
        value: value,
        items: ['ذكر', 'أنثى']
            .map((label) => DropdownMenuItem(
          child: Text(
            label,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 11.sp,
              color: TColors.darkGrey,
              fontWeight: FontWeight.w600,
              fontFamily: 'Cairo',
            ),
          ),
          value: label,
        ))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'النوع',
          hintStyle: TextStyle(
            fontSize: 9.sp,
            color: TColors.darkGrey,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
          prefixIcon: IconTheme(
            data: IconThemeData(
              color: TColors.primary,
              size: 24.sp,
            ),
            child: Icon(Icons.male),
          ),
          hintTextDirection: TextDirection.rtl,
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
        ),
        icon: Icon(Icons.arrow_drop_down, textDirection: TextDirection.ltr),
      ),
    );
  }
}
