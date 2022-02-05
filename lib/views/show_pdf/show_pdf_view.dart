import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfView extends StatelessWidget {
  const ShowPdfView({Key? key, required this.pdfView}) : super(key: key);

  final Uint8List pdfView;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white, body: SfPdfViewer.memory(pdfView)),
    );
  }
}
