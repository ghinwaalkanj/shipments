
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CircularContainer extends StatelessWidget {
   CircularContainer({
    super.key, required this.icon, this.color, this.onTap,
  });
   final IconData icon;
   final Color? color;
   final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
