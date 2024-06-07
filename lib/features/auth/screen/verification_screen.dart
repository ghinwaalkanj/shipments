import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shipment_merchent_app/features/auth/screen/personal_info_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/button.dart';
import '../../../utils/constants/colors.dart';
import '../controller/verify_controller.dart';

class VerifyScreen extends StatefulWidget {
  VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> with SingleTickerProviderStateMixin {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0.0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_animationController);
  }

  // Default Pin Theme
  final defaultPinTheme = PinTheme(
    width: 13.w,
    height: 6.h,
    textStyle: TextStyle(
      fontSize: 15.sp,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: TColors.primary),
    ),
  );

  // Error Pin Theme
  final errorPinTheme = PinTheme(
    width: 13.w,
    height: 6.h,
    textStyle: TextStyle(
      fontSize: 15.sp,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.red),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.put(VerifyController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Ensures the body resizes when the keyboard appears
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              right: 6.w,
              left: 6.w,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5.h,
                        left: 10.w,
                        child: Image(
                          image: AssetImage("assets/images/sammy-line-man-receives-a-mail 1.png"),
                          height: 38.h,
                        ),
                      ),
                      Positioned(
                        top: 48.h,
                        left: 18.w,
                        child: Text(
                          '!التحقق من رقم هاتفك',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: TColors.primary,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 53.h,
                        left: 4.5.w,
                        child: Obx(
                              () => Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'تهانينا! قم بالتحقق من رقم هاتفك عن طريق إدخال \n رمز التحقق الذي تم إرساله إليك\n',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: TColors.grey,
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: "${controller.phoneNumber}",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: TColors.darkGrey,
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 67.h,
                        left: 6.w,
                        right: 6.w,
                        child: Form(
                          key: formKey,
                          child: SlideTransition(
                            position: _offsetAnimation,
                            child: Pinput(
                              length: 5,
                              controller: pinController,
                              focusNode: focusNode,
                              androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                              listenForMultipleSmsOnAndroid: true,
                              separatorBuilder: (index) => const SizedBox(width: 8),
                              validator: (value) {

                                if (value == controller.verificationCode.toString()) {
                                  controller.isLoading.value ? null : controller.verifyCode;
                                } else {
                                  _animationController.forward().then((value) {
                                    _animationController.reverse();
                                  });
                                  return 'رمز التحقق غير صحيح';
                                }
                              },
                              hapticFeedbackType: HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                              },
                              onChanged: (value) {
                                debugPrint('onChanged: $value');
                                controller.updateCode(value);
                              },
                              defaultPinTheme: defaultPinTheme,
                              errorPinTheme: errorPinTheme,
                              errorTextStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 11.sp,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 2.w,
                        child: Obx(
                              () => TButton(
                            text: controller.isLoading.value ? 'جاري التحقق...' : 'متابعة',
                            onPressed: controller.isLoading.value ? null : controller.verifyCode,
                          ),
                        ),
                      ),
                      Obx(
                            () => Positioned(
                          top: 55.h,
                          left: 2.w,
                          right: 2.w,
                          child: controller.errorMessage.value.isNotEmpty
                              ? Text(
                            controller.errorMessage.value,
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.left,
                          )
                              : Container(),
                        ),
                      ),
                      Obx(
                            () => Positioned(
                          bottom: 6.5.h,
                          right: 3.w,
                          child: Row(
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero, // Remove padding
                                  minimumSize: Size(0, 0), // Ensure no minimum size
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink the tap target
                                ),
                                onPressed: () {},
                                child: Text(
                                  'أعد الإرسال الآن',
                                  style: TextStyle(
                                    color: TColors.primary,
                                    fontSize: 8.5.sp,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                '. إعادة إرسال الرمز خلال${controller.resendCountdown.value} ثانية',
                                style: TextStyle(
                                  color: TColors.grey,
                                  fontSize: 8.5.sp,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: VerifyScreen(),
  ));
}
