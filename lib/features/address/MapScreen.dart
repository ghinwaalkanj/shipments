import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sizer/sizer.dart';

import '../../common/widgets/app_bar.dart';
import '../../common/widgets/button.dart';
import '../../utils/constants/colors.dart';
import 'AddressDetailScreen.dart';
import '../home/controller/home_controller.dart';
import 'controller/AddressController.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final HomeController homeController = Get.find<HomeController>();
  final AddressController addressController = Get.put(AddressController());
  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() {
    try {
      double lat = double.parse(homeController.addressLat.value);
      double long = double.parse(homeController.addressLong.value);
      _selectedLocation = LatLng(lat, long);
    } catch (e) {
      // If there's an error parsing the lat/long values, default to a predefined location (e.g., Damascus)
      _selectedLocation = LatLng(33.500315243454615, 36.27026326954365); // Damascus coordinates
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
    mapController.animateCamera(CameraUpdate.newLatLng(location));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: 'إضافة عنوان',
        showBackArrow: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: MarkerId('selected-location'),
                position: _selectedLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              ),
            },
            onTap: _onTap,
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
                    suggestions: addressController.searchlist.map(
                          (e) => SearchFieldListItem<String>(
                        e['properties']['name'],
                        child: GestureDetector(
                          onTap: () {
                            List<dynamic> coordinates = e['geometry']['coordinates'];
                            double latitude = coordinates[1];
                            double longitude = coordinates[0];
                            LatLng latLng = LatLng(latitude, longitude);
                            _onTap(latLng); // Move camera and update marker
                            addressController.searchlist.clear();
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                    ).toList(),
                    onSearchTextChanged: (query) {
                      addressController.getsearch(query);
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
                Get.to(() => AddressDetailScreen(selectedLocation: _selectedLocation));
              },
            ),
          ),
        ],
      ),
    );
  }
}
