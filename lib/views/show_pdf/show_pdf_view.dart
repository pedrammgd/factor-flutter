import 'dart:typed_data';

import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfView extends StatelessWidget {
  const ShowPdfView({Key? key, required this.pdfView}) : super(key: key);

  final Uint8List pdfView;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamedUntil(FactorRoutes.home, (route) => false);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white, body: SfPdfViewer.memory(pdfView)),
      ),
    );
  }
}
