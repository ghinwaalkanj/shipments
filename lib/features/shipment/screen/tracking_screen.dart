import 'package:flutter/material.dart';
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
    final TrackingController controller = Get.put(TrackingController(shipmentId: shipmentId));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TAppBar(
          title: 'متابعة الشحنة',
          showBackArrow: true,
        ),
        backgroundColor: TColors.white,
        body: FutureBuilder<void>(
          future: controller.fetchShipmentDetails(), // قمنا بتعديل هذه الدالة لتضمن تحميل البيانات
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: TColors.primary,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to load shipment details'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchShipmentDetails();
                },
                color: TColors.primary,
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 50.h,
                        floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                            child: Obx(() {
                              if (controller.isLoading.value) {
                                return Center(child: CircularProgressIndicator());
                              }

                              if (!controller.isSuccess.value) {
                                return Center(child: Text('Failed to load shipment details'));
                              }

                              final recipientInfo = controller.recipientInfo.value;
                              final merchantInfo = controller.merchantInfo.value;
                              return GoogleMap(
                                onMapCreated: controller.onMapCreated,
                                zoomControlsEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.parse(recipientInfo['lat'] ?? '0.0'),
                                    double.parse(recipientInfo['long'] ?? '0.0'),
                                  ),
                                  zoom: 14,
                                ),
                                markers: {
                                  Marker(
                                    markerId: MarkerId('shipment-location'),
                                    position: LatLng(
                                      double.parse(recipientInfo['lat'] ?? '0.0'),
                                      double.parse(recipientInfo['long'] ?? '0.0'),
                                    ),
                                    icon: controller.recipentCustomIcon,
                                    infoWindow: InfoWindow(title: 'Shipment Location'),
                                  ),
                                  Marker(
                                    markerId: MarkerId('shipment-location2'),
                                    position: LatLng(
                                      double.parse(merchantInfo['from_address_lat'] ?? '0.0'),
                                      double.parse(merchantInfo['from_address_long'] ?? '0.0'),
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
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                            labelColor: TColors.primary,
                            unselectedLabelColor: TColors.grey,
                            indicatorColor: TColors.primary,
                            tabs: [
                              Tab(
                                child: Text(
                                  'التبليغات',
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'الإيصال الإلكتروني',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'أحداث الشحنة',
                                  style: TextStyle(fontFamily: 'Cairo'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      buildAnnouncementsTab(controller),
                      buildElectronicReceiptTab(controller),
                      buildShipmentEventsTab(controller),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildAnnouncementsTab(TrackingController controller) {
    final announcements = controller.announcements.value;
    return announcements.isEmpty
        ? ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(height: 5.h),
        Center(
          child: Image(
            image: AssetImage("assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
            height: 20.h,
          ),
        ),
        CustomSizedBox.itemSpacingVertical(height: 0.5.h),
        Center(
          child: Text(
            'لا توجد تبليغات عن الشحنة',
            style: CustomTextStyle.headlineTextStyle,
          ),
        ),
        CustomSizedBox.textSpacingVertical(),
        Center(
          child: Text(
            'حاول لاحقًا لمعرفة ما إذا كان هناك تبليغات عن الشحنة',
            style: CustomTextStyle.headlineTextStyle.apply(color: TColors.darkGrey, fontWeightDelta: -10),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    )
        : Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return NotificationTile(
              message: announcement['announcements_text'],
              icon: Icons.warning_amber_outlined,
            );
          },
        ),
      ),
    );
  }

  Widget buildElectronicReceiptTab(TrackingController controller) {
    final shipmentInfo = controller.shipmentInfo.value;
    if (shipmentInfo.isEmpty) {
      return Center(
        child: Text('No shipment info available.'),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Container(
                height: 15.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: QrImageView(
                          data: '${shipmentInfo['shipment_number']}',
                          version: QrVersions.auto,
                          size: 20.h,
                        ),
                        height: 15.h,
                        width: 25.w,
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
                      VerticalDivider(
                        color: TColors.black.withOpacity(0.5),
                        thickness: 2,
                        width: 2,
                        indent: 1.h,
                        endIndent: 2.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("assets/images/zebr.png"),
                            height: 5.h,
                            width: 45.w,
                          ),
                          Text('${shipmentInfo['shipment_number']}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SectionTitle(title: 'ملخص التاجر'),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SummaryContainer(data: traderSummaryData(controller)),
            ),
            const SectionTitle(title: 'ملخص المستلم'),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SummaryContainer(data: recipientSummaryData(controller)),
            ),
            const SectionTitle(title: 'ملخص الشحنة'),
            Directionality(
              textDirection: TextDirection.rtl,
              child: SummaryContainer(data: shipmentSummaryData(controller)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShipmentEventsTab(TrackingController controller) {
    final shipmentInfo = controller.shipmentInfo.value;
    final recipientInfo = controller.recipientInfo.value;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Align(
        alignment: Alignment.topRight,
        child: controller.shipmentInfo.value['shipment_status'] == 10
            ? ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(height: 5.h),
            Center(
              child: Image(
                image: AssetImage("assets/images/canceled.png"),
                height: 20.h,
              ),
            ),
            CustomSizedBox.itemSpacingVertical(height: 0.5.h),
            Center(
              child: Text(
                'تم إلغاء الشحنة',
                style: CustomTextStyle.headlineTextStyle,
              ),
            ),
            CustomSizedBox.textSpacingVertical(),
            Center(
              child: Text(
                'لم يعد بالإمكان تتبع الشحنة حيث تم إلغاؤها',
                style: CustomTextStyle.headlineTextStyle.apply(color: TColors.darkGrey, fontWeightDelta: -10),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
            : TrackingStepper(
          status: shipmentInfo['shipment_status'],
          subtitle: '${recipientInfo['address']}',
          shipmentNumber: shipmentInfo['shipment_number'],
        ),
      ),
    );
  }

  Map<String, String> traderSummaryData(TrackingController controller) {
    final merchantInfo = controller.merchantInfo.value;
    return {
      'اسم التاجر': merchantInfo['name'] ?? '',
      'المحافظة': merchantInfo['city'] ?? '',
      'العنوان': merchantInfo['from_address_details'] ?? '',
      'النشاط التجاري': merchantInfo['business_name'] ?? '',
    };
  }

  Map<String, String> recipientSummaryData(TrackingController controller) {
    final recipientInfo = controller.recipientInfo.value;
    return {
      'اسم المستلم': recipientInfo['name'] ?? '',
      'المحافظة': recipientInfo['city'] ?? '',
      'العنوان': recipientInfo['address'] ?? '',
      'رقم الهاتف': recipientInfo['phone'] ?? '',
    };
  }

  Map<String, String> shipmentSummaryData(TrackingController controller) {
    final shipmentInfo = controller.shipmentInfo.value;
    return {
      'محتوى الشحنة': shipmentInfo['shipment_contents'] ?? '',
      'سرعة الشحن': shipmentInfo['shipment_type'] ?? '',
      'الوزن': '${shipmentInfo['shipment_weight'] ?? 0} كغ',
      'العدد': '${shipmentInfo['shipment_quantity'] ?? 0} قطعة',
      'السعر': '${shipmentInfo['shipment_value'] ?? 0} JD',
      'تكاليف الشحن': '${shipmentInfo['shipment_fee'] ?? 0} JD',
      'ملاحظات': shipmentInfo['shipment_note']?.isEmpty ?? true ? '-' : shipmentInfo['shipment_note'] ?? '',
    };
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
      color: Colors.white,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
