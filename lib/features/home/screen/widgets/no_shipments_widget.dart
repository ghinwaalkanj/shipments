import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';
import 'package:shipment_merchent_app/features/home/controller/home_controller.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/stepper_widget.dart';

class NoShipmentsWidget extends StatelessWidget {
  const NoShipmentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'لا توجد شحنات حالية',
              style: CustomTextStyle.headlineTextStyle,
            ),
          ],
        ),
        CustomSizedBox.itemSpacingVertical(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: GestureDetector(
              onTap: () {
                // Action for the entire container
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 2.h),
                height: 30.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
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
                                'أضف شحنتك',
                                style: CustomTextStyle.greyTextStyle,
                              ),
                              CustomSizedBox.textSpacingVertical(),
                              Text(
                                'استفد من خدماتنا الممتازة',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 10.sp,
                                  color: TColors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.addressDetails.value.isEmpty) {
                                Get.snackbar(
                                  'خطأ',
                                  'يرجى تعيين عنوان افتراضي قبل إضافة شحنة جديدة',
                                  backgroundColor: TColors.primary,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                  margin: EdgeInsets.all(10),
                                  borderRadius: 10,
                                  icon: Icon(Icons.check_circle_outline, color: Colors.white),
                                  duration: Duration(seconds: 5),
                                );
                              } else {
                                Get.to(ShipmentStep1Screen());
                              }
                            },
                            child: Container(
                              height: 5.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: TColors.primary,
                                borderRadius: BorderRadius.circular(14.sp),
                              ),
                              child: Center(
                                child: FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'إضافة شحنة',
                                          style: CustomTextStyle.greyTextStyle.apply(
                                            color: TColors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: TColors.white,
                                          size: 14.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomSizedBox.itemSpacingVertical(height: 3),
                      StepperWidget(status: 7),
                      CustomSizedBox.itemSpacingVertical(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "من",
                                style: CustomTextStyle.greyTextStyle.apply(
                                  color: TColors.grey,
                                ),
                              ),
                              CustomSizedBox.textSpacingVertical(),
                              Text(
                                'مدينتك',
                                style: CustomTextStyle.headlineTextStyle.apply(
                                  fontSizeFactor: 0.65.sp,
                                ),
                              ),
                              CustomSizedBox.textSpacingVertical(),
                              Text(
                                'التاريخ',
                                style: CustomTextStyle.greyTextStyle.apply(
                                  fontSizeFactor: 0.8.sp,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "إلى",
                                style: CustomTextStyle.greyTextStyle.apply(
                                  color: TColors.grey,
                                ),
                              ),
                              CustomSizedBox.textSpacingVertical(),
                              Text(
                                'الوجهة',
                                style: CustomTextStyle.headlineTextStyle.apply(
                                  fontSizeFactor: 0.65.sp,
                                ),
                              ),
                              CustomSizedBox.textSpacingVertical(),
                              Text(
                                'التاريخ',
                                style: CustomTextStyle.greyTextStyle.apply(
                                  fontSizeFactor: 0.8.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
