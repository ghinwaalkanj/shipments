import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class SummaryContainer extends StatelessWidget {
  final Map<String, String> data;

  const SummaryContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: TColors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: data.keys.map((key) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    key,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.greyTextStyle.apply(
                      color: TColors.black,
                      fontWeightDelta: 0,
                      fontSizeFactor: 1.1,  // زيادة حجم الخط قليلاً
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: data.values.map((value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.greyTextStyle.apply(
                        color: TColors.black,
                        fontWeightDelta: 1,
                        fontSizeFactor: 1.1,  // زيادة حجم الخط قليلاً
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
