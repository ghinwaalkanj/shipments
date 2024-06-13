import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (!controller.isSuccess.value) {
          return Center(child: Text('Failed to load shipment details'));
        }

        final shipmentInfo = controller.shipmentInfo.value;
        final recipientInfo = controller.recipientInfo.value;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizedBox.itemSpacingVertical(height: 1.h),
                  Stack(
                    children: [
                      Image.network(
                        'https://via.placeholder.com/400',
                        height: 30.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 1.h,
                        left: 2.w,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20.sp,
                        ),
                      ),
                      Positioned(
                        top: 1.h,
                        right: 2.w,
                        child: Text(
                          'متابعة الشحنة',
                          style: CustomTextStyle.headlineTextStyle.apply(
                            fontSizeFactor: 1.2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomSizedBox.itemSpacingVertical(height: 1.h),
                  Text(
                    '${recipientInfo['name']}',
                    style: CustomTextStyle.headlineTextStyle,
                  ),
                  CustomSizedBox.textSpacingVertical(),
                  Text(
                    '${shipmentInfo['shipment_number']}',
                    style: CustomTextStyle.greyTextStyle,
                  ),
                  CustomSizedBox.itemSpacingVertical(height: 1.h),
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
                            Tab(text: 'أحداث الشحنة'),
                            Tab(text: 'التبليغات'),
                          ],
                        ),
                        Container(
                          height: 40.h,
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                itemCount: controller.announcements.length,
                                itemBuilder: (context, index) {
                                  final announcement =
                                      controller.announcements[index];
                                  return ListTile(
                                    title: Text(announcement['title'] ?? ''),
                                    subtitle:
                                        Text(announcement['description'] ?? ''),
                                    trailing:
                                        Text(announcement['timestamp'] ?? ''),
                                  );
                                },
                              ),
                              Center(child: Text('التبليغات')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSizedBox.itemSpacingVertical(height: 1.h),
                  _buildStepper(shipmentInfo['shipment_status']),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStepper(int status) {
    Color getColor(int index) {
      if (status == 0) return Colors.grey;
      if (status >= index) return TColors.primary; // primary color
      return Colors.black;
    }

    bool showShipmentIcon(int index) {
      return status == index;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Row(
            children: [
              if (showShipmentIcon(2))
                Transform.translate(
                  offset: Offset(-15.w, 0),
                  child: Icon(
                    Icons.check_circle,
                    color: getColor(2),
                    size: 15.sp,
                  ),
                ),
              if (showShipmentIcon(4))
                Transform.translate(
                  offset: Offset(-27.w, 0),
                  child: Icon(
                    Icons.check_circle,
                    color: getColor(4),
                    size: 15.sp,
                  ),
                ),
              if (showShipmentIcon(5))
                Transform.translate(
                  offset: Offset(-39.w, 0),
                  child: Icon(
                    Icons.check_circle,
                    color: getColor(5),
                    size: 15.sp,
                  ),
                ),
              if (showShipmentIcon(6))
                Transform.translate(
                  offset: Offset(-51.w, 0),
                  child: Icon(
                    Icons.check_circle,
                    color: getColor(6),
                    size: 15.sp,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                status == 0
                    ? 'assets/images/Subtract8.png'
                    : 'assets/images/Subtract3.png',
                height: 3.h,
              ),
              Expanded(
                child: Divider(
                  color: getColor(2),
                  thickness: 2,
                  indent: 10,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(2),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(4),
                  thickness: 2,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(4),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(5),
                  thickness: 2,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(5),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(6),
                  thickness: 2,
                ),
              ),
              Icon(
                Icons.circle,
                color: getColor(6),
                size: 10.sp,
              ),
              Expanded(
                child: Divider(
                  color: getColor(7),
                  thickness: 2,
                  endIndent: 10,
                ),
              ),
              Image.asset(
                status == 7
                    ? 'assets/images/Subtract10.png'
                    : 'assets/images/Subtract8.png',
                height: 3.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
