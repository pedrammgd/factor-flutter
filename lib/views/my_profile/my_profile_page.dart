import 'package:factor_flutter_mobile/controllers/my_profile/my_profile_controller.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MyProfilePage extends GetView<MyProfileController> {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
    return Scaffold(
      appBar: FactorAppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'مشخصات من',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  enabled: !controller.isLegal.value,
                  loop: controller.loopLegal.value,
                  baseColor: Colors.black,
                  highlightColor: Colors.white,
                  child: const Text(
                    'حقیقی',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 1.2,
                  child: Switch(
                    activeColor: Colors.black,
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.black45,
                    value: controller.isLegal.value,
                    onChanged: (value) {
                      controller.isLegal.value = value;
                    },
                  ),
                ),
                Shimmer.fromColors(
                  enabled: controller.isLegal.value,
                  loop: controller.loopLegal.value,
                  baseColor: Colors.black,
                  highlightColor: Colors.white,
                  child: const Text(
                    'حقوقی',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
