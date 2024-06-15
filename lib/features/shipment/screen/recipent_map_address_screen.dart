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
          Obx(
                () => GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: mpController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: mpController.selectedLocation.value,
                zoom: 8, // Adjusted for better view of Jordan
              ),
              markers: {
                Marker(
                  markerId: MarkerId('recipent-location'),
                  position: mpController.selectedLocation.value,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet),
                ),
              },
              onTap: mpController.onTap,
              // Adding polygon to represent Jordan's boundary
              polygons: {
                Polygon(
                  polygonId: PolygonId('jordan-boundary'),
                  points: [
                    LatLng(29.35710624160365, 34.960356540977955),
                    LatLng(29.186004417721982, 36.06992371380329),
                    LatLng(29.500036758657515, 36.50461658835411),
                    LatLng(29.868709005385274, 36.75370026379824),
                    LatLng(29.999993181855327, 37.50000413507223),
                    LatLng(30.33265247412292, 37.665534652769566),
                    LatLng(30.500656227126548, 37.997070774436),
                    LatLng(31.50011260473826, 37.000902369618416),
                    LatLng(31.996458511317304, 38.99592272937298),
                    LatLng(32.23029491982611, 39.30116683244705),
                    LatLng(32.35872048444148, 39.259475246071815),
                    LatLng(32.30997557369853, 39.04467388987541),
                    LatLng(32.4777197979711, 38.98603107780218),
                    LatLng(32.4777197979711, 38.98603107780218),
                    LatLng(32.50277500054379, 39.08745210617781),
                    LatLng(33.37445470544933, 38.79321377724409),
                    LatLng(32.381483360267595, 36.395640447735786),
                    LatLng(32.53066921654482, 36.20139554142952),
                    LatLng(32.53028562907582, 36.19429774582386),
                    LatLng(32.51253790063161, 36.1660872772336),
                    LatLng(32.52348904685806, 36.15582883358002),
                    LatLng(32.52560471239052, 36.122376658022404),
                    LatLng(32.51289809740784, 36.07800018042326),
                    LatLng(32.6557307295814, 36.02696042507887),
                    LatLng(32.74468171566687, 35.755427330732346),
                    LatLng(32.64706295300653, 35.562053471803665),
                    LatLng(31.11166891844878, 35.43172091245651),
                    LatLng(29.357280696989694, 34.9600175768137),
                  ],
                  strokeColor:TColors.primary,
                  strokeWidth: 2,
                  fillColor: TColors.primary.withOpacity(0.3),
                ),
              },
            ),
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
                      color: Colors.black,
                      fontFamily: 'Cairo',
                    ),
                    itemHeight: 7.h,
                    searchInputDecoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                        child: GestureDetector(
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
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                  Text(
                                    '${e['properties']['state']}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 7.sp,
                                      color: Colors.grey,
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
                Get.to(() => RecipentAddressDetailScreen(
                  selectedLocation: LatLng(
                    mpController.recipientLat.value,
                    mpController.recipientLong.value,
                  ),
                ),);
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
