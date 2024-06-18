import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shipment_merchent_app/features/address/map_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/widgets/app_bar.dart';
import 'controller/AddressController.dart';

class AddressListScreen extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'عناويني',
        showBackArrow: true,
      ),
      body: RefreshIndicator(
        color: TColors.primary,
        onRefresh: () => addressController.fetchAddresses(),
        child: Column(
          children: [
            Obx(() {
              if (addressController.isLoading.value) {
                return Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 25.h,
                      width: 100.w,
                      color: TColors.bg,
                      child: Center(
                        child: SizedBox(
                          height: 25.h,
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (addressController.addresses.isEmpty) {
                return Container(
                  height: 25.h,
                  width: 100.w,
                  color: TColors.bg,
                  child: Center(
                    child: Text('لا توجد عناوين'),
                  ),
                );
              }

              var defaultAddress = addressController.addresses.firstWhere(
                      (address) => address.isDefault == 1,
                  orElse: () => addressController.addresses.first);

              return Container(
                height: 25.h,
                width: 100.w,
                padding: EdgeInsets.all(4.w),
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'العنوان الافتراضي',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: TColors.primary,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          SizedBox(height: 1.5.h),
                          Text(
                            '${defaultAddress.cityName} - ${defaultAddress.addressDetails}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Cairo',
                              color: TColors.darkGrey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Container(
                        height: 15.h,
                        width: 15.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: FutureBuilder(
                            future: addressController.initialize(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else {
                                return GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                      double.parse(defaultAddress.addressLat),
                                      double.parse(defaultAddress.addressLong),
                                    ),
                                    zoom: 11,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: MarkerId('default-location'),
                                      position: LatLng(
                                        double.parse(defaultAddress.addressLat),
                                        double.parse(defaultAddress.addressLong),
                                      ),
                                      icon: addressController.merchantCustomIcon,
                                    ),
                                  },
                                  zoomControlsEnabled: false,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.fromLTRB(3.w, 2.h, 3.w, 0),
                  decoration: BoxDecoration(
                    color: TColors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.sp)),
                  ),
                  child: Obx(() {
                    if (addressController.isLoading.value) {
                      return Center(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Container(
                                    width: 100.w,
                                    height: 20.sp,
                                    color: Colors.grey[300],
                                  ),
                                  trailing: Icon(Icons.check_circle, color: Colors.grey[300]),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }

                    if (addressController.addresses.isEmpty) {
                      return Center(child: Text('لا توجد عناوين'));
                    }

                    return ListView.builder(
                      itemCount: addressController.addresses.length,
                      itemBuilder: (context, index) {
                        var address = addressController.addresses[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${address.cityName} - ${address.addressDetails}',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 11.sp,
                              ),
                            ),
                            trailing: address.isDefault == 1
                                ? Icon(Icons.check_circle, color: TColors.primary)
                                : null,
                            onTap: () {
                              addressController.setDefaultAddress(address.id.toString());
                            },
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(MapScreen());
        },
        backgroundColor: TColors.primary,
        child: Icon(Icons.add, color: TColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
