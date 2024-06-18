import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class ShipmentTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final bool? isJordanianNumber;
  final int? maxLength;


  ShipmentTextField({
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.onChanged,
    this.keyboardType,
    this.isJordanianNumber,
    this.maxLength,
  });

  @override
  _ShipmentTextFieldState createState() => _ShipmentTextFieldState();
}

class _ShipmentTextFieldState extends State<ShipmentTextField> {
  late FocusNode _focusNode;
  bool _hasFocus = false;
  bool _isValid = true;


  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      maxLength: _hasFocus && widget.isJordanianNumber == true ? widget.maxLength : null,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      textDirection: widget.isJordanianNumber == true ? TextDirection.ltr : TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 10.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          height: 0.2.h,
          fontSize: 10.sp,
          fontFamily: 'Cairo',
        ),
        suffix: widget.isJordanianNumber == true
            ? Text('7 962+ ', style: CustomTextStyle.greyTextStyle)
            : null,
        prefixIcon: Icon(
          widget.icon,
          color: TColors.primary,
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isValid ? TColors.primary : Colors.red,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: _isValid ? TColors.primary : Colors.red,
          ),
        ),
        errorText: _isValid ? null : 'رقم الهاتف يجب أن يكون مكون من 8 أرقام.',

      ),
      onChanged: (value) {
        if (widget.isJordanianNumber == true && value.length <= widget.maxLength!) {
          widget.controller.text = value;
          widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: value.length));
          setState(() {
            _isValid = value.length == widget.maxLength;
          });
          if (widget.isJordanianNumber == true && value.length <= widget.maxLength!) {
            widget.controller.text = value;
            widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: value.length));
          }
          widget.onChanged(value);
        };
        if (widget.onChanged != null) {
          widget.onChanged(value);
        }
      },
    );
  }
}
