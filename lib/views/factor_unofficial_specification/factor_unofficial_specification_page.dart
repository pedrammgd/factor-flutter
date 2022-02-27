import 'dart:typed_data';

import 'package:factor_flutter_mobile/controllers/factor_unofficial_specification/factor_unofficial_specification_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/buyer/buyer_page.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/widgets/custom_pdf_widget.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/widgets/factor_unofficial_specification_add_or_edit_dialog.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/widgets/factor_unofficial_specification_select_item.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/bottom_sheet_total_price_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/expandable/factor_expandable.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/show_pdf/show_pdf_view.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/src/extensions.dart';
import 'package:printing/printing.dart';

class FactorUnofficialSpecificationPage
    extends GetView<FactorUnofficialSpecificationController> {
  FactorUnofficialSpecificationPage({Key? key}) : super(key: key);

  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;
    final factorUnofficialItemList = arguments['factorUnofficialItemList'];
    final totalPrice = arguments['totalPrice'];
    final totalWordPrice = arguments['totalWordPrice'];
    final discount = arguments['discount'];
    final taxation = arguments['taxation'];
    Get.lazyPut(() => FactorUnofficialSpecificationController(
        factorUnofficialItemList: factorUnofficialItemList,
        totalPrice: totalPrice,
        totalWordPrice: totalWordPrice,
        discount: discount,
        taxation: taxation));
  }

  Future<void> computeFuture = Future.value();

  @override
  Widget build(BuildContext context) {
    initArguments();
    return Obx(() {
      return Scaffold(
        appBar: FactorAppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              controller.offsetScroll > 30
                  ? controller.factorHeaderViewModel.value?.title ??
                      'عنوان فاکتور'
                  : '',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              _headerFactor(context),
              Constants.largeVerticalSpacer,
              _ownerItem(),
              Constants.largeVerticalSpacer,
              _buyerItem(),
              Constants.largeVerticalSpacer,
              _excessCostListItem(),
              _cashListItem(),
              _cartListItem(),
              _onlinePayListItem(),
              _checkPayListItem(),
              Constants.largeVerticalSpacer,
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton(),
        bottomNavigationBar: _bottomNavigationBar(),
      );
    });
  }

  Widget _checkPayListItem() {
    return FactorUnofficialSpecificationSelectItem(
      icon: const Icon(Icons.book_outlined),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
      ],
      textInputType: TextInputType.phone,
      topTextFormFieldLabel: 'شماره سریال',
      bottomTextFormFieldLabel: 'مبلغ',
      statusFunction: () => controller.statusFunction(),
      title: 'پرداخت چکی ',
      hasCustomBeforeTitle: true,
      customBeforeTitle: 'شماره سریال',
      bracesWord: 'چک و سفته ...',
      itemList: controller.checkPayList,
      onTap: () async {
        final result =
            await Get.dialog(FactorUnofficialSpecificationAddOrEditDialog(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
          textInputType: TextInputType.phone,
          topTextFormFieldLabel: 'شماره سریال',
          bottomTextFormFieldLabel: 'مبلغ',
          titleDialog: 'پرداخت چکی',
          specificationCostList: controller.checkPayList,
          specificationCostItem: null,
        ));
        if (result == true) {
          controller.statusFunction();
        }
      },
    );
  }

  Widget _onlinePayListItem() {
    return FactorUnofficialSpecificationSelectItem(
      icon: const Icon(Icons.book_online_outlined),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      textInputType: TextInputType.phone,
      topTextFormFieldLabel: 'شماره پیگیری',
      statusFunction: () => controller.statusFunction(),
      title: 'پرداخت آنلاین ',
      bracesWord: 'اینترنتی و ...',
      hasCustomBeforeTitle: true,
      itemList: controller.onlinePayList,
      onTap: () async {
        final result =
            await Get.dialog(FactorUnofficialSpecificationAddOrEditDialog(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          textInputType: TextInputType.phone,
          topTextFormFieldLabel: 'شماره پیگیری',
          titleDialog: 'پرداخت آنلاین',
          specificationCostList: controller.onlinePayList,
          specificationCostItem: null,
        ));
        if (result == true) {
          controller.statusFunction();
        }
      },
    );
  }

  Widget _cartListItem() {
    return FactorUnofficialSpecificationSelectItem(
      icon: const Icon(Icons.credit_card),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
      ],
      textInputType: TextInputType.phone,
      topTextFormFieldLabel: 'شماره پیگیری',
      statusFunction: () => controller.statusFunction(),
      title: 'پرداخت کارتی ',
      hasCustomBeforeTitle: true,
      bracesWord: 'کارت بانکی و پوز و...',
      itemList: controller.cartList,
      onTap: () async {
        final result =
            await Get.dialog(FactorUnofficialSpecificationAddOrEditDialog(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
          textInputType: TextInputType.phone,
          topTextFormFieldLabel: 'شماره پیگیری',
          titleDialog: 'پرداخت کارتی',
          specificationCostList: controller.cartList,
          specificationCostItem: null,
        ));

        if (result == true) {
          controller.statusFunction();
        }
      },
    );
  }

  Widget _cashListItem() {
    return FactorUnofficialSpecificationSelectItem(
      icon: const Icon(Icons.monetization_on_outlined),
      statusFunction: () => controller.statusFunction(),
      title: 'پرداخت نقدی ',
      bracesWord: 'پول نقد و ...',
      itemList: controller.cashList,
      onTap: () async {
        final result =
            await Get.dialog(FactorUnofficialSpecificationAddOrEditDialog(
          titleDialog: 'پرداخت نقدی',
          specificationCostList: controller.cashList,
          specificationCostItem: null,
        ));

        if (result == true) {
          controller.statusFunction();
        }
      },
    );
  }

  Widget _excessCostListItem() {
    return FactorUnofficialSpecificationSelectItem(
      icon: const Icon(Icons.bike_scooter),
      statusFunction: () => controller.statusFunction(),
      title: 'هزینه مازاد ',
      bracesWord: 'هزینه ارسال و ...',
      itemList: controller.excessCostList,
      onTap: () async {
        print(
            'controller.totalPriceAllItems1()${controller.totalPriceAllItems()}');
        final result =
            await Get.dialog(FactorUnofficialSpecificationAddOrEditDialog(
          titleDialog: 'هزینه مازاد',
          specificationCostList: controller.excessCostList,
          specificationCostItem: null,
        ));
        if (result == true) {
          controller.statusFunction();
        }
      },
    );
  }

  Widget _buyerItem() {
    return FactorUnofficialSpecificationSelectItem(
        itemList: controller.emptyList,
        statusFunction: () {},
        title: 'طرف حساب ',
        bracesWord: 'مشتری',
        isSelectedName: controller.isSelectedBuyerName.value,
        selectedText: controller
                .buyerItem.value?.personBasicInformationViewModel.fullName ??
            controller
                .buyerItem.value?.personBasicInformationViewModel.companyName ??
            '',
        onTap: () async {
          final result = await Get.toNamed(FactorRoutes.buyer,
              arguments:
                  const BuyerPage().arguments(isEnterFromSpecificFactor: true));
          if (result != null) {
            controller.buyerItem.value = result;
            controller.isSelectedBuyerName.value = true;
          }
        });
  }

  Widget _ownerItem() {
    return FactorUnofficialSpecificationSelectItem(
      itemList: controller.emptyList,
      statusFunction: () {},
      isSelectedName: controller.isMyProfileItemNull.value,
      selectedText: ownerTitleName(),
      // controller.myProfileItem.value !=
      //         null?.personBasicInformationViewModel.isHaghighi
      //     ? controller.myProfileItem.value?.personBasicInformationViewModel
      //             .fullName ??
      //         ''
      //     : controller.myProfileItem.value?.personBasicInformationViewModel
      //             .companyName ??
      //         '',
      title: 'صاحب حساب ',
      bracesWord: 'فروشنده',
      onTap: () async {
        final result = await Get.toNamed(
          FactorRoutes.myProfile,
        );

        if (result != null) {
          controller.loadMyProfileData();
        }
      },
    );
  }

  String ownerTitleName() {
    if (controller.myProfileItem.value != null) {
      if (controller
          .myProfileItem.value!.personBasicInformationViewModel.isHaghighi) {
        return controller
            .myProfileItem.value!.personBasicInformationViewModel.fullName!;
      } else {
        return controller
            .myProfileItem.value!.personBasicInformationViewModel.companyName!;
      }
    } else {
      return 'صاحب حساب';
    }
  }

  Widget _bottomNavigationBar() {
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: heightBottomSheet(),
        child: Wrap(
          children: [
            InkWell(
              child:
                  // FutureBuilder(
                  //   future: controller.computeFuture,
                  //   builder: (context, snapShot) =>

                  BottomSheetTotalPriceWidget(
                bottomButtonOnTap: () async {
                  computeFuture = _createPdf().then((value) {
                    Get.back();
                    Get.to(ShowPdfView(pdfView: value));
                  });
                  // final pdfView = await _createPdf();
                  //
                  //
                  // Get.to(ShowPdfView(pdfView: pdfView));
                  // controller.isLoadingCreatePdf(false);
                },
                statusBracketKeyText: controller.statusBracketKeyText(),
                taxation: controller.taxation,
                discount: controller.discount,
                totalPrice: controller
                        .totalPriceAllItems()
                        .toStringAsFixed(2)
                        .seRagham()
                        .replaceAll(RegExp('-'), '') +
                    ' ریال',
                // totalPrice: controller.totalPrice.value
                //         .toStringAsFixed(2)
                //         .seRagham()
                //         .replaceAll(RegExp('-'), '') +
                //     ' ریال',
                totalWordPrice: controller.totalWordPrice,
                onTap: () {
                  controller.isExpandedBottomSheet.value =
                      !controller.isExpandedBottomSheet.value;
                },
              ),
              // ),
            ),
          ],
        ),
      );
    });
  }

  Future<Uint8List> _createPdf() async {
    controller.isLoadingCreatePdf(true);
    final font = await rootBundle
        .load("assets/fonts/iran_sans/IRANSansMobile_Medium.ttf");
    final ttf = pw.Font.ttf(font);

    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: ttf,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            CustomPdfWidget().pdfWidget(
              totalPrice: controller.totalPriceAllItems().value,
              totalDiscount: controller.discount,
              totalTaxation: controller.taxation,
              myProfileItem: controller.myProfileItem,
              factorHeaderViewModel: controller.factorHeaderViewModel,
              factorUnofficialItemList: controller.factorUnofficialItemList,
              buyerItem: controller.buyerItem,
              statusFactor: controller.statusBracketKeyText.value,
            )
          ]; // Center
        }));

    // final Future<Uint8List> pdfBytes = pdf.save();

    // pdfBytes.then((value) => _pathFile(value));

    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('در حال آماده سازی پی دی اف '),
              Constants.largeVerticalSpacer,
              const LinearProgressIndicator(color: Colors.black),
            ])),
      ),
      barrierDismissible: false,
    );

    return await compute(pdfSaveBytesIsolate, pdf);
  }

  static Future<Uint8List> pdfSaveBytesIsolate(pw.Document pdf) {
    return pdf.save();
  }

  Future<void> _pathFile(Uint8List pdfView) async {
    if (kIsWeb) {
      await Printing.sharePdf(
        bytes: pdfView,
        filename: 'my-document.pdf',
      );
    } else {
      MimeType type = MimeType.PDF;
      await FileSaver.instance.saveAs("File", pdfView, "pdf", type);
    }
  }

  Widget _floatingActionButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 8.0,
      ),
      child: SizedBox(
        width: 30,
        height: 30,
        child: FloatingActionButton(
            onPressed: () {
              controller.isExpandedBottomSheet.value =
                  !controller.isExpandedBottomSheet.value;
            },
            child: FactorExpandIcon(
              isExpanded: controller.isExpandedBottomSheet.value,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _headerFactor(BuildContext context) {
    return Container(
      color: Colors.black,
      child: InkWell(
        onTap: () async {
          final result = await Get.toNamed(
            FactorRoutes.factorHeader,
          );
          if (result != null) {
            controller.loadFactorHeaderData();
          }
        },
        child: Column(
          children: [
            Constants.smallVerticalSpacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.factorHeaderViewModel.value?.title ??
                      'فاکتور فروش',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 37),
                ),
                Constants.tinyHorizontalSpacer,
                if (controller.factorHeaderViewModel.value?.isBeforeFactor ??
                    false)
                  const Text('(پیش فاکتور)',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                Constants.smallHorizontalSpacer,
                const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ],
            ),
            Constants.largeVerticalSpacer,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Text(
                    'تاریخ فاکتور : ${controller.factorHeaderViewModel.value?.factorDate ?? Jalali.now().formatCompactDate()}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 30),
                  child: Text(
                    ' ${controller.factorHeaderViewModel.value?.factorNum ?? '1'} #',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            Constants.smallVerticalSpacer,
          ],
        ),
      ),
    );
  }

  double heightBottomSheet() {
    if (controller.factorUnofficialItemList.isEmpty) {
      return 0;
    } else if (controller.isExpandedBottomSheet.value) {
      return 225;
    } else {
      return 50;
    }
  }

  Map arguments(
      {required RxList<FactorUnofficialItemViewModel> factorUnofficialItemList,
      required RxDouble totalPrice,
      required String totalWordPrice,
      required String discount,
      required String taxation}) {
    final map = {};
    map['factorUnofficialItemList'] = factorUnofficialItemList;
    map['totalPrice'] = totalPrice;
    map['totalWordPrice'] = totalWordPrice;
    map['discount'] = discount;
    map['taxation'] = taxation;
    return map;
  }
}
