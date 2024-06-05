import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/widgets/custom_shapes/containers/icon_container.dart';
import '../../../../utils/constants/colors.dart';

class NotificationTile extends StatelessWidget {
  final String message;
  final IconData icon;

  const NotificationTile({
    Key? key,
    required this.message,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
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
            child: Text(
              message,
              style: CustomTextStyle.greyTextStyle
            ),
          ),
        ],
      ),
    );
  }
}
