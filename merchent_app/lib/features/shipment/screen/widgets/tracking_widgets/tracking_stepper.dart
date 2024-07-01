import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../Qr_code/screen/Qr_code_display_screen.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../controller/tracking_controller.dart';
import '../add_shipment_widgets/shipment_text_field.dart';

class TrackingStepper extends StatelessWidget {
  final int status;
  final String? subtitle;
  final String? shipmentNumber;
  final VoidCallback? onContactPressed;

  TrackingStepper({
    required this.status,
    this.subtitle,
    this.shipmentNumber,
    this.onContactPressed,
  });

  Color getColor(int index) {
    if (status == 0) return TColors.grey;
    if (status >= index) return TColors.primary;
    return TColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final TrackingController controller = Get.find<TrackingController>();

    List<Map<String, String>> steps = [
      {'title': 'بانتظار القبول'},
      {'title': 'تم قبول الشحنة'},
      {'title': 'في الطريق إليك'},
      {'title': 'المندوب بالقرب منك'},
      {'title': 'تم تسليم الشحنة للمندوب'},
      {'title': 'في الطريق للزبون'},
      {'title': 'المندوب بالقرب من الزبون'},
      {'title': 'تم التسليم للزبون'},
    ];

    if (status == 8 || status == 9) {
      steps.add({'title': 'تم الإرجاع للتاجر'});
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(steps.length, (index) {
                    int stepIndex = index + 1;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 24.sp,
                              height: 24.sp,
                              decoration: BoxDecoration(
                                color: status >= stepIndex - 1
                                    ? TColors.primary
                                    : TColors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: status >= stepIndex - 1
                                    ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16.sp,
                                )
                                    : Container(),
                              ),
                            ),
                            if (stepIndex != steps.length)
                              Container(
                                width: 2,
                                height: 4.h,
                                color: getColor(stepIndex + 1),
                              ),
                          ],
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                steps[index]['title']!,
                                style: CustomTextStyle.headlineTextStyle.apply(
                                  fontSizeDelta: -2.sp,
                                  color: TColors.primary,
                                ),
                              ),
                              Text(
                                subtitle == null ? '' : subtitle!,
                                style: CustomTextStyle.greyTextStyle,
                              ),
                            ],
                          ),
                        ),
                        if (steps[index]['title'] == 'تم قبول الشحنة' ||
                            steps[index]['title'] == 'المندوب بالقرب منك')
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Column(
                              children: [
                                if (steps[index]['title'] == 'تم قبول الشحنة')
                                  IconButton(
                                    color: status >= 1
                                        ? TColors.primary
                                        : TColors.buttonDisabled,
                                    onPressed:
                                    status >= 1 ? onContactPressed : null,
                                    icon: Icon(Icons.phone),
                                  ),
                                if (steps[index]['title'] ==
                                    'المندوب بالقرب منك')
                                  IconButton(
                                    color: status == 3
                                        ? TColors.primary
                                        : TColors.buttonDisabled,
                                    onPressed: () {
                                      if (steps[index]['title'] ==
                                          'المندوب بالقرب منك' &&
                                          status == 3) {
                                        Get.to(
                                          QrCodeDisplayScreen(
                                            shipmentNumber: shipmentNumber!,
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.qr_code),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
          Container(
            width: 90.w,
            height: 8.h,
            padding: EdgeInsets.only(bottom: 1.h),
            decoration: BoxDecoration(
              color:
              (status == 7 || status == 9) ? TColors.primary : TColors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: (status == 7 || status == 9)
                  ? () => _showRatingDialog(context, controller)
                  : null,
              child: Text(
                'قيم المندوب',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context, TrackingController controller) {
    double rating = 0;
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'قيم المندوب',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: TColors.primary,
                ),
                onRatingUpdate: (ratingValue) {
                  rating = ratingValue;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ShipmentTextField(
                  hintText: 'أضف تعليقك',
                  icon: Icons.comment,
                  controller: commentController,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.rateDelivery(rating, commentController.text);
                Navigator.of(context).pop();
              },
              child: Text(
                'إرسال',
                style: TextStyle(
                  color: TColors.primary,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
