import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipment_text_field.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/button.dart';

class BulkShipmentsScreen extends StatefulWidget {
  @override
  _BulkShipmentsScreenState createState() => _BulkShipmentsScreenState();
}

class _BulkShipmentsScreenState extends State<BulkShipmentsScreen> {
  List<ShipmentForm> shipmentForms = [ShipmentForm(index: 0)];
  List<bool> isExpandedList = [true]; // To control the expansion state

  void addShipmentForm() {
    setState(() {
      // Collapse all existing forms
      for (int i = 0; i < isExpandedList.length; i++) {
        isExpandedList[i] = false;
      }
      // Add new form and expand it
      shipmentForms.add(ShipmentForm(index: shipmentForms.length));
      isExpandedList.add(true);
    });
  }

  void toggleExpansion(int index) {
    setState(() {
      for (int i = 0; i < isExpandedList.length; i++) {
        if (i == index) {
          isExpandedList[i] = !isExpandedList[i];
        } else {
          isExpandedList[i] = false;
        }
      }
    });
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
                child: ListView.builder(
                  itemCount: shipmentForms.length,
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
                                        Icon(isExpandedList[index]
                                            ? Icons.expand_less
                                            : Icons.expand_more),
                                      ],
                                    ),
                                    if (isExpandedList[index]) shipmentForms[index],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
                          onPressed: () {},
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
    TextEditingController recipientNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController notesController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'اسم العميل',
          icon: Icons.person,
          controller: recipientNameController,
          onChanged: (value) {
            // Handle value change if needed
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'رقم الهاتف',
          icon: Icons.phone,
          controller: phoneController,
          onChanged: (value) {
            // Handle value change if needed
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'العنوان',
          icon: Icons.location_on,
          controller: addressController,
          onChanged: (value) {
            // Handle value change if needed
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'المبلغ',
          icon: Icons.money,
          controller: amountController,
          onChanged: (value) {
            // Handle value change if needed
          },
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'ملاحظات',
          icon: Icons.note,
          controller: notesController,
          onChanged: (value) {
            // Handle value change if needed
          },
        ),
      ],
    );
  }
}
