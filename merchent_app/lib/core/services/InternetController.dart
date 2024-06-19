import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import '../../utils/constants/colors.dart';
import 'checkinternet.dart';

class InternetController extends GetxController {
  var isConnected = true.obs;
  final InternetService _internetService = InternetService();
  var wasDisconnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
  }

  Future<void> checkConnection() async {
    bool status = await _internetService.isConnected();
    if (status != isConnected.value) {
      isConnected.value = status;
      updateStatusBar();
    }
    // Check connection periodically, e.g., every 5 seconds
    Future.delayed(Duration(seconds: 5), checkConnection);
  }

  void updateStatusBar() async {
    if (isConnected.value) {
      if (wasDisconnected.value) {
        FlutterStatusbarcolor.setStatusBarColor(TColors.success);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        wasDisconnected.value = false;
        // Wait for 2 seconds before resetting the status bar color
        await Future.delayed(Duration(seconds: 2));
        FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      }
    } else {
      FlutterStatusbarcolor.setStatusBarColor(TColors.error);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      wasDisconnected.value = true;
    }
  }
}
