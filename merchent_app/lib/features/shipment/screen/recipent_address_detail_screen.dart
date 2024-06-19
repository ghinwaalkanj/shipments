import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/drobdown_field.dart';
import '../../../utils/constants/colors.dart';
import '../../address/controller/AddressController.dart';
import '../../shipment/controller/add_shipment_controller.dart';
import '../controller/mp_controller.dart';

class RecipentAddressDetailScreen extends StatelessWidget {
  final LatLng selectedLocation;

  RecipentAddressDetailScreen({super.key, required this.selectedLocation});
  final MpController mpController = Get.put(MpController());
  final AddressController _controller = Get.put(AddressController());
  final AddShipmentController shipmentController = Get.find<AddShipmentController>();
  final TextEditingController _addressDetailsController = TextEditingController();
  final RxString _selectedOption = ''.obs;

  void showSnackbar(String message) {
    Get.snackbar(
      'خطأ',
      message,
      backgroundColor: TColors.error,
      colorText: TColors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      icon: Icon(Icons.error_outline, color: TColors.white),
      duration: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'تفاصيل عنوان المستلم',
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
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                child:  FutureBuilder(
                  future: mpController.initialize(),
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
                            icon:  mpController.merchantCustomIcon,
                          ),
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 1.h, 6.w, 0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Obx(() {
                    if (_controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return DropdownButtonFormField<String>(
                      value: _selectedOption.value.isEmpty ? null : _selectedOption.value,
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
                          borderSide: BorderSide(color: TColors.primary, width: 2.0),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: TColors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      icon: Icon(Icons.arrow_drop_down, textDirection: TextDirection.ltr),
                    );
                  }),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: TTextField(
                  hintText: "العنوان بالتفصيل",
                  suffixIcon: Icon(Icons.person_3_outlined),
                  controller: _addressDetailsController,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 20.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 0.w),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Obx(
                          () => TButton(
                        text: _controller.isLoading.value ? 'جاري إضافة العنوان...' : 'تأكيد العنوان',
                        onPressed: () {
                          if (_addressDetailsController.text.isEmpty || _selectedOption.value.isEmpty) {
                            Get.snackbar(
                              'خطأ',
                              'يرجى ملء جميع الحقول ',
                              backgroundColor: TColors.error,
                              colorText: TColors.white,
                              snackPosition: SnackPosition.TOP,
                              margin: EdgeInsets.all(10),
                              borderRadius: 10,
                              icon: Icon(Icons.error_outline, color: TColors.white),
                            );
                          } else {
                            shipmentController.recipientLat.value = selectedLocation.latitude;
                            shipmentController.recipientLong.value = selectedLocation.longitude;
                            shipmentController.recipientAddress.value = _addressDetailsController.text;
                            shipmentController.recipientCity.value = _controller.cities.firstWhere((city) => city.id.toString() == _selectedOption.value).name;
                            Get.to(() => ShipmentStep1Screen());
                          }
                        },
                      ),
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
