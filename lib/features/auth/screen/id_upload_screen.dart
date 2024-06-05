import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:shipment_merchent_app/features/home/screen/home_screen.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/id_upload_controller.dart';

class IDUploadScreen extends StatelessWidget {
  IDUploadScreen({Key? key}) : super(key: key);

  final IDUploadController controller = Get.put(IDUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 6.5.h,
          left: 6.w,
          right: 6.w,),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'أضف صورة البطاقة الشخصية',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'تأكد من ظهور صورة الوجه الأمامي والخلفي للبطاقة بشكل واضح وصحيح.',
              style: TextStyle(
                fontSize: 10.sp,
                color: TColors.darkGrey,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
            SizedBox(height: 5.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/Subtract.png", // Replace with actual image path
                  height: 20.h,
                ),
                Image.asset(
                  "assets/images/front_id.png", // Replace with actual image path
                  height: 15.h,
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/Subtract.png", // Replace with actual image path
                  height: 20.h,
                ),
                Image.asset(
                  "assets/images/back_id.png", // Replace with actual image path
                  height: 15.h,
                ),
              ],
            ),
            Spacer(),
            TButton(
              text: "متابعة",
              onPressed: () {
                Get.to(NavigationMenu());
              },
            ),
            CustomSizedBox.itemSpacingVertical(),
            TTextButton(text: 'رجوع',onPressed: (){Get.back();},),
            SizedBox(height: 6.5.h),
          ],
        ),
      ),
    );
  }
}
