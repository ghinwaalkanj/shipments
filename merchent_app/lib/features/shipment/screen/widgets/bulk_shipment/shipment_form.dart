import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/shipment/controller/bulk_shipments_controller.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bulk_shipment/shipment_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import for LatLng

import '../../../../../utils/constants/colors.dart';
import '../../../../address/controller/AddressController.dart';

class ShipmentForm extends StatelessWidget {
  final int index;
  final AddressController addressController1 = Get.put(AddressController());

  ShipmentForm({required this.index});

  final LatLngBounds jordanBounds = LatLngBounds(
    southwest: LatLng(29.186004417721982, 34.960356540977955), // جنوب غرب الأردن
    northeast: LatLng(33.37445470544933, 38.79321377724409), // شمال شرق الأردن
  );

  @override
  Widget build(BuildContext context) {
    final AddBulkShipmentController controller = Get.find();
    TextEditingController recipientNameController =
    controller.recipientNameControllers[index];
    TextEditingController phoneController = controller.phoneControllers[index];
    TextEditingController addressController =
    controller.addressControllers[index];
    TextEditingController amountController =
    controller.amountControllers[index];
    TextEditingController feeController = controller.feeControllers[index];
    TextEditingController notesController = controller.notesControllers[index];
    RxBool isOutsideJordan = false.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'اسم العميل',
          icon: Icons.person,
          controller: recipientNameController,
          onChanged: (value) {
            controller.shipmentForms[index].recipientName = value;
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          keyboardType: TextInputType.phone,
          hintText: 'رقم الهاتف',
          icon: Icons.phone,
          controller: phoneController,
          isJordanianNumber: true,
          maxLength: 8,
          onChanged: (value) {
            controller.shipmentForms[index].recipientPhone = value;
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        Obx(
              () => SearchField<String>(
            searchStyle: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontFamily: 'Cairo',
            ),
            itemHeight: 7.h,
            searchInputDecoration: InputDecoration(
              filled: true,
              fillColor: isOutsideJordan.value ? Colors.red[100] : Colors.white,
              prefixIcon: Icon(
                Icons.search,
                size: 20.sp,
                color: TColors.darkGrey,
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 3.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: isOutsideJordan.value ? Colors.red : TColors.darkGrey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: isOutsideJordan.value ? Colors.red : TColors.darkGrey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: isOutsideJordan.value ? Colors.red : TColors.primary,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: TColors.error),
              ),
              hintText: addressController1.searchlist.isEmpty
                  ? 'الموقع الحالي'
                  : 'ابحث عن موقع',
              hintStyle: TextStyle(
                height: 0.2.h,
                fontSize: 10.sp,
                fontFamily: 'Cairo',
              ),
            ),
            suggestions: addressController1.searchlist
                .map(
                  (e) => SearchFieldListItem<String>(
                e['properties']['name'],

                child: Container(
                  alignment: Alignment.centerRight,
                  padding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            )
                .toList(),
            onSearchTextChanged: (query) {
              addressController1.getsearch(query);
              return null;
            },
            onSuggestionTap: (suggestion) {
              final selected = addressController1.searchlist.firstWhere(
                      (element) =>
                  element['properties']['name'] == suggestion.searchKey);
              double lat = selected['geometry']['coordinates'][1];
              double long = selected['geometry']['coordinates'][0];
              if (isWithinJordanBounds(lat, long)) {
                print(addressController.value);
                controller.shipmentForms[index].recipientCity =
                selected['properties']['city']??selected['properties']['name'];
                controller.shipmentForms[index].recipientAddress =
                selected['properties']['name']??selected['properties']['name'];
                controller.shipmentForms[index].recipientLat = lat;
                controller.shipmentForms[index].recipientLong = long;
                isOutsideJordan.value = false;
              } else {
                Get.snackbar(
                  'خطأ',
                  'الموقع المختار خارج حدود الأردن',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                // Clear the text field if the location is outside Jordan bounds
                addressController.clear();
                isOutsideJordan.value = true;
              }
            },
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          keyboardType: TextInputType.phone,
          hintText: 'المبلغ',
          icon: Icons.money,
          controller: amountController,
          onChanged: (value) {
            controller.shipmentForms[index].shipmentValue = value;
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          keyboardType: TextInputType.phone,
          hintText: 'سعر التوصيل',
          icon: Icons.delivery_dining_outlined,
          controller: feeController,
          onChanged: (value) {
            controller.shipmentForms[index].shipmentFee = int.parse(value);
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'ملاحظات',
          icon: Icons.note,
          controller: notesController,
          onChanged: (value) {
            controller.shipmentForms[index].shipmentNote = value;
          },
        ),
      ],
    );
  }

  bool isWithinJordanBounds(double lat, double long) {
    return lat >= jordanBounds.southwest.latitude &&
        lat <= jordanBounds.northeast.latitude &&
        long >= jordanBounds.southwest.longitude &&
        long <= jordanBounds.northeast.longitude;
  }
}
