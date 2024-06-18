import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bulk_shipment/button_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bulk_shipment/shipment_form.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../common/widgets/app_bar.dart';
import '../controller/bulk_shipments_controller.dart';

class BulkShipmentsScreen extends StatelessWidget {
  final AddBulkShipmentController controller = Get.put(AddBulkShipmentController());

  void addShipmentForm() {
    controller.addShipmentForm();
  }

  void toggleExpansion(int index) {
    controller.toggleExpansion(index);
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تأكيد الحذف',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Cairo',
            ),
          ),
          content: Text(
            'هل أنت متأكد أنك تريد حذف الشحنة؟',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Cairo',
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'إلغاء',
                style: TextStyle(
                  color: TColors.primary,
                  fontFamily: 'Cairo',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'نعم',
                style: TextStyle(
                  color: TColors.primary,
                  fontFamily: 'Cairo',
                ),
              ),
              onPressed: () {
                controller.removeShipmentForm(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                              child: Container(
                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 3.w),
                                child: Padding(
                                  padding: EdgeInsets.all(15.sp),
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
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.delete, color: TColors.error),
                                                onPressed: () => showDeleteDialog(context, index),
                                              ),
                                              Icon(controller.isExpandedList[index]
                                                  ? Icons.expand_less
                                                  : Icons.expand_more),
                                            ],
                                          ),
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
              ButtonContainer(controller: controller),
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
