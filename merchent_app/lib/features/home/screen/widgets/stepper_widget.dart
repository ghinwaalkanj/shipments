import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';

class StepperWidget extends StatelessWidget {
  final int status;

  StepperWidget({required this.status});

  Color getColor(int index) {
    if (status == 0) return Colors.grey;
    if (status >= index) return Color(0xFF008080); // primary color
    return Colors.black;
  }

  bool showShipmentIcon(int index) {
    return status == index;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Row(
            children: [
              if (showShipmentIcon(2))
                Transform.translate(
                  offset: Offset(-15.w, 0),
                  child: Icon(
                    Iconsax.box,
                    color: getColor(2),
                    size: 15.sp,
                  ),
                ),
              if (showShipmentIcon(4))
                Transform.translate(
                  offset: Offset(-27.w, 0),
                  child: Icon(
                    Iconsax.box,
                    color: getColor(2),
                    size: 15.sp,
                  ),
                ),
              if (showShipmentIcon(5))
                Transform.translate(
                  offset: Offset(-39.w, 0),
                  child: Icon(
                    Iconsax.box,
                    color: getColor(2),
                    size: 15.sp,
                  ),
                ),
              if (showShipmentIcon(6))
                Transform.translate(
                  offset: Offset(-51.w, 0),
                  child: Icon(
                    Iconsax.box,
                    color: getColor(2),
                    size: 15.sp,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                status == 0
                    ? 'assets/images/Subtract8.png'
                    : 'assets/images/Subtract3.png',
                height: 3.h,
              ),
              Expanded(
                child: Divider(
                  color: getColor(2),
                  thickness: 2,
                  indent: 10,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(2),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(4),
                  thickness: 2,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(4),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(5),
                  thickness: 2,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(5),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(6),
                  thickness: 2,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(6),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(7),
                  thickness: 2,
                  endIndent: 10,
                ),
              ),
              Image.asset(
                status == 7
                    ? 'assets/images/Subtract10.png'
                    : 'assets/images/Subtract8.png',
                height: 3.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

