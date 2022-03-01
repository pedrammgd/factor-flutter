import 'dart:convert';

import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_card_home_widget.dart';
import 'package:factor_flutter_mobile/views/show_pdf/show_pdf_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorListItem extends GetView<HomeFactorController> {
  const FactorListItem({required this.factorItem});

  final FactorHomeViewModel factorItem;

  @override
  Widget build(BuildContext context) {
    return FactorCardHomeWidget(
      factorDate: factorItem.dateFactor,
      factorNum: '${factorItem.numFactor} #',
      editOnTap: () {
        Get.to(ShowPdfView(pdfView: base64Decode(factorItem.uint8ListPdf)));
      },
      title: factorItem.titleFactor,
      removeOnTap: () {
        controller.factorHomeList.remove(factorItem);
      },
    );
  }
}
