import 'dart:convert';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_header/factor_header_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/models/my_profile_view_model/my_profile_view_model.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
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
    required List<SpecificationCostViewModel> excessCostList,
    required List<SpecificationCostViewModel> cartList,
    required List<SpecificationCostViewModel> cashList,
    required List<SpecificationCostViewModel> onlinePayList,
    required List<SpecificationCostViewModel> checkPayList,
    required String descriptionFactor,
  }) {
    String imageUint8ListCondition(
        {String? uint8List, required String defaultImage}) {
      if (uint8List == null || uint8List.isEmpty) {
        return defaultImage;
      } else {
        return uint8List;
      }
    }

    pw.MemoryImage imageCondition({
      String? uint8ListHaghighi,
      String? uint8ListHoghoghi,
      required String defaultImage,
    }) {
      if (myProfileItem.value != null) {
        if (myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
          return pw.MemoryImage(
            base64Decode(imageUint8ListCondition(
                uint8List: uint8ListHaghighi, defaultImage: defaultImage)),
          );
        } else {
          return pw.MemoryImage(
            base64Decode(imageUint8ListCondition(
                uint8List: uint8ListHoghoghi, defaultImage: defaultImage)),
          );
        }
      } else {
        return pw.MemoryImage(
          base64Decode(defaultImage),
        );
      }
    }

    bool _hasImage({
      String? image8ListHaghighi,
      String? iamgeUint8ListHoghoghi,
    }) {
      if (myProfileItem.value != null) {
        if (myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
          if (image8ListHaghighi == null || image8ListHaghighi.isEmpty) {
            return false;
          } else {
            return true;
          }
        } else {
          if (iamgeUint8ListHoghoghi == null ||
              iamgeUint8ListHoghoghi.isEmpty) {
            return false;
          } else {
            return true;
          }
        }
      } else {
        return true;
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

    String _nationalCode() {
      if (myProfileItem.value != null) {
        if (myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
          return myProfileItem
              .value!.personBasicInformationViewModel.nationalCode!;
        } else {
          return myProfileItem
              .value!.personBasicInformationViewModel.nationalCodeCompany!;
        }
      } else {
        return '-';
      }
    }

    String _nationalOwnerCodeKey() {
      if (myProfileItem.value != null) {
        if (myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
          return 'کد ملی : ';
        } else {
          return 'شناسه ملی : ';
        }
      } else {
        return 'کد ملی : ';
      }
    }

    String _nationalBuyerCodeKey() {
      if (buyerItem.value != null) {
        if (buyerItem.value!.personBasicInformationViewModel.isHaghighi) {
          return 'کد ملی : ';
        } else {
          return 'شناسه ملی : ';
        }
      } else {
        return 'کد ملی : ';
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

    bool _hasFactorDurationBefore() {
      if (factorHeaderViewModel.value != null) {
        if (factorHeaderViewModel.value!.isBeforeFactor) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    String factorDurationBefore() {
      if (factorHeaderViewModel.value != null) {
        if (factorHeaderViewModel.value!.isBeforeFactor) {
          return factorHeaderViewModel.value!.durationBeforeFactor! + ' روزه';
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
            _headerWidget(ownerAddress(), headerTitle(), ownerName(),
                _nationalCode(), _nationalOwnerCodeKey()),

            if (_hasImage(
                image8ListHaghighi: myProfileItem.value?.logoUint8List,
                iamgeUint8ListHoghoghi:
                    myProfileItem.value?.logoUint8ListHoghoghi))
              _logoImageWidget(imageCondition(
                  defaultImage: defaultLogo,
                  uint8ListHaghighi: myProfileItem.value?.logoUint8List,
                  uint8ListHoghoghi:
                      myProfileItem.value?.logoUint8ListHoghoghi)),
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
            secondValue: factorDurationBefore(),
            hasSecondKey: _hasFactorDurationBefore()),
        pw.SizedBox(height: 16),
        _informationSingleWidget(
            buyerFunction(
                nullName: ' - ',
                haghighiItem: buyerItem
                    .value?.personBasicInformationViewModel.nationalCode,
                hoghoghiItem: buyerItem.value?.personBasicInformationViewModel
                    .nationalCodeCompany),
            _nationalBuyerCodeKey()),
        pw.SizedBox(height: 16),
        _informationSingleWidget(
          buyerFunction(
              nullName: ' - ',
              haghighiItem:
                  buyerItem.value?.personBasicInformationViewModel.address,
              hoghoghiItem: buyerItem
                  .value?.personBasicInformationViewModel.addressHoghoghi),
          "آدرس : ",
        ),
        pw.SizedBox(height: 16),
        _gridTableWidget(factorUnofficialItemList),
        pw.SizedBox(height: 16),
        pw.Row(children: [
          pw.Expanded(
            child: _priceTableWidget(
                totalPrice: '$totalPrice'.replaceAll('-', '').seRagham(),
                totalTaxation: totalTaxation,
                totalDiscount: totalDiscount),
          ),
          pw.Expanded(
              child: pw.Column(
            children: [
              pw.SizedBox(height: 20),
              _descriptionTextWidget(descriptionFactor),
              pw.SizedBox(height: 15),
              _descriptionListPrice(
                  specificationCostList: excessCostList,
                  kindCost: 'هزینه مازاد ',
                  kindSerial: ' با عنوان '),
              _descriptionListPrice(
                  specificationCostList: cashList,
                  kindCost: 'پرداخت نقدی ',
                  kindSerial: ' با عنوان '),
              _descriptionListPrice(
                  specificationCostList: onlinePayList,
                  kindCost: 'پرداخت آنلاین ',
                  kindSerial: ' به شماره پیگیری'),
              _descriptionListPrice(
                  specificationCostList: cartList,
                  kindCost: 'پرداخت کارتی ',
                  kindSerial: ' به شماره پیگیری'),
              _descriptionListPrice(
                  specificationCostList: checkPayList,
                  kindCost: 'پرداخت چکی ',
                  kindSerial: ' به شماره سریال'),
            ],
          )),
        ]),
        pw.SizedBox(height: 32),
        _signatureAndSealWidget(
            imageCondition(
                defaultImage: defaultSignature,
                uint8ListHaghighi: myProfileItem.value?.signatureUint8List,
                uint8ListHoghoghi:
                    myProfileItem.value?.signatureUint8ListHoghoghi),
            imageCondition(
                defaultImage: defaultSeal,
                uint8ListHaghighi: myProfileItem.value?.sealUint8List,
                uint8ListHoghoghi: myProfileItem.value?.sealUint8ListHoghoghi),
            _hasImage(
                image8ListHaghighi: myProfileItem.value?.sealUint8List,
                iamgeUint8ListHoghoghi:
                    myProfileItem.value?.sealUint8ListHoghoghi),
            _hasImage(
                iamgeUint8ListHoghoghi:
                    myProfileItem.value?.signatureUint8ListHoghoghi,
                image8ListHaghighi: myProfileItem.value?.signatureUint8List)),
        pw.SizedBox(height: 20),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text('توسعه توسط اپلیکیشن فاکتور',
              style: const pw.TextStyle(fontSize: 5),
              textDirection: pw.TextDirection.rtl),
        ),
      ],
    );
  }

  pw.Widget _descriptionListPrice({
    required List<SpecificationCostViewModel> specificationCostList,
    required String kindCost,
    required String kindSerial,
  }) {
    return pw.ListView.builder(
      itemCount: specificationCostList.length,
      itemBuilder: (context, index) {
        return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 5),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(' ریال',
                  style: const pw.TextStyle(fontSize: 6),
                  textDirection: pw.TextDirection.rtl),
              pw.Text('${specificationCostList[index].price} ',
                  style: const pw.TextStyle(fontSize: 7),
                  textDirection: pw.TextDirection.rtl),
              pw.Text(' به مبلغ',
                  style: const pw.TextStyle(fontSize: 6),
                  textDirection: pw.TextDirection.rtl),
              pw.Text(' ${specificationCostList[index].title} ',
                  style: const pw.TextStyle(fontSize: 7),
                  textDirection: pw.TextDirection.rtl),
              pw.Text(kindSerial,
                  style: const pw.TextStyle(fontSize: 6),
                  textDirection: pw.TextDirection.rtl),
              pw.Text(kindCost,
                  style: const pw.TextStyle(fontSize: 6),
                  textDirection: pw.TextDirection.rtl),
              pw.Text(' - ',
                  style: const pw.TextStyle(fontSize: 6),
                  textDirection: pw.TextDirection.rtl),
            ],
          ),
        );
      },
    );
  }

  pw.Widget _signatureAndSealWidget(pw.MemoryImage signature,
      pw.MemoryImage seal, bool hasSeal, bool hasSignature) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        if (hasSignature)
          pw.Image(
            signature,
            height: 50,
            width: 50,
          ),
        pw.SizedBox(width: 20),
        if (hasSeal)
          pw.Image(
            seal,
            height: 50,
            width: 50,
          )
      ],
    );
  }

  pw.Widget _descriptionTextWidget(String descriptionFactor) {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        'توضیحات : $descriptionFactor',
        style: const pw.TextStyle(
          fontSize: 6,
        ),
        textDirection: pw.TextDirection.rtl,
      ),
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
          _tableRow(
              firstKey: 'مجموع )ریال(',
              firstValue: totalPrice,
              fontSizeKey: 8,
              fontSizeValue: 8),
        ],
      ),
    );
  }

  pw.TableRow _tableRow({
    required String firstKey,
    required String firstValue,
    double fontSizeValue = 6,
    double fontSizeKey = 6,
  }) {
    return pw.TableRow(children: [
      pw.Align(
        heightFactor: 3,
        alignment: pw.Alignment.center,
        child:
            pw.Text(firstValue, style: pw.TextStyle(fontSize: fontSizeValue)),
      ),
      // pw.Divider(thickness: 1),
      pw.Align(
        heightFactor: 3,
        alignment: pw.Alignment.center,
        child: pw.Text(firstKey, style: pw.TextStyle(fontSize: fontSizeKey)),
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

  pw.Widget _informationSingleWidget(String buyerFunction, String titleName) {
    return pw.Row(children: [
      pw.Expanded(
        child: pw.Text(
          buyerFunction,
          textDirection: pw.TextDirection.rtl,
          style: const pw.TextStyle(fontSize: 18),
        ),
      ),
      pw.Text(
        titleName,
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
    bool hasSecondKey = true,
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
        if (hasSecondKey)
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

  pw.Widget _headerWidget(String ownerAddress, String headerTitle,
      String ownerTitleName, String nationalCode, String nationalCodeKey) {
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
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Expanded(
              child: pw.Text(
                nationalCode,
                textDirection: pw.TextDirection.rtl,
                style: const pw.TextStyle(fontSize: 14),
              ),
            ),
            pw.Text(
              nationalCodeKey,
              textDirection: pw.TextDirection.rtl,
              style: const pw.TextStyle(fontSize: 16),
            ),
          ]),
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
