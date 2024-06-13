import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/curved_rectangular_container.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:shipment_merchent_app/features/home/screen/qrsearch_screen.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/home_shimmer.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/stepper_widget.dart';
import 'package:shipment_merchent_app/features/home/screen/search_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/shipment/screen/tracking_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../../Qr_code/screen/Qr_code_display_screen.dart';
import '../../Qr_code/screen/Qr_code_scan.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'هل تود الخروج من التطبيق؟',
          style: CustomTextStyle.headlineTextStyle.apply(
            color: TColors.primary,
            fontSizeFactor: 1.1,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'لا',
              style: CustomTextStyle.headlineTextStyle.apply(
                color: TColors.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'نعم',
              style: CustomTextStyle.headlineTextStyle.apply(
                color: TColors.primary,
              ),
            ),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    int _currentAdIndex = 0;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
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
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child:HomeShimmerWidget());
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
                                      image:
                                      controller.ads[index].imageUrl ?? '',
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
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}



