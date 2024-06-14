import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/device/device_utility.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: TDeviceUtils.getAppBarHeight()*2.5,
          ),
          Stack(
            children: [
              Image(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.38,
                image: AssetImage(image),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Align(
          alignment: Alignment.topRight,
            child: Padding(
              padding:  EdgeInsets.only(right: 11.w),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19.sp,
                  fontFamily: 'Cairo',
                  color: TColors.primary,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              subtitle,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: 'Cairo',
                  color: TColors.grey,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
              //
            ),
          )
        ],
      ),
    );
  }
}
