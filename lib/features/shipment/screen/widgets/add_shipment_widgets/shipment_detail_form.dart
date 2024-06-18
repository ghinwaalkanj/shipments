import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/shipment_text_field.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
//
class ShipmentDetailsForm extends StatelessWidget {
  final TextEditingController shipmentTypeController;
  final TextEditingController shipmentWeightController;
  final TextEditingController shipmentQuantityController;
  final TextEditingController shipmentValueController;

  ShipmentDetailsForm({
    required this.shipmentTypeController,
    required this.shipmentWeightController,
    required this.shipmentQuantityController,
    required this.shipmentValueController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShipmentTextField(
          hintText: 'نوع الشحنة',
          icon: Icons.category,
          controller: shipmentTypeController,
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'وزن الشحنة (كغ)',
          icon: Icons.line_weight,
          controller: shipmentWeightController,
          keyboardType: TextInputType.phone,
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'عدد الشحنات',
          icon: Icons.format_list_numbered,
          controller: shipmentQuantityController,
          keyboardType: TextInputType.phone,
        ),
        CustomSizedBox.itemSpacingVertical(),
        ShipmentTextField(
          hintText: 'قيمة الشحنة (\$)',
          icon: Icons.attach_money,
          controller: shipmentValueController,
          keyboardType: TextInputType.phone,

        ),
      ],
    );
  }
}





