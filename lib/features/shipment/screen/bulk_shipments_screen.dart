import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipment_text_field.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controller/bulk_shipments_controller.dart';

class BulkShipmentsScreen extends StatefulWidget {
  @override
  _BulkShipmentsScreenState createState() => _BulkShipmentsScreenState();
}

class _BulkShipmentsScreenState extends State<BulkShipmentsScreen> {
  final AddBulkShipmentController controller = Get.put(AddBulkShipmentController());

  void addShipmentForm() {
    controller.addShipmentForm();
  }

  void toggleExpansion(int index) {
    controller.toggleExpansion(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'إضافة شحنات ',
        showSwitch: true,
        switchValue: true,
        onSwitchChanged: (value) {
          if (!value) {
            Get.back();
          }
        },
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.shipmentForms.length,
                    itemBuilder: (context, index) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => toggleExpansion(index),
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                                child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'شحنة ${index + 1}',
                                            style: CustomTextStyle.headlineTextStyle,
                                          ),
                                          Icon(controller.isExpandedList[index]
                                              ? Icons.expand_less
                                              : Icons.expand_more),
                                        ],
                                      ),
                                      if (controller.isExpandedList[index])
                                        ShipmentForm(index: index),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
              CustomSizedBox.itemSpacingVertical(),
              Container(
                width: 100.w,
                height: 13.h,
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90.w,
                        height: 7.h,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.printShipmentData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('إضافة الشحنات',
                              style: CustomTextStyle.greyTextStyle
                                  .apply(color: TColors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 4.w,
            bottom: 17.h,
            child: FloatingActionButton(
              onPressed: addShipmentForm,
              backgroundColor: TColors.primary,
              child: Icon(Icons.add, color: TColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ShipmentForm extends StatelessWidget {
  final int index;

  ShipmentForm({required this.index});

  @override
  Widget build(BuildContext context) {
    final AddBulkShipmentController controller = Get.find();
    TextEditingController recipientNameController = controller.recipientNameControllers[index];
    TextEditingController phoneController = controller.phoneControllers[index];
    TextEditingController addressController = controller.addressControllers[index];
    TextEditingController amountController = controller.amountControllers[index];
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
          hintText: 'رقم الهاتف',
          icon: Icons.phone,
          controller: phoneController,
          onChanged: (value) {
            controller.shipmentForms[index].recipientPhone = value;
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'العنوان',
          icon: Icons.location_on,
          controller: addressController,
          onChanged: (value) async {
            controller.shipmentForms[index].recipientAddress = value;
            if (value.isNotEmpty) {
              await controller.getsearch(value, index);
            }
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'المبلغ',
          icon: Icons.money,
          controller: amountController,
          onChanged: (value) {
            controller.shipmentForms[index].amount = value;
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'ملاحظات',
          icon: Icons.note,
          controller: notesController,
          onChanged: (value) {
            controller.shipmentForms[index].notes = value;
          },
        ),
      ],
    );
  }
}
