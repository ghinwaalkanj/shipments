import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/common_container.dart';
import 'package:shipment_merchent_app/utils/constants/paddings.dart';
import 'package:sizer/sizer.dart';

import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/serch_text_field.dart';
import '../../../utils/constants/colors.dart';

class ShipmentScreen extends StatelessWidget {
  ShipmentScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'الشحنات',
        showBackArrow: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    TSearchFormField(
                      hintText: 'ابحث عن الشحنة',
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CircularContainer(
                      icon: Icons.qr_code_scanner,
                      color: TColors.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    _buildFilterButton(Iconsax.box, 'بانتظار قبولها'),
                    _buildFilterButton(Iconsax.box, 'قيد التوصيل'),
                    _buildFilterButton(Iconsax.box, 'الراجعة'),
                    _buildFilterButton(Iconsax.box, 'المكتملة'),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Stack(
                children: [
                  // الخلفية
                  Container(
                    height: 60.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      color: TColors.white,
                    ),
                  ),
                  // قائمة العناصر
                  Positioned.fill(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0), // يمكنك ضبط الحشوة حسب الحاجة
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return _buildShipmentCard();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(IconData icon, String label, {bool isActive = false}) {
    return Padding(
      padding:  EdgeInsets.only(right: 2.w),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: isActive ? TColors.primary : TColors.grey.withOpacity(0.5),
            radius: 4.h,
            child: Icon(icon, color: isActive ? Colors.white : TColors.black, size: 4.h),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style:CustomTextStyle.greyTextStyle.apply(color: TColors.black,fontSizeFactor: 0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'لابتوب أسوس، فيفو بوك',
                  style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.9),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '13578484646464#',
                  style: CustomTextStyle.greyTextStyle,
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Icon(Iconsax.location, size: 12.sp, color: TColors.primary),
                    SizedBox(width: 1.w),
                    Text(
                      'دمشق - البحصة',
                      style: CustomTextStyle.greyTextStyle.apply(fontSizeFactor: 0.8),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    Icon(Iconsax.calendar, size: 12.sp, color: TColors.primary),
                    SizedBox(width: 1.w),
                    Text(
                      '25/05/2024',
                      style: CustomTextStyle.greyTextStyle.apply(fontSizeFactor: 0.8),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
