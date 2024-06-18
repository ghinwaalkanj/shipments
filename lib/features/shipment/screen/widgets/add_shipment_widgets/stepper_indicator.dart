import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
//
import '../../../../../utils/constants/colors.dart';

class CircularStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const CircularStepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = currentStep / totalSteps;

    return CircularPercentIndicator(
      radius: 28.sp,
      lineWidth: 2.5.sp,
      percent: percentage,
      center: Text(
        '$currentStep من $totalSteps',
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      progressColor: TColors.primary,
      backgroundColor: TColors.white,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
