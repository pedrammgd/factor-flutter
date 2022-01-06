import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorBaseController extends GetxController {
  RxInt currentIndex = 0.obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
