import 'dart:typed_data';

import 'package:get/get.dart';

class ShowPdfController extends GetxController {
  final Uint8List pdfView;
  final bool isFromHome;

  ShowPdfController({
    required this.pdfView,
    required this.isFromHome,
  });
}
