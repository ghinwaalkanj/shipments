import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/summarry_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_stepper.dart';
import 'package:sizer/sizer.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../../personalization/screens/widgets/notification_tile.dart';
import '../../personalization/screens/widgets/section_title.dart';
import '../controller/tracking_controller.dart';

class TrackingScreen extends StatelessWidget {
  final int shipmentId;

  const TrackingScreen({required this.shipmentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrackingController controller =
        Get.put(TrackingController(shipmentId: shipmentId));

    return Scaffold(
      appBar: TAppBar(
        title: 'متابعة الشحنة',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: FutureBuilder(
        future: controller.setCustomMarkerIcons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: TColors.primary,
            ));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.onMapCreated;
                await controller.fetchShipmentDetails();
              },
              color: TColors.primary,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!controller.isSuccess.value) {
                        return Center(
                            child: Text('Failed to load shipment details'));
                      }
                      final recipientInfo = controller.recipientInfo.value;
                      final merchantInfo = controller.merchantInfo.value;
                      return GoogleMap(
                        onMapCreated: controller.onMapCreated,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(recipientInfo['lat']),
                            double.parse(recipientInfo['long']),
                          ),
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('shipment-location'),
                            position: LatLng(
                              double.parse(recipientInfo['lat']),
                              double.parse(recipientInfo['long']),
                            ),
                            icon: controller.recipentCustomIcon,
                            infoWindow: InfoWindow(title: 'Shipment Location'),
                          ),
                          Marker(
                            markerId: MarkerId('shipment-location2'),
                            position: LatLng(
                              double.parse(merchantInfo['from_address_lat']),
                              double.parse(merchantInfo['from_address_long']),
                            ),
                            icon: controller.merchentCustomIcon,
                            infoWindow: InfoWindow(title: 'Merchant Location'),
                          ),
                        },
                        polylines: {
                          Polyline(
                            polylineId: PolylineId('route'),
                            points: controller.polylineCoordinates,
                            color: TColors.primary,
                            width: 5,
                          ),
                        },
                      );
                    }),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    minChildSize: 0.4,
                    maxChildSize: 0.9,
                    builder: (context, scrollController) {
                      return Container(
                        padding: EdgeInsets.only(top: 2.h),
                        decoration: BoxDecoration(
                          color: TColors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.sp),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, -2),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Obx(() {
                            if (controller.isLoading.value ||
                                !controller.isSuccess.value) {
                              return SizedBox.shrink();
                            }
                            final shipmentInfo = controller.shipmentInfo.value;
                            final recipientInfo =
                                controller.recipientInfo.value;
                            final announcements =
                                controller.announcements.value;
                            final delliveryInfo = controller.deliveryInfo.value;

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        controller.shipmentInfo
                                                    .value['shipment_status'] ==
                                                0
                                            ? IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'هل أنت متأكد أنك تريد حذف الشحنة؟',
                                                          style: CustomTextStyle
                                                              .headlineTextStyle
                                                              .apply(
                                                            color:
                                                                TColors.primary,
                                                            fontSizeFactor: 1.1,
                                                          ),
                                                          textDirection:
                                                              TextDirection.rtl,
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child: Text(
                                                              'لا',
                                                              style: CustomTextStyle
                                                                  .headlineTextStyle
                                                                  .apply(
                                                                color: TColors
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(true);
                                                              controller
                                                                  .cancelShipment();
                                                            },
                                                            child: Text(
                                                              'نعم',
                                                              style: CustomTextStyle
                                                                  .headlineTextStyle
                                                                  .apply(
                                                                color: TColors
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: TColors.error,
                                                ),
                                              )
                                            : controller.shipmentInfo.value[
                                                        'shipment_status'] ==
                                                    10
                                                ? SizedBox()
                                                : SizedBox(),
                                        Text(
                                          '${shipmentInfo['shipment_contents']}',
                                          style:
                                              CustomTextStyle.headlineTextStyle,
                                        ),
                                      ],
                                    ),
                                    CustomSizedBox.textSpacingVertical(),
                                    Text(
                                      '${shipmentInfo['shipment_number']}',
                                      style: CustomTextStyle.greyTextStyle,
                                    ),
                                    Divider(color: TColors.grey),
                                    DefaultTabController(
                                      initialIndex: 1,
                                      length: 3,
                                      child: Column(
                                        children: [
                                          TabBar(
                                            labelColor: TColors.primary,
                                            unselectedLabelColor: TColors.grey,
                                            indicatorColor: TColors.primary,
                                            tabs: [
                                              Tab(
                                                child: Text(
                                                  'التبليغات',
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  'الإيصال الإلكتروني',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 8.sp),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  'أحداث الشحنة',
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 70.h,
                                            child: TabBarView(
                                              children: [
                                                announcements.isEmpty
                                                    ? ListView(
                                                        children: [
                                                          SizedBox(height: 5.h),
                                                          // Add some space to center the content
                                                          Center(
                                                            child: Image(
                                                              image: AssetImage(
                                                                  "assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
                                                              height: 20.h,
                                                            ),
                                                          ),
                                                          CustomSizedBox
                                                              .itemSpacingVertical(
                                                                  height:
                                                                      0.5.h),
                                                          Center(
                                                            child: Text(
                                                              'لا توجد تبليغات عن الشحنة',
                                                              style: CustomTextStyle
                                                                  .headlineTextStyle,
                                                            ),
                                                          ),
                                                          CustomSizedBox
                                                              .textSpacingVertical(),
                                                          Center(
                                                            child: Text(
                                                              'حاول لاحقًا لمعرفة ما إذا كان هناك تبليغات عن الشحنة',
                                                              style: CustomTextStyle
                                                                  .headlineTextStyle
                                                                  .apply(
                                                                      color: TColors
                                                                          .darkGrey,
                                                                      fontWeightDelta:
                                                                          -10),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.h),
                                                        child: Directionality(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                announcements
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final announcement =
                                                                  announcements[
                                                                      index];
                                                              return NotificationTile(
                                                                message:
                                                                    announcement[
                                                                        'announcements_text'],
                                                                icon: Icons
                                                                    .warning_amber_outlined,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3.h),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            height: 15.h,
                                                            width: 80.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius: 5,
                                                                  blurRadius: 7,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Directionality(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        QrImageView(
                                                                      data:
                                                                          '${shipmentInfo['shipment_number']}',
                                                                      version:
                                                                          QrVersions
                                                                              .auto,
                                                                      size: 20.h,
                                                                    ),
                                                                    height: 15.h,
                                                                    width: 25.w,
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                            vertical:
                                                                                2.h),
                                                                  ),
                                                                  VerticalDivider(
                                                                    color: TColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    thickness: 2,
                                                                    width: 2,
                                                                    indent: 1.h,
                                                                    endIndent:
                                                                        2.h,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Image(
                                                                        image: AssetImage(
                                                                            "assets/images/zebr.png"),
                                                                        height:
                                                                            5.h,
                                                                        width:
                                                                            45.w,
                                                                      ),
                                                                      Text(
                                                                        '${shipmentInfo['shipment_number']}',
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SectionTitle(
                                                            title: 'ملخص التاجر'),
                                                        Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: SummaryContainer(
                                                              data:
                                                                  traderSummaryData(
                                                                      controller)),
                                                        ),
                                                        const SectionTitle(
                                                            title:
                                                                'ملخص المستلم'),
                                                        Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: SummaryContainer(
                                                              data:
                                                                  recipientSummaryData(
                                                                      controller)),
                                                        ),
                                                        const SectionTitle(
                                                            title: 'ملخص الشحنة'),
                                                        Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: SummaryContainer(
                                                              data:
                                                                  shipmentSummaryData(
                                                                      controller)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3.h),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: controller
                                                                    .shipmentInfo
                                                                    .value[
                                                                'shipment_status'] ==
                                                            10
                                                        ? ListView(
                                                            children: [
                                                              SizedBox(
                                                                  height: 5.h),
                                                              // Add some space to center the content
                                                              Center(
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      "assets/images/canceled.png"),
                                                                  height: 20.h,
                                                                ),
                                                              ),
                                                              CustomSizedBox
                                                                  .itemSpacingVertical(
                                                                      height:
                                                                          0.5.h),
                                                              Center(
                                                                child: Text(
                                                                  'تم إلغاء الشحنة',
                                                                  style: CustomTextStyle
                                                                      .headlineTextStyle,
                                                                ),
                                                              ),
                                                              CustomSizedBox
                                                                  .textSpacingVertical(),
                                                              Center(
                                                                child: Text(
                                                                  'لم يعد بالإمكان تتبع الشحنة حيث تم إلغاؤها',
                                                                  style: CustomTextStyle
                                                                      .headlineTextStyle
                                                                      .apply(
                                                                          color: TColors
                                                                              .darkGrey,
                                                                          fontWeightDelta:
                                                                              -10),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : TrackingStepper(
                                                            status: shipmentInfo[
                                                                'shipment_status'],
                                                            subtitle:
                                                                '${recipientInfo['address']}',
                                                            shipmentNumber:
                                                                shipmentInfo[
                                                                    'shipment_number'],
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomSizedBox.itemSpacingVertical(
                                        height: 1.h),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Map<String, String> traderSummaryData(TrackingController controller) {
    return {
      'اسم التاجر': controller.merchantInfo.value['name'],
      'المحافظة': controller.merchantInfo.value["city"],
      'العنوان': controller.merchantInfo.value["from_address_details"],
      'النشاط التجاري': controller.merchantInfo.value['business_name'],
    };
  }

  Map<String, String> recipientSummaryData(TrackingController controller) {
    return {
      'اسم المستلم': controller.recipientInfo.value["name"],
      'المحافظة':controller.recipientInfo.value["city"],
      'العنوان':controller.recipientInfo.value["address"],
      'رقم الهاتف': controller.recipientInfo.value["phone"],
    };
  }

  Map<String, String> shipmentSummaryData(TrackingController controller) {
    return {
      'محتوى الشحنة': controller.shipmentInfo.value["shipment_contents"],
      'سرعة الشحن': controller.shipmentInfo.value["shipment_type"],
      'الوزن': '${controller.shipmentInfo.value["shipment_weight"]} كغ',
      'العدد': '${controller.shipmentInfo.value["shipment_quantity"]} قطعة',
      'السعر': '${controller.shipmentInfo.value["shipment_value"]} JD',
      'تكاليف الشحن': '${controller.shipmentInfo.value["shipment_fee"]} JD',
      'ملاحظات': controller.shipmentInfo.value.isEmpty
          ? '-'
          : controller.shipmentInfo.value["shipment_note"],
    };
  }
}
