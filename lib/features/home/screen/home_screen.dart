import 'package:flutter/material.dart';
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
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';

import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../../Qr_code/screen/Qr_code_display_screen.dart';
import '../../Qr_code/screen/Qr_code_scan.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentAdIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentAdIndex < Get.find<HomeController>().ads.length - 1) {
        setState(() {
          _currentAdIndex++;
        });
      } else {
        setState(() {
          _currentAdIndex = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

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
                      GestureDetector(
                          onTap: () {

                          },
                          child: CircleAvatar(
                            radius: 16.5.sp,
                            backgroundColor: TColors.white,
                            child: Image.asset(
                              'assets/images/search_qr.png',
                              height: 3.5.h,
                            ),
                          )),
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
                          Get.snackbar('خطأ',
                              'يرجى تعيين عنوان افتراضي قبل إضافة شحنة جديدة');
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
                      onTap:(){
                        Get.to(BarcodeScanScreen());
                      } ,
                      height: 6.h,
                      color: Color(0xffC0D5D8),
                      text: 'إستلام راجع ',
                      image: 'assets/images/qr_code2.png',
                      textColor: Color(0xff14818E),
                    ),
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(),
                Obx(() => controller.ads.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: controller.ads.length,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: TColors.primary,
                                  borderRadius: BorderRadius.circular(20.sp),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.png',
                                    image: controller.ads[index].imageUrl ?? '',
                                    fit: BoxFit.cover,
                                    width: 85.w,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey,
                                        alignment: Alignment.center,
                                        child: Icon(Icons.error,
                                            color: Colors.red, size: 30.sp),
                                      );
                                    },
                                    placeholderErrorBuilder:
                                        (context, error, stackTrace) {
                                      return SizedBox(); // عرض مؤشر التحميل أثناء التحميل
                                    },
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 10),
                              height: 20.h,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                _currentAdIndex = index;
                              },
                            ),
                          ),
                          CustomSizedBox.itemSpacingVertical(),
                        ],
                      )
                    : Container()),
                Obx(() => controller.shipments.isNotEmpty
                    ? Column(
                        children: [
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
                          Column(
                            children: controller.shipments.map((shipment) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 2.h),
                                height: 30.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.sp),
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
                                                shipment.shipmentContents ?? '',
                                                style: CustomTextStyle
                                                    .greyTextStyle,
                                              ),
                                              CustomSizedBox
                                                  .textSpacingVertical(),
                                              Text(
                                                shipment.shipmentNumber ?? '',
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
                                              Get.to(QrCodeDisplayScreen());
                                            },
                                            child: Container(
                                              height: 5.h,
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                color: Color(0xffDDCBEF),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.sp),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'في الطريق إليك',
                                                      style: CustomTextStyle
                                                          .greyTextStyle
                                                          .apply(
                                                        color:
                                                            Color(0xff7F46CD),
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
                                      CustomSizedBox.itemSpacingVertical(),
                                      // Stepper or progress bar can be added here
                                      CustomSizedBox.itemSpacingVertical(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "من",
                                                style: CustomTextStyle
                                                    .greyTextStyle
                                                    .apply(color: TColors.grey),
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
                                                        fontSizeFactor: 0.8.sp),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "إلى",
                                                style: CustomTextStyle
                                                    .greyTextStyle
                                                    .apply(color: TColors.grey),
                                              ),
                                              CustomSizedBox
                                                  .textSpacingVertical(),
                                              Text(
                                                shipment.recipientCity ?? '',
                                                style: CustomTextStyle
                                                    .headlineTextStyle
                                                    .apply(
                                                        fontSizeFactor:
                                                            0.65.sp),
                                              ),
                                              CustomSizedBox
                                                  .textSpacingVertical(),
                                              Text(
                                                shipment.estimatedDeliveryTime!
                                                    .split(' ')[0],
                                                style: CustomTextStyle
                                                    .greyTextStyle
                                                    .apply(
                                                        fontSizeFactor: 0.8.sp),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      )
                    : Container())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
