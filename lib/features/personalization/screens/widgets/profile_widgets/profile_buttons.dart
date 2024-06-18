import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/widgets/button.dart';
import '../../../../../common/widgets/text_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../auth/screen/login_screen.dart';
import '../../../controller/profile_controller.dart';

class ProfileButtons extends StatelessWidget {
  final ProfileController controller;

  const ProfileButtons({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TButton(
          text: 'حفظ',
          onPressed: () {
            controller.editProfile(
              controller.nameController.text,
              controller.phoneController.text,
              controller.businessNameController.text,
            );
          },
        ),
        TTextButton(
          text: 'تسجيل خروج',
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: Text(
                      'تأكيد تسجيل الخروج',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: TColors.primary,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    content: Text(
                      'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: TColors.darkGrey,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'إلغاء',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: TColors.primary,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        child: Text(
                          'تسجيل خروج',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.red,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove("isAuth");
                          FirebaseMessaging.instance
                              .unsubscribeFromTopic("merchant");
                          FirebaseMessaging.instance.unsubscribeFromTopic(
                              "merchant${prefs.getInt('user_id').toString()}");
                          Get.offAll(LoginScreen());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
