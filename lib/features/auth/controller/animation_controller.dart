import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimationShakeController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0.0),
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(animationController);
  }

  void startShakeAnimation() {
    animationController.forward().then((_) {
      animationController.reverse();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
