import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/button.dart';
import '../../../controller/verify_controller.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.find();

    return Obx(
          () => TButton(
        text: controller.isLoading.value ? 'جاري التحقق...' : 'متابعة',
        onPressed: controller.verifyCode,
      ),
    );
  }
}
