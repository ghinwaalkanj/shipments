import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationShimmar extends StatelessWidget {
  const NotificationShimmar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: ListView.separated(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 8.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.sp),
              color: Colors.grey[300],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 1.5.h,
          );
        },
      ),
    );
  }
}
