import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../common/widgets/app_bar.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/text_field.dart';
import '../../utils/constants/colors.dart';
import 'controller/AddressController.dart';
import 'controller/map_controller.dart';

class AddressDetailScreen extends StatelessWidget {
  final LatLng selectedLocation;

  AddressDetailScreen({super.key, required this.selectedLocation});

  final AddressController _controller = Get.put(AddressController());
  final MapController mapController = Get.put(MapController());
  final TextEditingController _addressDetailsController =
      TextEditingController();
  final RxString _selectedOption = ''.obs;

  @override
  Widget build(BuildContext context) {
    _controller.fetchCities();

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'تفاصيل العنوان',
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30.h,
                padding: EdgeInsets.symmetric(
                  vertical: 2.h,
                  horizontal: 3.w,
                ),
                child:  FutureBuilder(
                  future: mapController.initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return  GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: selectedLocation,
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('selected-location'),
                            position: selectedLocation,
                            icon: mapController.merchantCustomIcon,
                          ),
                        },
                      );
                    }
                  },
                ),

              ),
              SizedBox(height: 5.h),
              Obx(() => Padding(
                padding: EdgeInsets.fromLTRB(5.w, 1.h, 6.w, 0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonFormField<String>(
                    value: _selectedOption.value.isEmpty
                        ? null
                        : _selectedOption.value,
                    items: _controller.cities.map((city) {
                      return DropdownMenuItem(
                        child: Text(
                          city.name,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: TColors.darkGrey,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        value: city.id.toString(),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      _selectedOption.value = newValue!;
                    },
                    decoration: InputDecoration(
                      hintText: 'اختر المدينة',
                      hintStyle: TextStyle(
                        fontSize: 9.sp,
                        color: TColors.darkGrey,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                      prefixIcon: IconTheme(
                        data: IconThemeData(
                          color: TColors.primary,
                          size: 24.sp,
                        ),
                        child: Icon(Icons.location_city),
                      ),
                      hintTextDirection: TextDirection.rtl,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: TColors.primary, width: 2.0),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    icon: Icon(Icons.arrow_drop_down,
                        textDirection: TextDirection.ltr),
                  ),
                ),
              )),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: TTextField(
                  hintText: "العنوان بالتفصيل",
                  prefixIcon: Icon(Icons.person_3_outlined),
                  controller: _addressDetailsController,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  isPhone: false,
                ),
              ),

              SizedBox(height: 10.h),
              Container(
                height:20.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 0.w),
                  child: Obx(
                    () => Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.w),
                      child: TButton(
                          text: _controller.isLoading.value
                              ? 'جاري إضافة العنوان...'
                              : 'تأكيد العنوان',
                          onPressed: () {
                            _controller.addAddress(
                              details: _addressDetailsController.text,
                              cityId: _selectedOption.value,
                              lat: selectedLocation.latitude.toString(),
                              long: selectedLocation.longitude.toString(),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
