import 'dart:typed_data';

import 'package:factor_flutter_mobile/controllers/signature_bottom_sheet/signature_bottom_sheet_controller.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class SignatureBottomSheet extends GetView<SignatureBottomSheetController> {
  const SignatureBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SignatureBottomSheetController>(
        () => SignatureBottomSheetController());
    return WillPopScope(
      onWillPop: () async {
        controller.signatureController.clear();
        return true;
      },
      child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _topDivider(context),
            if (controller.showClearButton.value)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 30, end: 30),
                  child: IconButton(
                    icon: const Icon(
                      Icons.cleaning_services_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      controller.signatureController.clear();
                    },
                  ),
                ),
              ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Signature(
                  controller: controller.signatureController,
                  backgroundColor: Colors.white,
                  height: 300,
                ),
                if (!controller.showClearButton.value)
                  const Text(
                    'روی صفحه امضا کن',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    bottom: 20, end: 20, start: 20),
                child: FactorButton(
                  borderColor: Colors.black,
                  textColor: Colors.black,
                  onPressed: () async {
                    if (controller.signatureController.isNotEmpty) {
                      final signature = await exportSignature();
                      Navigator.pop(context, signature);
                      controller.signatureController.clear();
                    }
                  },
                  titleButton: 'افزودن',
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _topDivider(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: const EdgeInsetsDirectional.all(15),
        height: 3,
        width: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Future<Uint8List> exportSignature() async {
    final exportSignatureController = SignatureController(
        points: controller.signatureController.points, penColor: Colors.black);
    final signature = await exportSignatureController.toPngBytes();
    exportSignatureController.dispose();
    return signature!;
  }
}
