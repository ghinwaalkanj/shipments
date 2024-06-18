import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shipment_merchent_app/features/shipment/screen/recipent_address_detail_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/button.dart';
import '../../../utils/constants/colors.dart';
import '../../address/controller/AddressController.dart';
import '../controller/mp_controller.dart';
import '../controller/add_shipment_controller.dart';

class RecipentMapAddressScreen extends StatelessWidget {
  final MpController mpController = Get.put(MpController());
  final AddressController addressController = Get.put(AddressController());
  final AddShipmentController controller = Get.put(AddShipmentController());

  @override
  Widget build(BuildContext context) {
    mpController.initializeLocation();

    return Scaffold(
      appBar: TAppBar(
        title: 'إضافة عنوان المستلم',
        showBackArrow: true,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: mpController.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Obx(
                  () => GoogleMap(
                    zoomControlsEnabled: false,
                    onMapCreated: mpController.onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: mpController.selectedLocation.value,
                      zoom: 8,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('recipent-location'),
                        position: mpController.selectedLocation.value,
                        icon: mpController.merchantCustomIcon,
                      ),
                    },
                    onTap: mpController.onTap,
                    polygons: {
                      Polygon(
                        polygonId: PolygonId('jordan-boundary'),
                        points: mpController.jordanPolygonCoords,
                        strokeColor: TColors.primary,
                        strokeWidth: 2,
                        fillColor: TColors.primary.withOpacity(0.3),
                      ),
                    },
                  ),
                );
              }
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.01,
            child: Container(
              height: 8.h,
              width: 100.w,
              padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 0.h),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Obx(
                  () => SearchField<String>(
                    searchStyle: TextStyle(
                      fontSize: 12.sp,
                      color: TColors.black,
                      fontFamily: 'Cairo',
                    ),
                    itemHeight: 7.h,
                    searchInputDecoration: InputDecoration(
                      filled: true,
                      fillColor: TColors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20.sp,
                        color: TColors.darkGrey,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 1.5.h,
                        horizontal: 3.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: TColors.darkGrey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: TColors.darkGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: TColors.primary),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: TColors.error),
                      ),
                      hintText: addressController.searchlist.isEmpty
                          ? 'الموقع الحالي'
                          : 'ابحث عن موقع',
                      hintStyle: TextStyle(
                        height: 0.2.h,
                        fontSize: 11.sp,
                        fontFamily: 'Cairo',
                        letterSpacing: 1,
                      ),
                    ),
                    suggestions: addressController.searchlist
                        .map(
                          (e) => SearchFieldListItem<String>(
                        e['properties']['name'],
                        child: InkWell(
                          onTap: () {
                            List<dynamic> coordinates =
                            e['geometry']['coordinates'];
                            double latitude = coordinates[1];
                            double longitude = coordinates[0];
                            LatLng latLng = LatLng(latitude, longitude);
                            mpController.onTap(latLng);
                            addressController.searchlist.clear();
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${e['properties']['name']}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: TColors.black,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  Text(
                                    '${e['properties']['state']}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 7.sp,
                                      color: TColors.grey,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                    onSearchTextChanged: (query) {
                      addressController.getsearch(query);
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: TButton(
              text: 'تأكيد العنوان',
              onPressed: () {
                Get.to(
                  () => RecipentAddressDetailScreen(
                    selectedLocation: LatLng(
                      mpController.recipientLat.value,
                      mpController.recipientLong.value,
                    ),
                  ),
                );
                print(mpController.recipientLat.value);
                print(mpController.recipientLong.value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
