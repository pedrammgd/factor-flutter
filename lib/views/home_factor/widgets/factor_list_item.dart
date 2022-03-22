import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_card_home_widget.dart';
import 'package:factor_flutter_mobile/views/show_pdf/show_pdf_view.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class FactorListItem extends GetView<HomeFactorController> {
  const FactorListItem({required this.factorItem});

  final FactorHomeViewModel factorItem;

  @override
  Widget build(BuildContext context) {
    return FactorCardHomeWidget(
      factorDate: factorItem.dateFactor,
      factorNum: '${factorItem.numFactor} #',
      itemPopUp: controller.popUpItems,
      onSelectedPopUp: (value) async {
        if (value == Constants.showPopUp) {
          FocusManager.instance.primaryFocus?.unfocus();
          Get.toNamed(FactorRoutes.showPdf,
              arguments: const ShowPdfView().arguments(
                  pdfView: base64Decode(factorItem.uint8ListPdf),
                  isFromHome: true));
        } else if (value == Constants.savePopUp) {
          FocusManager.instance.primaryFocus?.unfocus();
          _savePdf(base64Decode(factorItem.uint8ListPdf));
        } else if (value == Constants.printPopUp) {
          FocusManager.instance.primaryFocus?.unfocus();
          await Printing.layoutPdf(
              onLayout: (_) =>
                  base64Decode(factorItem.uint8ListPdf).buffer.asUint8List());
        } else {
          FocusManager.instance.primaryFocus?.unfocus();
          final temp = await getTemporaryDirectory();
          final path = '${temp.path}/${factorItem.titleFactor}.pdf';
          File(path).writeAsBytesSync(base64Decode(factorItem.uint8ListPdf));
          Share.shareFiles([path], text: factorItem.titleFactor);
        }
      },
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Get.toNamed(FactorRoutes.showPdf,
            arguments: const ShowPdfView().arguments(
                pdfView: base64Decode(factorItem.uint8ListPdf),
                isFromHome: true));
      },
      title: factorItem.titleFactor,
    );
  }

  Future<void> _savePdf(Uint8List pdfView) async {
    if (kIsWeb) {
      await Printing.sharePdf(
        bytes: pdfView,
        filename: factorItem.titleFactor,
      );
    } else {
      MimeType type = MimeType.PDF;
      await FileSaver.instance
          .saveAs(factorItem.titleFactor, pdfView, "pdf", type);
    }
  }
}
