import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_header/factor_header_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/models/my_profile_view_model/my_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomPdfWidget {
  pw.Widget pdfWidget({
    required Rxn<MyProfileViewModel> myProfileItem,
    required RxList<FactorUnofficialItemViewModel> factorUnofficialItemList,
    required Rxn<FactorHeaderViewModel> factorHeaderViewModel,
    required Rxn<BuyerViewModel> buyerItem,
    required int statusFactor,
    required String totalTaxation,
    required String totalDiscount,
    required double totalPrice,
  }) {
    String imageUint8ListCondition({String? uint8List}) {
      if (uint8List == null || uint8List.isEmpty) {
        return defaultLogo;
      } else {
        return uint8List;
      }
    }

    pw.MemoryImage imageCondition({
      String? uint8ListHaghighi,
      String? uint8ListHoghoghi,
    }) {
      if (myProfileItem.value != null) {
        if (myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
          return pw.MemoryImage(
            base64Decode(imageUint8ListCondition(uint8List: uint8ListHaghighi)),
          );
        } else {
          return pw.MemoryImage(
            base64Decode(imageUint8ListCondition(uint8List: uint8ListHoghoghi)),
          );
        }
      } else {
        return pw.MemoryImage(
          base64Decode(defaultLogo),
        );
      }
    }

    String ownerName() {
      if (myProfileItem.value != null) {
        if (myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
          return myProfileItem.value!.personBasicInformationViewModel.fullName!;
        } else {
          return myProfileItem
              .value!.personBasicInformationViewModel.companyName!;
        }
      } else {
        return 'نام فروشنده';
      }
    }

    String ownerAddress() {
      if (myProfileItem.value != null) {
        if (myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
          return myProfileItem.value!.personBasicInformationViewModel.address!;
        } else {
          return myProfileItem
              .value!.personBasicInformationViewModel.addressHoghoghi!;
        }
      } else {
        return 'آدرس از قسمت مشخصات من قبل حذف یا ویرایش می باشد';
      }
    }

    String buyerFunction({
      String? haghighiItem,
      String? hoghoghiItem,
      required String nullName,
    }) {
      if (buyerItem.value != null) {
        if (buyerItem.value!.personBasicInformationViewModel.isHaghighi) {
          return haghighiItem!;
        } else {
          return hoghoghiItem!;
        }
      } else {
        return nullName;
      }
    }

    String headerTitle() {
      if (factorHeaderViewModel.value != null) {
        return factorHeaderViewModel.value!.title;
      } else {
        return 'فاکتور فروش';
      }
    }

    String factorNumber() {
      if (factorHeaderViewModel.value != null) {
        return factorHeaderViewModel.value!.factorNum;
      } else {
        return '1';
      }
    }

    String factorDate() {
      if (factorHeaderViewModel.value != null) {
        return factorHeaderViewModel.value!.factorDate;
      } else {
        return Jalali.now().formatCompactDate();
      }
    }

    String factorDurationBefore() {
      if (factorHeaderViewModel.value != null) {
        if (factorHeaderViewModel.value!.isBeforeFactor) {
          return factorHeaderViewModel.value!.durationBeforeFactor!;
        } else {
          return '';
        }
      } else {
        return '-';
      }
    }

    String _statusFactorFunction() {
      if (statusFactor == 0) {
        return 'تسویه نشده';
      } else if (statusFactor == 1) {
        return 'بستانکار';
      } else {
        return 'تسویه شده';
      }
    }

    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            // _barcodeWidget(),
            _headerWidget(ownerAddress(), headerTitle(), ownerName()),
            _logoImageWidget(imageCondition(
                uint8ListHaghighi: myProfileItem.value?.logoUint8List,
                uint8ListHoghoghi: myProfileItem.value?.logoUint8ListHoghoghi)),
          ],
        ),
        pw.SizedBox(height: 16),
        pw.Divider(thickness: 2),
        pw.SizedBox(height: 16),
        _informationRowWidget(
          firstKey: "طرف حساب : ",
          secondKey: "شماره فاکتور : ",
          firstValue: buyerFunction(
              nullName: 'نام مشتری',
              haghighiItem:
                  buyerItem.value?.personBasicInformationViewModel.fullName,
              hoghoghiItem:
                  buyerItem.value?.personBasicInformationViewModel.companyName),
          secondValue: factorNumber(),
        ),
        pw.SizedBox(height: 16),
        _informationRowWidget(
            firstKey: 'شماره تماس : ',
            firstValue: buyerFunction(
                nullName: '-',
                hoghoghiItem: buyerItem.value?.personBasicInformationViewModel
                    .mobileNumberHoghoghi,
                haghighiItem: buyerItem
                    .value?.personBasicInformationViewModel.mobileNumber),
            secondKey: 'وضعیت : ',
            secondValue: _statusFactorFunction()),
        pw.SizedBox(height: 16),
        _informationRowWidget(
            firstKey: 'تاریخ فاکتور : ',
            firstValue: factorDate(),
            secondKey: 'مدت اعتبار : ',
            secondValue: factorDurationBefore()),
        pw.SizedBox(height: 16),
        _addressWidget(buyerFunction(
            nullName: ' - ',
            haghighiItem:
                buyerItem.value?.personBasicInformationViewModel.address,
            hoghoghiItem: buyerItem
                .value?.personBasicInformationViewModel.addressHoghoghi)),
        pw.SizedBox(height: 16),
        _gridTableWidget(factorUnofficialItemList),
        pw.SizedBox(height: 16),
        pw.Row(children: [
          pw.Expanded(
            child: _priceTableWidget(
                totalPrice: '$totalPrice'.seRagham(),
                totalTaxation: totalTaxation,
                totalDiscount: totalDiscount),
          ),
          pw.Expanded(
              child: pw.Column(
            children: [
              pw.SizedBox(height: 20),
              _descriptionTextWidget(),
              pw.SizedBox(height: 15),
              _signatureAndSealWidget(
                  imageCondition(
                      uint8ListHaghighi:
                          myProfileItem.value?.signatureUint8List,
                      uint8ListHoghoghi:
                          myProfileItem.value?.signatureUint8ListHoghoghi),
                  imageCondition(
                      uint8ListHaghighi: myProfileItem.value?.sealUint8List,
                      uint8ListHoghoghi:
                          myProfileItem.value?.sealUint8ListHoghoghi)),
            ],
          )),
        ]),
      ],
    );
  }

  pw.Widget _signatureAndSealWidget(
      pw.MemoryImage signature, pw.MemoryImage seal) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Image(
          signature,
          height: 50,
          width: 50,
        ),
        pw.SizedBox(width: 20),
        pw.Image(
          seal,
          height: 50,
          width: 50,
        )
      ],
    );
  }

  pw.Widget _descriptionTextWidget() {
    return pw.Text(
      'توضیحات : سصیخربسصخیذرخذدرخبسصدرسبخرذسذررذسزعتسزذاینزذنیسذزاهیسرزیذزتیسزدسیذزنا سیتزاذیمتزدسیناز یتزن',
      style: const pw.TextStyle(
        fontSize: 6,
      ),
      textDirection: pw.TextDirection.rtl,
    );
  }

  pw.Widget _priceTableWidget({
    required String totalPrice,
    required String totalTaxation,
    required String totalDiscount,
  }) {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Table(
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          _tableRow(firstKey: 'تخفیف', firstValue: totalDiscount),
          _tableRow(firstKey: 'مالیات', firstValue: totalTaxation),
          _tableRow(firstKey: 'مجموع', firstValue: '$totalPrice ریال'),
        ],
      ),
    );
  }

  pw.TableRow _tableRow({
    required String firstKey,
    required String firstValue,
  }) {
    return pw.TableRow(children: [
      pw.Align(
        heightFactor: 3,
        alignment: pw.Alignment.center,
        child: pw.Text(firstValue, style: const pw.TextStyle(fontSize: 6)),
      ),
      // pw.Divider(thickness: 1),
      pw.Align(
        heightFactor: 3,
        alignment: pw.Alignment.center,
        child: pw.Text(firstKey, style: const pw.TextStyle(fontSize: 6)),
      ),
    ]);
  }

  pw.Widget _gridTableWidget(
      RxList<FactorUnofficialItemViewModel> factorUnofficialItemList) {
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Table.fromTextArray(
        cellAlignment: pw.Alignment.center,
        headers: [
          'قیمت کل )ریال(',
          'مالیات )درصد(',
          'تخفیف )درصد(',
          'مبلغ )ریال(',
          'تعداد',
          'نام'
        ],
        data: factorUnofficialItemList
            .map((e) => [
                  '${e.totalPriceItem}'.seRagham(),
                  e.productTaxation,
                  e.productDiscount,
                  e.productUnitPrice.seRagham(),
                  e.productCount,
                  e.productDescription,
                ])
            .toList(),
      ),
    );
  }

  pw.Widget _addressWidget(String buyerFunction) {
    return pw.Row(children: [
      pw.Expanded(
        child: pw.Text(
          buyerFunction,
          textDirection: pw.TextDirection.rtl,
          style: const pw.TextStyle(fontSize: 18),
        ),
      ),
      pw.Text(
        " آدرس : ",
        textDirection: pw.TextDirection.rtl,
        style: const pw.TextStyle(fontSize: 18),
      ),
    ]);
  }

  pw.Widget _informationRowWidget({
    required String firstKey,
    required String firstValue,
    required String secondKey,
    required String secondValue,
  }) {
    return pw.Row(children: [
      pw.Expanded(
          child: pw.Row(children: [
        pw.Expanded(
          child: pw.Text(
            secondValue,
            textDirection: pw.TextDirection.rtl,
            style: const pw.TextStyle(fontSize: 18),
          ),
        ),
        pw.Expanded(
            child: pw.Text(
          secondKey,
          textDirection: pw.TextDirection.rtl,
          style: const pw.TextStyle(fontSize: 17),
        )),
      ])),
      pw.Expanded(
        child: pw.Row(children: [
          pw.Expanded(
            child: pw.Text(
              firstValue,
              textDirection: pw.TextDirection.rtl,
              style: const pw.TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              firstKey,
              textDirection: pw.TextDirection.rtl,
              style: const pw.TextStyle(fontSize: 17),
            ),
          ),
        ]),
      ),
    ]);
  }

  pw.Widget _headerWidget(
      String ownerAddress, String headerTitle, String ownerTitleName) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          pw.Text(
            headerTitle,
            textDirection: pw.TextDirection.rtl,
            style: const pw.TextStyle(fontSize: 25),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            ownerTitleName,
            textDirection: pw.TextDirection.rtl,
            style: const pw.TextStyle(fontSize: 17),
          ),
          pw.SizedBox(height: 12),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Expanded(
              child: pw.Text(
                ownerAddress,
                textDirection: pw.TextDirection.rtl,
                style: const pw.TextStyle(fontSize: 14),
              ),
            ),
            pw.Text(
              "آدرس  :  ",
              textDirection: pw.TextDirection.rtl,
              style: const pw.TextStyle(fontSize: 16),
            ),
          ]),
        ],
      ),
    );
  }

  pw.Widget _barcodeWidget() {
    return pw.Container(
        width: 50, height: 50, color: PdfColor.fromHex('#32a852'));
  }

  pw.Widget _logoImageWidget(pw.MemoryImage logo) {
    return pw.Expanded(
      child: pw.ClipRRect(
        horizontalRadius: 20,
        verticalRadius: 20,
        child: pw.Image(
          logo,
          height: 100,
          width: 100,
          fit: pw.BoxFit.contain,
        ),
      ),
    );
  }
}
