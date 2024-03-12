import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController

  final controllerOnboarding = PageController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void increment() => count.value++;
}
