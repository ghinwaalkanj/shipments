import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/shipment/controller/bulk_shipments_controller.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bulk_shipment/shipment_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../address/controller/AddressController.dart';

class ShipmentForm extends StatelessWidget {
  final int index;

  final AddressController addressController1 = Get.put(AddressController());

  ShipmentForm({required this.index});

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
          onChanged: (value) {
            controller.shipmentForms[index].recipientPhone = value;
          },
         maxLength: 8,
          isJordanianNumber: true,
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
              fillColor: Colors.white,
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
            )
                .toList(),
            onSearchTextChanged: (query) {
              addressController1.getsearch(query);
              return null;
            },
            onSuggestionTap: (suggestion) {
              final selected = addressController1.searchlist.firstWhere(
                      (element) => element['properties']['name'] == suggestion.searchKey);
              double lat = selected['geometry']['coordinates'][1];
              double long = selected['geometry']['coordinates'][0];

              // Check if the location is within Jordan
              if (lat >= 29.186004417721982 &&
                  lat <= 33.37445470544933 &&
                  long >= 34.960356540977955 &&
                  long <= 38.79321377724409) {
                controller.shipmentForms[index].recipientCity =
                selected['properties']['city'];
                controller.shipmentForms[index].recipientAddress =
                selected['properties']['name'];
                controller.shipmentForms[index].recipientLat = lat;
                controller.shipmentForms[index].recipientLong = long;
              } else {
                Get.snackbar(
                  "تنبيه",
                  "هذا الموقع خارج حدود الأردن",
                  snackPosition: SnackPosition.BOTTOM,
                );
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
}
