import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/widgets/custom_shapes/containers/icon_container.dart';
import '../../../../../utils/constants/colors.dart';

class NotificationTile extends StatelessWidget {
  final String? title;
  final String message;
  final String? time;
  final IconData icon;

  const NotificationTile({
    Key? key,
    this.title,
    required this.message,
    this.time,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 2.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          IconContainer(icon: icon),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10.sp,
                      color: TColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 1.h),
                ],
                Text(
                  message,
                  style: CustomTextStyle.greyTextStyle, // Use your custom style for message
                ),
              ],
            ),
          ),
          if (time != null)
            Text(
              time!,
              style: CustomTextStyle.primaryTextStyle, // Use your custom style for time
            ),
        ],
      ),
    );
  }
}
