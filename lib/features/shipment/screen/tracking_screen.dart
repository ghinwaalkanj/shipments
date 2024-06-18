import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/announcements_tab.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/electronic_receipt_tab.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/shipment_events_tab.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_widgets/sliver_app_bar_delegate.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../core/services/storage_service.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/api_constants.dart';
import '../controller/tracking_controller.dart';

class TrackingScreen extends StatelessWidget {
  final int shipmentId;

  const TrackingScreen({required this.shipmentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrackingController controller = Get.put(TrackingController(shipmentId: shipmentId));

    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        appBar: TAppBar(
          title: 'متابعة الشحنة',
          showBackArrow: true,
        ),
        backgroundColor: TColors.white,
        body: FutureBuilder<void>(
          future: controller.fetchShipmentDetails(),
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
                              return RefreshIndicator(
                                onRefresh: () async {
                                  await controller.fetchShipmentDetails();
                                },
                                color: TColors.primary,
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Container(
                                    height: 50.h,
                                    child: GoogleMap(
                                      zoomGesturesEnabled: true,
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
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: SliverAppBarDelegate(
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
                      AnnouncementsTab(controller),
                      ElectronicReceiptTab(controller),
                      ShipmentEventsTab(controller),
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
}



