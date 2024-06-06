import 'package:get/get.dart';

class ShipmentsController extends GetxController {
  var selectedFilterIndex = 0.obs;

  void setSelectedFilterIndex(int index) {
    selectedFilterIndex.value = index;
  }
}
