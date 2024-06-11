import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/label_text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/logo_image.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/number_counter.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/privacy_policy.dart';
import 'package:shipment_merchent_app/features/auth/controller/login_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/button.dart';
import '../../../common/widgets/text_field.dart';
import '../../../utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const LogoImage(),
            const LabelTextField(),
            Positioned(
              top: 47.h,
              child: TTextField(
                hintText: '-- --- --- 9 962+',
                suffixIcon: Icon(Icons.phone_android_outlined,
                    color: TColors.primary, size: 19.sp),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                onChanged: controller.updatePhoneNumber,
              ),
            ),
            NumberCounter(),
            PrivacyPolicy(),
            Positioned(
              bottom: 10.h,
              left: 2.w,
              child: Obx(
                () => TButton(
                  text: controller.isLoading.value
                      ? 'جاري التحميل...'
                      : 'تسجيل دخول',
                  onPressed: controller.login,
                ),
              ),
            ),
            Obx(
              () => controller.errorMessage.isNotEmpty
                  ? Positioned(
                      top: 55.h,
                      left: 2.w,
                      right: 2.w,
                      child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.right,
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
