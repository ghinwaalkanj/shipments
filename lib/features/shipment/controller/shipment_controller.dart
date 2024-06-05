import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';

import '../screen/shipment2_screen.dart';
import '../screen/shipment3_screen.dart';

class ShipmentController extends GetxController {
  var currentStep = 1.obs;

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
      navigateToCurrentStep();
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
      navigateToCurrentStep();
    }
  }

  void navigateToCurrentStep() {
    if (currentStep.value == 1) {
      Get.to(() => ShipmentStep1Screen());
    } else if (currentStep.value == 2) {
      Get.to(() => ShipmentStep2Screen());
    } else if (currentStep.value == 3) {
      Get.to(() => ShipmentStep3Screen());
    }
  }
}
