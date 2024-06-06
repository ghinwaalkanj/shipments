import 'package:get/get.dart';

import '../core/integration/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud()) ;
  }
}
