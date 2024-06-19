import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:shipment_merchent_app/features/auth/controller/personal_info_controller.dart';
import 'package:shipment_merchent_app/features/auth/screen/id_upload_screen.dart';
import '../../../controller/id_upload_controller.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IDUploadController controller = Get.find();

    return Column(
      children: [
        Obx(
              () => TButton(
            text: controller.isLoading.value ? 'جاري التحميل...' : 'متابعة',
            onPressed: () {
              controller.uploadIDImages();
            },
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
        TTextButton(
          text: 'رجوع',
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
