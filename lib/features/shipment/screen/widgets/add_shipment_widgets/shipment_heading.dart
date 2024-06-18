import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/stepper_indicator.dart';
import 'package:sizer/sizer.dart';
//
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';

class ShipmentHeading extends StatelessWidget {
  const ShipmentHeading({
    super.key,
    required this.title,
    this.subtitle,
    required this.currentStep,
  });

  final String title;
  final String? subtitle;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 7.w),
      child: Row(
        children: [
          CircularStepIndicator(
            currentStep: currentStep,
            totalSteps: 3,
          ),
          CustomSizedBox.itemSpacingHorizontal(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CustomTextStyle.headlineTextStyle
                    .apply(color: TColors.primary, fontSizeFactor: 1.1),
              ),
              if (subtitle != null) // Check if subtitle is not null
                Text(
                  subtitle!,
                  style: CustomTextStyle.greyTextStyle
                      .apply(fontSizeFactor: 0.8, fontWeightDelta: 1),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
