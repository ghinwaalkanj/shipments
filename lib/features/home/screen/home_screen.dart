import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:shipment_merchent_app/features/home/screen/qrsearch_screen.dart';
import 'package:shipment_merchent_app/features/home/screen/search_screen.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/home_shimmer.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/stepper_widget.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';

import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/custom_shapes/containers/curved_rectangular_container.dart';
import '../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../../Qr_code/screen/Qr_code_display_screen.dart';
import '../../Qr_code/screen/Qr_code_scan.dart';
import '../../shipment/screen/shipment1_screen.dart';
import '../../shipment/screen/tracking_screen.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final RxInt _currentAdIndex = 0.obs; // تعديل هنا

    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (controller.ads.isNotEmpty) {
        _currentAdIndex.value = (_currentAdIndex.value + 1) % controller.ads.length;
      }
    });

    return WillPopScope(
      onWillPop: () => controller.onWillPop(context),
      child: Scaffold(
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
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.fetchHomeData();
              },
              color: TColors.primary,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),  // هذا يضمن أن الـ Scroll view دائماً قابلة للتمرير
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 90.h,  // تأكد من أن الـ Scroll view يحتل الحد الأدنى من الارتفاع
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: HomeShimmerWidget());
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
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
                                CircularContainer(
                                  onTap: () {
                                    Get.to(BarcodeSearchScreen());
                                  },
                                  icon: Icons.qr_code_scanner,
                                  color: TColors.primary,
                                ),
                              ],
                            ),
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
                              CurvedRectangular(
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
                                height: 6.h,
                                color: Color(0xffC1D7C0),
                                text: 'إضافة شحنة',
                                image: 'assets/images/truck.png',
                                textColor: Color(0xff37972B),
                              ),
                              CurvedRectangular(
                                onTap: () {
                                  Get.to(BarcodeScanScreen());
                                },
                                height: 6.h,
                                color: Color(0xffC0D5D8),
                                text: 'إستلام راجع ',
                                image: 'assets/images/qr_code2.png',
                                textColor: Color(0xff14818E),
                              ),
                            ],
                          ),
                          CustomSizedBox.itemSpacingVertical(),
                          if (controller.ads.isNotEmpty)
                            Column(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: TColors.primary,
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: Obx(() {
                                      final imageUrl = controller.ads[_currentAdIndex.value].imageUrl ?? '';
                                      return ImageFade(
                                        image: CachedNetworkImageProvider(imageUrl),
                                        duration: const Duration(milliseconds: 900),
                                        syncDuration: const Duration(milliseconds: 150),
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        placeholder: Container(
                                          color: const Color(0xFFCFCDCA),
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.photo, color: Colors.white30, size: 128.0),
                                        ),
                                        loadingBuilder: (context, progress, chunkEvent) =>
                                            Center(child: CircularProgressIndicator(value: progress)),
                                        errorBuilder: (context, error) => Container(
                                          color: const Color(0xFF6F6D6A),
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.warning, color: Colors.black26, size: 128.0),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                CustomSizedBox.itemSpacingVertical(),
                              ],
                            ),
                          if (controller.shipments.isNotEmpty)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الشحنات الحالية',
                                      style: CustomTextStyle.headlineTextStyle,
                                    ),
                                  ],
                                ),
                                CustomSizedBox.itemSpacingVertical(),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: controller.shipments.map((shipment) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 2.w),
                                        child: GestureDetector(
                                          onTap: (){
                                            Get.to(TrackingScreen(shipmentId:
                                            shipment.shipmentId!
                                            ));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 2.h),
                                            height: 30.h,
                                            width: 90.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(15.sp),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.h, horizontal: 5.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            shipment.shipmentContents ??
                                                                '',
                                                            style: CustomTextStyle
                                                                .greyTextStyle,
                                                          ),
                                                          CustomSizedBox
                                                              .textSpacingVertical(),
                                                          Text(
                                                            shipment.shipmentNumber ??
                                                                '',
                                                            style: CustomTextStyle
                                                                .headlineTextStyle
                                                                .apply(
                                                                fontSizeFactor:
                                                                0.65.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (shipment
                                                              .shipmentStatus ==
                                                              3) {
                                                            Get.to(QrCodeDisplayScreen(
                                                                shipmentNumber:
                                                                shipment
                                                                    .shipmentNumber!));
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 30.w,
                                                          decoration: BoxDecoration(
                                                            color: TColors.primary,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                14.sp),
                                                          ),
                                                          child: Center(
                                                            child: FittedBox(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      controller
                                                                          .getShipmentStatusText(
                                                                          shipment
                                                                              .shipmentStatus!),
                                                                      style: CustomTextStyle
                                                                          .greyTextStyle
                                                                          .apply(
                                                                        color: controller
                                                                            .getShipmentStatusColor(
                                                                            shipment
                                                                                .shipmentStatus!),
                                                                      ),
                                                                    ),
                                                                    Icon(
                                                                      controller
                                                                          .getShipmentStatusIcon(
                                                                          shipment
                                                                              .shipmentStatus!),
                                                                      color: controller
                                                                          .getShipmentStatusColor(
                                                                          shipment
                                                                              .shipmentStatus!),
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
                                                  CustomSizedBox.itemSpacingVertical(
                                                      height: 3),
                                                  StepperWidget(
                                                    status: shipment.shipmentStatus!,
                                                  ),
                                                  CustomSizedBox
                                                      .itemSpacingVertical(),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "من",
                                                            style: CustomTextStyle
                                                                .greyTextStyle
                                                                .apply(
                                                                color:
                                                                TColors.grey),
                                                          ),
                                                          CustomSizedBox
                                                              .textSpacingVertical(),
                                                          Text(
                                                            shipment.fromCityName ??
                                                                '',
                                                            style: CustomTextStyle
                                                                .headlineTextStyle
                                                                .apply(
                                                                fontSizeFactor:
                                                                0.65.sp),
                                                          ),
                                                          CustomSizedBox
                                                              .textSpacingVertical(),
                                                          Text(
                                                            shipment.shipmentCreatedAt!
                                                                .split(' ')[0],
                                                            style: CustomTextStyle
                                                                .greyTextStyle
                                                                .apply(
                                                                fontSizeFactor:
                                                                0.8.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "إلى",
                                                            style: CustomTextStyle
                                                                .greyTextStyle
                                                                .apply(
                                                                color:
                                                                TColors.grey),
                                                          ),
                                                          CustomSizedBox
                                                              .textSpacingVertical(),
                                                          Text(
                                                            shipment.recipientCity ??
                                                                '',
                                                            style: CustomTextStyle
                                                                .headlineTextStyle
                                                                .apply(
                                                                fontSizeFactor:
                                                                0.65.sp),
                                                          ),
                                                          CustomSizedBox
                                                              .textSpacingVertical(),
                                                          Text(
                                                            shipment
                                                                .estimatedDeliveryTime!
                                                                .split(' ')[0],
                                                            style: CustomTextStyle
                                                                .greyTextStyle
                                                                .apply(
                                                                fontSizeFactor:
                                                                0.8.sp),
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
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                          else Column(
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
                                                      'أضف شحنتك الأولى',
                                                      style: CustomTextStyle.greyTextStyle,
                                                    ),
                                                    CustomSizedBox.textSpacingVertical(),
                                                    Text(
                                                      'استفد من خدماتنا الممتازة',
                                                      style: CustomTextStyle.headlineTextStyle.apply(
                                                        fontSizeFactor: 0.65.sp,
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
                                            StepperWidget(
                                              status: 7,
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
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
