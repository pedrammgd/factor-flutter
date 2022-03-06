import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/custom_pdf_size/custom_pdf_size_view_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomPdfSizeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxList<String> paperSizeListText = <String>['A3', 'A4', 'A5'].obs;
  RxInt selectedPaper = 1.obs;

  Rxn<CustomPdfSizeViewModel> customPdfSize = Rxn<CustomPdfSizeViewModel>();

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadPdfPaperData();
  }

  void loadPdfPaperData() {
    String pdfPaperData =
        sharedPreferences.getString(customPdfSizeSharedPreferencesKey) ?? '';

    if (pdfPaperData.isNotEmpty) {
      customPdfSize.value =
          CustomPdfSizeViewModel.fromJson(jsonDecode(pdfPaperData));
      print(pdfPaperData);

      selectedPaper.value = customPdfSize.value!.pdfFormat;
    }
  }

  CustomPdfSizeViewModel get _customPdfSizeDto {
    return CustomPdfSizeViewModel(pdfFormat: selectedPaper.value);
  }

  void savePaperSizeData() {
    String paperSizeData = json.encode(_customPdfSizeDto.toJson());
    sharedPreferences.setString(
        customPdfSizeSharedPreferencesKey, paperSizeData);
  }
}
