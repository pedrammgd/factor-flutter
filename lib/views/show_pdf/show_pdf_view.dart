import 'dart:typed_data';

import 'package:factor_flutter_mobile/controllers/show_pdf/show_pdf_controller.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfView extends GetView<ShowPdfController> {
  const ShowPdfView({Key? key}) : super(key: key);

  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;

    final pdfView = arguments['pdfView'];
    final isFromHome = arguments['isFromHome'];
    Get.lazyPut<ShowPdfController>(
        () => ShowPdfController(isFromHome: isFromHome, pdfView: pdfView));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return WillPopScope(
      onWillPop: () async {
        if (controller.isFromHome) {
          Get.back();
        } else {
          Get.offNamedUntil(FactorRoutes.home, (route) => false);
        }
        return true;
      },
      child: Scaffold(
        appBar: FactorAppBar(
            height: 70,
            hasBackButton: true,
            customBackButtonFunction: () {
              if (controller.isFromHome) {
                Get.back();
              } else {
                Get.offNamedUntil(FactorRoutes.home, (route) => false);
              }
            }),
        backgroundColor: Colors.white,
        body: SfPdfViewer.memory(
          controller.pdfView,
          enableDoubleTapZooming: false,
        ),
        //   PDFView(
        //   pdfData: controller.pdfView,
        //   nightMode: controller.isDark.value,
        // );
      ),
    );
  }

  Map arguments({required Uint8List pdfView, required bool isFromHome}) {
    final map = {};
    map['pdfView'] = pdfView;
    map['isFromHome'] = isFromHome;
    return map;
  }
}
