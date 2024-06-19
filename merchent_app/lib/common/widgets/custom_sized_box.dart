import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSizedBox {
  static SizedBox itemSpacingVertical({double height = 2}) {
    return SizedBox(height: height.h);}

  static SizedBox textSpacingVertical({double height = 1}) {
    return SizedBox(height: height.h);}

    static SizedBox itemSpacingHorizontal({double width = 5}) {
      return SizedBox(width: width.w);
    }


  }

