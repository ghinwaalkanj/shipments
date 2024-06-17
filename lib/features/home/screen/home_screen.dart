import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/home/controller/home_controller.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/ads_widget.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/current_shipments_widget.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/home_shimmer.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/no_shipments_widget.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/search_widget.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/service_widgets.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final RxInt _currentAdIndex = 0.obs;

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
            padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w,bottom: 1.h),
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.fetchHomeData();
              },
              color: TColors.primary,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 90.h,
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: HomeShimmerWidget());
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SearchWidgets(),
                          const ServiceWidgets(),
                          const AdsWidget(),
                          if (controller.shipments.isNotEmpty)
                            const CurrentShipmentsWidget()
                          else
                            const NoShipmentsWidget(),
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
