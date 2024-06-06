import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/serch_text_field.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/shimpments_controller.dart';
import '../controller/shipment_controller.dart';

class ShipmentScreen extends StatelessWidget {
  final ShipmentsController controller = Get.put(ShipmentsController());

  ShipmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'الشحنات',
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    FilterButton(icon: Iconsax.box, label: 'بانتظار قبولها', index: 0, ),
                    FilterButton(icon: Iconsax.box, label: 'قيد التوصيل', index: 1, ),
                    FilterButton(icon: Iconsax.box, label: 'الراجعة', index: 2, ),
                    FilterButton(icon: Iconsax.box, label: 'المكتملة', index: 3,),
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
                      padding: EdgeInsets.all(5.w),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 6.w),
                          child: Container(
                            height: 22.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: TColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: TColors.black.withOpacity(0.25),
                                  blurRadius: 8,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("assets/images/QTPTOV1s6VQ8saoWXpPGQuvkkEGOlzw9qBhRDUDf 1.png"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'لابتوب أسوس، فيفو بوك',
                                          style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.7, fontWeightDelta: 2),
                                        ),
                                      ),
                                      CustomSizedBox.textSpacingVertical(),
                                      Text(
                                        '13578484646464#',
                                        style: CustomTextStyle.greyTextStyle,
                                      ),
                                      CustomSizedBox.textSpacingVertical(),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage('assets/images/Subtract (1).png'),
                                            height: 5.h,
                                            width: 5.w,
                                          ),
                                          SizedBox(width: 2.w,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'دمشق - البحصة',
                                                style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.6),
                                              ),
                                              Text(
                                                '25/05/2024',
                                                style: CustomTextStyle.greyTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 2.w),
                                        child: Image(image: AssetImage("assets/images/Line 15.png"), height: 2.5.h, width: 1.2.w),
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage('assets/images/Subtract (2).png'),
                                            height: 5.h,
                                            width: 5.w,
                                          ),
                                          SizedBox(width: 2.w,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'دمشق - البحصة',
                                                style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.6),
                                              ),
                                              Text(
                                                '25/05/2024',
                                                style: CustomTextStyle.greyTextStyle,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
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

  Widget FilterButton({required IconData icon, required String label, required int index}) {
    final ShipmentsController controller = Get.put(ShipmentsController());
    return GestureDetector(
    onTap: () {
        controller.setSelectedFilterIndex(index);
      },
      child: Obx(
            () {
          bool isActive = controller.selectedFilterIndex.value == index;
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
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
                  style: CustomTextStyle.greyTextStyle.apply(color: isActive ? TColors.primary : TColors.black, fontSizeFactor: 0.8),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
