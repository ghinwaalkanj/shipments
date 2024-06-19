import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: TColors.grey,
            height: 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'أو',
            style: CustomTextStyle.greyTextStyle.apply(color: TColors.black),
          ),
        ),
        const Expanded(
          child: Divider(
            color: TColors.grey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
