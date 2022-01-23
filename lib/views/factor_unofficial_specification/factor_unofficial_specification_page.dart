import 'package:factor_flutter_mobile/controllers/factor_unofficial_specification/factor_unofficial_specification_controller.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorUnofficialSpecificationPage
    extends GetView<FactorUnofficialSpecificationController> {
  const FactorUnofficialSpecificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FactorUnofficialSpecificationController());
    return const Scaffold(
      appBar: FactorAppBar(),
    );
  }
}
