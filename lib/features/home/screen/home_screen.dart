import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/curved_rectangular_container.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shipment_merchent_app/features/personalization/screens/notification_screen.dart';
import 'package:shipment_merchent_app/features/home/screen/search_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../../Qr_code/screen/Qr_code_display_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: HomeAppBar(
        title: Text(
          'مكان الاستلام',
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12.sp,
              color: TColors.grey,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TSearchContainer(
                      text: "ابحث عن الشحنة",
                      onTap: () {
                        Get.to(SearchScreen());
                      },
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(QrCodeDisplayScreen());
                      },
                      child: CircularContainer(
                        icon: Icons.qr_code_scanner,
                        color: TColors.primary,
                      ),
                    ),
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(),
                Text(
                  'خدماتنا',
                  style: CustomTextStyle.headlineTextStyle,
                ),
                CustomSizedBox.itemSpacingVertical(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(ShipmentStep1Screen());
                      },
                      child: CurvedRectangular(
                        height: 6.h,
                        color: Color(0xffC1D7C0),
                        text: 'إضافة شحنة',
                        image: 'assets/images/truck.png',
                        textColor: Color(0xff37972B),
                      ),
                    ),
                    CurvedRectangular(
                      height: 6.h,
                      color: Color(0xffC0D5D8),
                      text: 'إضافة منتج',
                      image: 'assets/images/package.png',
                      textColor: Color(0xff14818E),
                    ),
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(),
                Image(
                  image: AssetImage("assets/images/banner.png"),
                ),
                CustomSizedBox.itemSpacingVertical(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الشحنات الحالية',
                      style: CustomTextStyle.headlineTextStyle,
                    ),
                    Text(
                      'الكل',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 10.sp,
                        color: TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: TColors.primary,
                      ),
                    )
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(),
                Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'لينوفو ثينك باد',
                                  style: CustomTextStyle.greyTextStyle,
                                ),
                                CustomSizedBox.textSpacingVertical(),
                                Text(
                                  '123135784846464#',
                                  style: CustomTextStyle.headlineTextStyle
                                      .apply(fontSizeFactor: 0.65.sp),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(QrCodeDisplayScreen());
                              },
                              child: Container(
                                height: 5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffDDCBEF),
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'في الطريق إليك',
                                        style:
                                            CustomTextStyle.greyTextStyle.apply(
                                          color: Color(0xff7F46CD),
                                        ),
                                      ),
                                      Icon(
                                        Icons.qr_code,
                                        color: Color(0xff7F46CD),
                                        size: 14.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        ///TODO:Stepper
                        CustomSizedBox.itemSpacingVertical(),
                        Image(
                          image: AssetImage('assets/images/stepper.png'),
                        ),
                        CustomSizedBox.itemSpacingVertical(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "من",
                                  style: CustomTextStyle.greyTextStyle
                                      .apply(color: TColors.grey),
                                ),
                                CustomSizedBox.textSpacingVertical(),
                                Text(
                                  "دمشق",
                                  style: CustomTextStyle.headlineTextStyle
                                      .apply(fontSizeFactor: 0.65.sp),
                                ),
                                CustomSizedBox.textSpacingVertical(),
                                Text(
                                  "22/4/2023",
                                  style: CustomTextStyle.greyTextStyle
                                      .apply(fontSizeFactor: 0.8.sp),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "إلى",
                                  style: CustomTextStyle.greyTextStyle
                                      .apply(color: TColors.grey),
                                ),
                                CustomSizedBox.textSpacingVertical(),
                                Text(
                                  "طرطوس",
                                  style: CustomTextStyle.headlineTextStyle
                                      .apply(fontSizeFactor: 0.65.sp),
                                ),
                                CustomSizedBox.textSpacingVertical(),
                                Text(
                                  "22/4/2023",
                                  style: CustomTextStyle.greyTextStyle
                                      .apply(fontSizeFactor: 0.8.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
