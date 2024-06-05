import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/login_controller.dart';

class NumberCounter extends StatelessWidget {
  const NumberCounter({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Positioned(
      top: 55.h,
      left: 2.w,
      child: Obx(() => Text(
        '${controller.phoneNumber.value.length}/10',
        style: TextStyle(
          fontSize: 10.sp,
          color: Colors.grey,
        ),
      ),),
    );
  }
}
