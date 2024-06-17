import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/personal_info_controller.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PersonalInfoController>();

    return Column(
      children: [
        Obx(
              () => TButton(
            text: controller.isLoading.value ? 'جاري التحميل...' : 'متابعة',
            onPressed: controller.submitPersonalInfo,
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
        Align(
          alignment: Alignment.center,
          child: TTextButton(
            text: 'رجوع',
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
