import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/tracking_stepper.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import '../controller/tracking_controller.dart';

class TrackingScreen extends StatelessWidget {
  final int shipmentId;

  const TrackingScreen({required this.shipmentId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrackingController controller =
    Get.put(TrackingController(shipmentId: shipmentId));

    return Scaffold(
      appBar: const TAppBar(
        title: 'متابعة الشحنة',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (!controller.isSuccess.value) {
              return Center(child: Text('Failed to load shipment details'));
            }

            final shipmentInfo = controller.shipmentInfo.value;
            final recipientInfo = controller.recipientInfo.value;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: GoogleMap(
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
                    infoWindow: InfoWindow(title: 'Shipment Location'),
                  ),
                },
              ),
            );
          }),
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
                    return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${shipmentInfo['shipment_contents']}',
                            style: CustomTextStyle.headlineTextStyle,
                          ),
                          CustomSizedBox.textSpacingVertical(),
                          Text(
                            '${shipmentInfo['shipment_number']}',
                            style: CustomTextStyle.greyTextStyle,
                          ),
                          Divider(color: TColors.grey),
                          DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                  labelColor: TColors.primary,
                                  unselectedLabelColor: TColors.grey,
                                  indicatorColor: TColors.primary,
                                  tabs: [
                                    Tab(text: 'التبليغات'),
                                    Tab(text: 'أحداث الشحنة'),
                                  ],
                                ),
                                Container(
                                  height: 55.h,
                                  child: TabBarView(
                                    children: [
                                      Center(child: Text('التبليغات')),
                                      Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 3.h),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: TrackingStepper(status: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomSizedBox.itemSpacingVertical(height: 1.h),
                        ],
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
}
