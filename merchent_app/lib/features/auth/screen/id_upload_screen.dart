import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/id_upload_widgets/action_buttons_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/id_upload_widgets/header_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/id_upload_widgets/image_picker_back_widget.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/id_upload_widgets/image_picker_widget.dart';
import 'package:sizer/sizer.dart';
import '../controller/id_upload_controller.dart';

class IDUploadScreen extends StatelessWidget {
  final IDUploadController controller = Get.put(IDUploadController());

  IDUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      controller.setInitialImages(
        arguments['id_front_image'],
        arguments['id_back_image'],
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 6.5.h,
          left: 6.w,
          right: 6.w,
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            const HeaderWidget(),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () => controller.showImagePicker(context, true),
              child: const ImagePickerWidget(),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () => controller.showImagePicker(context, false),
              child: const ImagePickerBackWidget(),
            ),
            Spacer(),
            const ActionButtonsWidget(),
            SizedBox(height: 6.5.h),
          ],
        ),
      ),
    );
  }
}
