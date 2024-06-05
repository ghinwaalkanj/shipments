
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class CircularContainer extends StatelessWidget {
   CircularContainer({
    super.key, required this.icon, this.color,
  });
   final IconData icon;
   final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 10.w,
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(2, 0),

          )
        ],
        color:Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon,size: 20.sp,color: color,),
    );
  }
}
